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
#import "Pingpp.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    [NSThread sleepForTimeInterval:1.5];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.window.frame =  CGRectMake(0,20,self.window.frame.size.width,self.window.frame.size.height-20);
        UIApplication *myApp = [UIApplication sharedApplication];
        [myApp setStatusBarStyle: UIStatusBarStyleLightContent];
    }
    
    TPTabBarViewController* rootViewController = [TPTabBarViewController new];
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [UIScreen mainScreen].bounds.size.height)];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];

    //SMS
    [SMS_SDK registerApp:sms_appKey
              withSecret:sms_appSecret];
    
    //注册分享
    [UMSocialData setAppKey:um_appKey];
    [UMSocialWechatHandler setWXAppId:wx_appId appSecret:wx_appSecret url:@"http://www.cuitrip.com"];
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
    [UMSocialData defaultData].extConfig.wechatSessionData.shareImage = __image(@"icon.png");
    

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
    
    // 注册友盟统计 channelId默认AppStore渠道
    [MobClick startWithAppkey:um_appKey reportPolicy:BATCH channelId:@""];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    
    
    Class cls = NSClassFromString(@"UMANUtil");
    SEL deviceIDSelector = @selector(openUDIDString);
    NSString *deviceID = nil;
    if(cls && [cls respondsToSelector:deviceIDSelector]){
        deviceID = [cls performSelector:deviceIDSelector];
    }
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:@{@"oid" : deviceID}
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    NSLog(@"%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    
    
#if DEBUG
    [VZInspector setClassPrefixName:@"TP"];
    [VZInspector setShouldHandleCrash:true];
    [VZInspector setShouldHookNetworkRequest:true];
    [VZInspector setObserveCallback:^NSString *{
       
        return [TPUser debugInfo];
        
    }];
    [VZInspector showOnStatusBar];
    
#endif
    
    [TPTheme config];
 
    return YES;
}


//
//- (void) viewDidLayoutSubviews {
//    CGRect viewBounds = self.view.bounds;
//    CGFloat topBarOffset = self.topLayoutGuide.length;
//    viewBounds.origin.y = topBarOffset * -1;
//    self.view.bounds = viewBounds;
//}

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
//- (BOOL)application:(UIApplication *)application
//            openURL:(NSURL *)url
//  sourceApplication:(NSString *)sourceApplication
//         annotation:(id)annotation
//{
//    return  [UMSocialSnsService handleOpenURL:url];
//}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    [Pingpp handleOpenURL:url
           withCompletion:^(NSString *result, PingppError *error) {
               if ([result isEqualToString:@"success"]) {
                   // 支付成功
                   NSLog(@"Pingpp is success test");
               } else {
                   // 支付失败或取消
                   NSLog(@"Error test23 m, : code=%lu msg=%@", error.code, [error getMsg]);
               }
           }];
    
    return  [UMSocialSnsService handleOpenURL:url];
    //    return  YES;
}


@end
