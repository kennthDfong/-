//
//  KNHeader.h
//  WeatherForecast
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNHeader : NSObject
@property (nonatomic, strong)NSString *query;
@property (nonatomic, strong)NSString *maxtempC;
@property (nonatomic, strong)NSString *mintempC;
@property (nonatomic, strong)NSString *tempC;
@property (nonatomic, strong)NSString *iconUrl;
@property (nonatomic, strong)NSString *weatherDesc;

+ (id)parseHeaderItemByJson:(NSDictionary *)AllItemDic;
@end
