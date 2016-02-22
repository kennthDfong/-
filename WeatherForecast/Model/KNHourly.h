//
//  KNHourly.h
//  WeatherForecast
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNHourly : NSObject
@property (nonatomic, strong) NSString *tempC;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *iconUrl;

+ (KNHourly *)parseHourlyByJson:(NSDictionary *)dic;
@end
