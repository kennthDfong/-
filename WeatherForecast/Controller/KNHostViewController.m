//
//  KNHostViewController.m
//  WeatherForecast
//
//  Created by apple on 16/1/16.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import "KNHostViewController.h"
#import "KNHeaderView.h"
#import "RESideMenu.h"
#import "KNDataManager.h"
#import <CoreLocation/CoreLocation.h>
#import "KNLocationManager.h"
#import "KNNetworkingManager.h"
#import "TSMessage.h"
#import "KNHourly.h"
#import "KNDaily.h"
#import "UIImageView+WebCache.h"//使用uiimageview 实现图片缓存
#import "KNHeader.h"


//                          http://www.iosfonts.com




@interface KNHostViewController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)CLLocation *userLocation;
//每天的数据
@property (nonatomic, strong)NSArray *dailyArray;
//每小时的数据
@property (nonatomic, strong)NSArray *hourlyArray;
@property (nonatomic, strong)KNHeaderView *headerView;
@end

@implementation KNHostViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //主逻辑
    [self creatBackGroundView];
    //获取用户的位置并发送请求
    [self getLocationAndSendRequest];
    //===TEST===
   // [self testInfo];
    //创建tableView
    [self creatTableView];
    //创建头部视图
    [self creatHeaderView];
    //开始定位
   
    //监听通知
    [self listenNotification];
    
}


#pragma mark - 创建主视图

- (void)creatTableView {
    self.tableView = [UITableView new];
    self.tableView.frame = [UIScreen mainScreen].bounds;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundView  = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg"]];
    [self.view addSubview:self.tableView];
    //如果设置背景视图不随着table的滚动二滚动，则不能设置tableview的backgroundView
    
    //那么如果使用的是backgroundImage呢？？
    
}


- (void)creatBackGroundView {
    UIImageView *backgroundView= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    //预编译头文件
    //1.创建头文件
    //2.在setting buliding 中修改两个地方/  language中 prefixHeader：YES 还需要增加名字
    backgroundView.frame = SCREEN_BOUNDS;
    
   // [self.view addSubview:backgroundView];
}

- (void)creatHeaderView {
    self.headerView = [[KNHeaderView alloc] initWithFrame:SCREEN_BOUNDS];
    [self.headerView.menuButton addTarget:self action:@selector(clickMeunButton) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableHeaderView = self.headerView;
}

- (void)getLocationAndSendRequest {
    
    [KNLocationManager getUserLocation:^(double lat, double lon) {
        //使用临时变量传参
        CLLocation *location = [[CLLocation alloc]initWithLatitude:lat longitude:lon];
        self.userLocation = location;
            NSString *urlStr = [NSString stringWithFormat:@"http://api.worldweatheronline.com/free/v2/weather.ashx?q=%f,%f&num_of_days=2&format=json&tp=6&key=dbf53b87420a66db2a67823e67d3c",self.userLocation.coordinate.latitude, self.userLocation.coordinate.longitude];
        [self sendRequestToSever:urlStr];
    }];
}

- (void)sendRequestToSever:(NSString *)url {
    //url http://api.worldweatheronline.com/free/v2/weather.ashx?q=%f,%f&num_of_days=2&format=json&tp=6&key=a7bdb4aff27ae387b9db730f56ef4
    //自己url    http://api.worldweatheronline.com/free/v2/weather.ashx?q=%f,%f&num_of_days=2&format=json&tp=6&key=dbf53b87420a66db2a67823e67d3c
   
    //http://api.worldweatheronline.com/free/v2/weather.ashx?q=%f,%f&num_of_days=5&format=json&tp=3&key=5d7248ccaeb080ac0afbdf200000e
    //设置缺省Default的显示控制器
    [TSMessage setDefaultViewController:self];
    

    //NetworkingManager

    
    [KNNetworkingManager sendGetRequestWithURL:url parameters:nil Success:^(id responseObject) {
        
        self.dailyArray = [KNDataManager getAllDailyDataByJson:responseObject];
        self.hourlyArray = [KNDataManager getAllHourlyDataByJson:responseObject];
        [self setLoadDataToheaderView:responseObject];
        [self.tableView reloadData];
    } Failure:^(NSError *error) {
        //
        NSLog(@"服务器返回失败%@", error.userInfo);
        //将失败信息返回到界面中
        //使用第三方库 TSMessage
        //设置缺省Default的显示控制器
        //显示通知给用户
        [TSMessage showNotificationWithTitle:@"提示" subtitle:@"请稍后再试" type:TSMessageNotificationTypeWarning];
    }];
     
    
}

- (void)listenNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
 
    //添加一个观察者～object接受某一个对象传过来的通知，nil指任意对象传过来@“..”
    [center addObserver:self selector:@selector(listenChangeCity:) name:@"DidCityChange" object:nil];
    
}

- (void)listenChangeCity:(NSNotification *)notification {
    NSString *cityName =  notification.userInfo[@"city"];
  
    NSString *cityNamePinYin = [self transformToPinyin:cityName];
    
    NSLog(@"%@", cityNamePinYin);
    NSString *url =  [NSString stringWithFormat:@"http://api.worldweatheronline.com/free/v2/weather.ashx?q=%@&num_of_days=5&format=json&tp=3&key=dbf53b87420a66db2a67823e67d3c", cityNamePinYin];
    
    [self sendRequestToSever:url];
    
}

// /*====================TEST=============================================
- (void)testInfo {
    NSString *path = [[NSBundle mainBundle]pathForResource:@"weather.json" ofType:nil];
    
    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    self.dailyArray = [KNDataManager getAllDailyDataByJson:responseObject];
    
    self.hourlyArray = [KNDataManager getAllHourlyDataByJson:responseObject];

    [self setLoadDataToheaderView:responseObject];
}
//   ========================TEST============================================*/



- (NSString *)transformToPinyin:(NSString *)str {
    NSMutableString *mutableString = [NSMutableString stringWithString:str];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    mutableString = (NSMutableString *)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    return [mutableString stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (void)setLoadDataToheaderView:(id)responseObject {
    KNHeader *header = [KNHeader parseHeaderItemByJson:responseObject];
    self.headerView.cityLabel.text = header.query;
    
    self.headerView.confitionLabel.text = header.weatherDesc;
    self.headerView.temperatureLabel.text = header.tempC;
    self.headerView.hiloLabel.text = [NSString stringWithFormat:@"%@ / %@", header.mintempC, header.maxtempC];
    
    //self.headerView.iconView.image = [UIImage imageNamed:@""];
    [self.headerView.iconView sd_setImageWithURL:[NSURL URLWithString:header.iconUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];

}


/* =====================================================================
- (NSString *)transformToPinyin:(NSString *)str {
    NSMutableString *mutableString = [NSMutableString stringWithString:str];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformStripDiacritics, false);
    return [mutableString stringByReplacingOccurrencesOfString:@" " withString:@""];}

 =========================================================================  */
#pragma mark - 按钮的方法

- (void)clickMeunButton {
    //显示左边的控制器
    [self.sideMenuViewController presentLeftMenuViewController];
    
}




#pragma mark - UITableView Methods 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%ld,%ld", self.hourlyArray.count, self.dailyArray.count);
    return section == 0 ? self.hourlyArray.count + 1: self.dailyArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *indetifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indetifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indetifier];
    }
    

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"hourlyForecast Info.";
            //cell重用导致detailTextLabel.text会显示一些东西
            cell.detailTextLabel.text = nil;
            cell.imageView.image = nil;
        } else {
            KNHourly *hourly = self.hourlyArray[indexPath.row - 1];
            cell.textLabel.text = hourly.time;
            //下载图片要用子线程
            /*  NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:hourly.iconUrl]];
            cell.imageView.image = [UIImage imageWithData:data];
             */
            cell.detailTextLabel.text = hourly.tempC;
            
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:hourly.iconUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            //第二个参数是占位图片
        }
    } else {
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = nil;
            cell.imageView.image = nil;
            cell.textLabel.text = @"dailyForecast Info.";
        } else {
            KNDaily *daily = self.dailyArray[indexPath.row - 1];
            cell.textLabel.text = daily.date;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ / %@",daily.mintempC, daily.maxtempC];
            //下载图片要用子线程
            //需要防止重复下载，使用图片缓存原理
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:daily.iconURL] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        }
    }
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    //这里是在上面的方法进行过之后再运行的吗？
    NSInteger rowCount = [self tableView:tableView numberOfRowsInSection:indexPath.section];
    
    
    return SCREEN_HEIGHT / rowCount;
}




@end
