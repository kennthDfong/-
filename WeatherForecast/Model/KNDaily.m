//
//  KNDaily.m
//  WeatherForecast
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import "KNDaily.h"

@implementation KNDaily

+ (KNDaily *)parseDailyByJson:(NSDictionary *)dic {
    return [[self alloc] parseDailyByJson:dic];
}



//第三方库：（解析、赋值、嵌套） YYModel/,JExtention
- (KNDaily *)parseDailyByJson:(NSDictionary *)dic {
    self.maxtempC = [NSString stringWithFormat:@"%@˚",dic[@"maxtempC"]];
    self.mintempC = [NSString stringWithFormat:@"%@˚",dic[@"mintempC"]];
                     
    self.date = dic[@"date"];
    //这里应该需要确定实时天气最好
    self.iconURL = dic[@"hourly"][0][@"weatherIconUrl"][0][@"value"];
    return self;
}
@end
