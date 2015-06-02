//
//  TPTheme.m
//  TP
//
//  Created by moxin on 15/6/2.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPTheme.h"

@implementation TPTheme

+ (UIColor* )navBar
{
    return [UIColor colorWithRed:36/255.0 green:194/255.0 blue:213/255.0 alpha:1];
}

+ (UIColor* )themeColor
{
    return [self navBar];
}

+ (UIColor* )bgColor
{
    return [UIColor colorWithRed:189.0/255.0 green:247/255.0 blue:251/255.0 alpha:1];
}

+ (UIColor* )subTitleColor
{
    return [UIColor colorWithRed:155.0/255.0 green:155.0/255.0 blue:155.0/255.0 alpha:1];
}

+ (UIColor* )bar
{
    return [UIColor colorWithRed:255/255.0 green:107/255.0 blue:103/255.0 alpha:1];
}


+ (UIColor* )feedsBlue
{
    return [UIColor colorWithRed:78.0/255.0 green:100.0/255.0 blue:144.0/255.0 alpha:1.0];
}



+ (void)config
{
    //去掉高斯模糊
    if([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        
        [UINavigationBar appearance].translucent = NO;
    }
    
    //背景色
    [[UINavigationBar appearance] setBarTintColor:[self navBar]];
    
    //title
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                           nil]];
    
    //返回
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    //状态栏
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
@end
