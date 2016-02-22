//
//  KNDataManager.h
//  WeatherForecast
//
//  Created by apple on 16/1/16.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KNCitiyGroup.h"

@interface KNDataManager : NSObject
+ (NSArray *)getAllCityGroups;
//返回所有每天的数组（KNDaily）
+ (NSArray *)getAllDailyDataByJson:(id)responseObject;

+ (NSArray *)getAllHourlyDataByJson:(id)responseObject;
@end
