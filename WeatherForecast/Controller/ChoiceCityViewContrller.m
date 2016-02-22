//
//  ChoiceCityViewContrller.m
//  WeatherForecast
//
//  Created by apple on 16/1/16.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import "ChoiceCityViewContrller.h"
#import "KNDataManager.h"
#import "KNCitiyGroup.h"
@interface ChoiceCityViewContrller ()
@property (nonatomic, strong)NSArray *cityGroups;
@end

@implementation ChoiceCityViewContrller

- (NSArray *)cityGroups {
    if (!_cityGroups) {
        _cityGroups = [KNDataManager getAllCityGroups];
    }
    return _cityGroups;
}
static NSString *identifier = @"cityGroupCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"城市列表";
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(clickBackButton)];
    
    self.navigationItem.leftBarButtonItem = backButton;
    //实验证明在这里注册了，下面reuse中使用没有indexPath的也是可以的
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
}

- (void)clickBackButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cityGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    KNCitiyGroup *group = self.cityGroups[section];
    
    return group.cities.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    KNCitiyGroup *group = self.cityGroups[indexPath.section];
    
    cell.textLabel.text = group.cities[indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    KNCitiyGroup *cityGroup = self.cityGroups[section];
    return cityGroup.title;
}

//返回数组

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    /*方式一
     NSMutableArray *titleMutableArray = [NSMutableArray array];
    for (KNCitiyGroup *group in self.cityGroups) {
        [titleMutableArray addObject: group.title];
    }
    return [titleMutableArray copy];
     */
    
    //方式二
    return [self.cityGroups valueForKey:@"title"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];

        KNCitiyGroup *group = self.cityGroups[indexPath.section];
    [center postNotificationName:@"DidCityChange" object:self userInfo:@{@"city":group.cities[indexPath.row]}];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
