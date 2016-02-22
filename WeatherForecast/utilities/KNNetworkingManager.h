//
//  KNNetworkingManager.h
//  Demo01-MVCS
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
//方式二
typedef void(^successBlock)(id responseObject);
typedef void(^failureBlock)(NSError *error);
@interface KNNetworkingManager : NSObject
//方式一
@property (nonatomic, copy) void(^successBlock)(id responseObject);
//block 在栈空间  内存用完会删除，用copy则会自动拷贝一份

//


//block 没有传参，没有返回值


+ (void)sendGetRequestWithURL:(NSString *)urlStr parameters:(NSDictionary *)paramDic Success:(successBlock)success Failure:(failureBlock)failure;

@end
