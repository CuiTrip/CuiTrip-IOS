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
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
    [TPTheme config];
    
    
    [SMS_SDK registerApp:appKey
              withSecret:appSecret];
    
    return YES;

}



@end
