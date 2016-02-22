//
//  KNLocationManager.h
//  WeatherForecast
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
typedef void(^saveLocationBlock)(double lat, double lon);

@interface KNLocationManager : NSObject

+ (void)getUserLocation:(void(^)(double lat, double lon))locationBlock;


//+ (void)testBlock:(saveLocationBlock)locationBlock;
@end
