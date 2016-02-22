//
//  KNDaily.h
//  WeatherForecast
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNDaily : NSObject


//日期
@property (nonatomic, strong) NSString *date;
//最高温度~需要显示到label，text 使用string最好，可以直接赋值，即使没有双引号，在工具中转格式也比在控制器转格式要看的舒服

@property (nonatomic, strong) NSString *maxtempC;
@property (nonatomic, strong) NSString *mintempC;
@property (nonatomic, strong) NSString *iconURL;
//setValueforkey 不能嵌套

//给定么诶天字典，返回trdaily
+ (KNDaily *)parseDailyByJson:(NSDictionary *)dic;
@end
