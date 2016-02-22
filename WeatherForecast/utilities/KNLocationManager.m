//
//  KNLocationManager.m
//  WeatherForecast
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import "KNLocationManager.h"

@interface KNLocationManager ()<CLLocationManagerDelegate>
@property (nonatomic, strong)CLLocationManager *manager;
@property (nonatomic, copy)void (^saveLocationBlock)(double lat, double lon);
@end

@implementation KNLocationManager

//懒加载的方式初始化

+ (id)shareLocationManager {
   
    static KNLocationManager *locationManager = nil;
    if (locationManager == nil) {
         locationManager =[[KNLocationManager alloc]init];
    }
    return locationManager;
}

+ (void)getUserLocation:(void (^)(double, double))locationBlock {
    KNLocationManager *manager = [KNLocationManager shareLocationManager];
    
    [manager getUserLocation:locationBlock];
    
//    KNLocationManager *manager = [KNLocationManager new];
//    manager.mgr = [CLLocationManager new];
//    if ([[UIDevice new].systemVersion doubleValue] > 8.0) {
//        [manager.mgr requestWhenInUseAuthorization];
//    }
//    //定位开始
//    manager.mgr.delegate = manager;
//    [manager.mgr startUpdatingLocation];
    
}

- (id)init {
    if (self = [super init]) {
        //初始化Manager
        self.manager = [CLLocationManager new];
        //判断iOS的版本
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            [self.manager requestWhenInUseAuthorization];
        }
        self.manager.delegate = self;
    }
    return self;
}

-  (void)getUserLocation:(void(^)(double, double))locationBlock {
    //用户没有同意/没有开启定位功能
    if (![CLLocationManager locationServicesEnabled]) {
        //告诉用户消息无法定位
        return;
    }
    //是指经度（调用频率）
    self.manager.distanceFilter = 500;
    //同意/开始 -> 开始定位
    [self.manager startUpdatingLocation];
    //!!!!!将saveLocationBlock赋值给locaitonBlock
    _saveLocationBlock = [locationBlock copy];
    //copy 防止location变了，_save也发生变化
    
    //因为block在栈空间中，最好是copy
}


#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    //防止调用多次
    //经纬度
    CLLocation *location = locations.lastObject;
    
    //给属性saveLoactionBlock赋值
    _saveLocationBlock(location.coordinate.latitude, location.coordinate.longitude);
    
    
}

@end
