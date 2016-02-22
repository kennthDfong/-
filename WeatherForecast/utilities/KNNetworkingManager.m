//
//  KNNetworkingManager.m
//  Demo01-MVCS
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import "KNNetworkingManager.h"
#import "AFNetworking.h"
@implementation KNNetworkingManager


+ (void)sendGetRequestWithURL:(NSString *)urlStr parameters:(NSDictionary *)paramDic Success:(successBlock)success Failure:(failureBlock)failure {
    
    //和AFNetworking相关的调用
    
    
    AFHTTPSessionManager *manager =  [AFHTTPSessionManager manager];
    
    [manager GET:urlStr parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
}

@end
