//
//  KNHourly.m
//  WeatherForecast
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import "KNHourly.h"

@implementation KNHourly

+ (KNHourly *)parseHourlyByJson:(NSDictionary *)dic {
    return [[self alloc]parseHourlyByJson:dic];
}

- (KNHourly *)parseHourlyByJson:(NSDictionary *)dic {
    self.tempC =[NSString stringWithFormat:@"%@˚", dic[@"tempC"]];
    NSString *time = dic[@"time"];
      NSMutableString *str = [NSMutableString stringWithString:time];
    if (time.length == 3) {
      
        [str insertString:@":" atIndex:1];
    } else {
        [str insertString:@":" atIndex:2];
    }
    
    self.time = [str copy];
    self.iconUrl = dic[@"weatherIconUrl"][0][@"value"];
    return self;
    
}
@end
