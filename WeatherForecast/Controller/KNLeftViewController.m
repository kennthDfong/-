//
//  KNLeftViewController.m
//  WeatherForecast
//
//  Created by apple on 16/1/16.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import "KNLeftViewController.h"
#import "ChoiceCityViewContrller.h"
@interface KNLeftViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

static CGFloat cellHeight = 50;
@implementation KNLeftViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    //创建tableview
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (SCREEN_HEIGHT - cellHeight ) * 0.5, SCREEN_WIDTH, cellHeight * 2)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    
    //separator 分割线，可以去掉的，这里要去掉
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;



    
    
    [self.view addSubview:tableView];
}

#pragma mark - UITableView DataSource and Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    //因为只有两行，所以没有声明成为属性，或者在外面声明
    NSArray *titles = @[@"切换城市",@"其他"];
    NSArray *images = @[@"IconSettings", @"IconProfile"];
    //按需要配置cell的属性
    cell.textLabel.text = titles[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    //如实设置了下面的~
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //和下面设置的效果为一样
    //cell.selectedBackgroundView = [UIView new];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellHeight;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ChoiceCityViewContrller *ChoiceCityVC = [ChoiceCityViewContrller new];
        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:ChoiceCityVC];
        [self presentViewController:navController animated:YES completion:Nil];
    }
}
@end
