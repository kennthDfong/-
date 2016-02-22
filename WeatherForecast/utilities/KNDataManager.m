//
//  KNDataManager.m
//  WeatherForecast
//
//  Created by apple on 16/1/16.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import "KNDataManager.h"
#import "KNDaily.h"
#import "KNHourly.h"
@implementation KNDataManager
//静态，全局，值初始化一次
static NSArray *_cityGroups = nil;

+ (NSArray *)getAllCityGroups {
    
    if (!_cityGroups) {
        _cityGroups = [[self alloc] getCityGroup];
    }
    return _cityGroups;
}

- (NSArray *)getCityGroup {
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"cityGroups.plist" ofType:nil];
    
    NSArray *fileArray = [NSArray arrayWithContentsOfFile:plistPath];
    
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (NSDictionary *itemDic in fileArray) {
        KNCitiyGroup *cityGroup = [KNCitiyGroup new];
        [cityGroup setValuesForKeysWithDictionary:itemDic];
        [mutableArray addObject:cityGroup];
    }
    
    return [mutableArray copy];
    
}



#pragma mark getDailyAndHourly
+ (NSArray *)getAllDailyDataByJson:(id)responseObject {
    //获取weather对应的value
    NSDictionary *dataDic =  responseObject[@"data"];
    
    
    NSArray *weatherArray = dataDic[@"weather"];
    //循环
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *dic  in weatherArray) {
        KNDaily *daily =  [KNDaily parseDailyByJson:dic];
        [mutableArray addObject:daily];
    }
    
    return [mutableArray copy];
}

+ (NSArray *)getAllHourlyDataByJson:(id)responseObject {
    NSArray *hourArray  = responseObject[@"data"][@"weather"][0][@"hourly"];
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (NSDictionary *dic in hourArray) {
    KNHourly *hourly = [KNHourly parseHourlyByJson:dic];
        [mutableArray addObject:hourly];
    }
    return [mutableArray copy];
}























@end
