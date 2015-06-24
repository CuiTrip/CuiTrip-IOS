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
#import "TPMessageListItem.h"

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
    
    //注册分享
    [UMSocialData setAppKey:um_appKey];
    [UMSocialWechatHandler setWXAppId:@"wx2af152cb604683bf" appSecret:@"7bcb01993ed6b20c3cdfecd71fae7af5" url:@"http://mp.weixin.qq.com/s?__biz=MzAxNzU2ODIyNg==&mid=206821731&idx=1&sn=9795e734df8a6e48014fb6069f494237#rd"];
    
//    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://mp.weixin.qq.com/s?__biz=MzAxNzU2ODIyNg==&mid=206821731&idx=1&sn=9795e734df8a6e48014fb6069f494237#rd";
//    [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://mp.weixin.qq.com/s?__biz=MzAxNzU2ODIyNg==&mid=206821731&idx=1&sn=9795e734df8a6e48014fb6069f494237#rd";

    
    //注册APNS
    [[TPAPNS sharedInstance] setup:launchOptions];
    
    //push
    if (launchOptions) {
        
        NSDictionary*userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if(userInfo)
        {
            [[TPAPNS sharedInstance] receiveRemoteNotification:userInfo];
        }
    }
    
#if DEBUG
    [VZInspector setClassPrefixName:@"TP"];
    [VZInspector setShouldHandleCrash:true];
    [VZInspector setShouldHookNetworkRequest:true];
    [VZInspector setObserveCallback:^NSString *{
       
        return [TPUser debugInfo];
        
    }];
    [VZInspector showOnStatusBar];
    
#endif
    
 
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [TPLocationManager startLocation];
    [[TPAPNS sharedInstance] registerRemoteNotification];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{

    [[TPAPNS sharedInstance]receiveRemoteNotification:userInfo];
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [[TPAPNS sharedInstance] updateDeviceToken:deviceToken];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}


@end
