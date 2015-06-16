//
//  AppDelegate.m
//  TP
//
//  Created by moxin on 15/5/26.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "AppDelegate.h"
#import "TPRootViewController.h"
#import "TPTabBarViewController.h"
#import "TPDiscoveryListViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    TPTabBarViewController* rootViewController = [TPTabBarViewController new];
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [UIScreen mainScreen].bounds.size.height)];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
    [TPTheme config];
    
    //SMS
    [SMS_SDK registerApp:sms_appKey
              withSecret:sms_appSecret];
    
    //注册APNS
    [[TPAPNS sharedInstance] setup:launchOptions];
    
 
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[TPAPNS sharedInstance] registerRemoteNotification];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //弹框:
    
    
    //跳到消息
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [[TPAPNS sharedInstance] updateDeviceToken:deviceToken];
}


@end
