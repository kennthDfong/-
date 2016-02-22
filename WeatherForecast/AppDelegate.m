//
//  AppDelegate.m
//  WeatherForecast
//
//  Created by apple on 16/1/16.
//  Copyright © 2016年 Strom. All rights reserved.
//

#import "AppDelegate.h"
#import "KNHostViewController.h"
#import "RESideMenu.h"
#import "KNLeftViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //创建window
    self.window = [[UIWindow alloc] initWithFrame:SCREEN_BOUNDS];

    //创建RESildMenu对象（指定内容/左边/右边）
    RESideMenu *sildeViewController = [[RESideMenu alloc]initWithContentViewController:[KNHostViewController new] leftMenuViewController:[KNLeftViewController new] rightMenuViewController:nil];
     //☀️
    //设置左边背景图片~这里是设置左右的北京图都一样
    sildeViewController.backgroundImage = [UIImage imageNamed:@"Stars"];
    
    sildeViewController.contentViewShadowColor = [UIColor blackColor];
    //暂时不知道这里有什么作用
    sildeViewController.contentViewShadowRadius = 10;
    sildeViewController.contentViewShadowEnabled = YES;
//...
    
    self.window.rootViewController = sildeViewController;
    self.window.backgroundColor = [UIColor clearColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
