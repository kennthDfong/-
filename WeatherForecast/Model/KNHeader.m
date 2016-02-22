                                         //
//  KNHeader.m
//  WeatherForecast
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import "KNHeader.h"

@implementation KNHeader
+ (id)parseHeaderItemByJson:(NSDictionary *)AllItemDic {
    return [[self alloc]parseHeaderItemByJson:AllItemDic];
}

- (id)parseHeaderItemByJson:(NSDictionary *)AllItemDic {
    NSDictionary *weatherDic = AllItemDic[@"data"][@"weather"][0];
    self.maxtempC = [NSString stringWithFormat:@"%@˚",weatherDic[@"maxtempC"]];
    self.mintempC = [NSString stringWithFormat:@"%@˚",weatherDic[@"mintempC"]];
    
    self.query = AllItemDic[@"data"][@"request"][0][@"query"];
    
    NSDictionary *currentDic = AllItemDic[@"data"][@"current_condition"][0];
    
    self.tempC = [NSString stringWithFormat:@"%@˚",currentDic[@"temp_C"]];
    self.weatherDesc = currentDic[@"weatherDesc"][0][@"value"];
    self.iconUrl = currentDic[@"weatherIconUrl"][0][@"value"];
    
    return self;
}
@end
