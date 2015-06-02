//
//  TPTabBarViewController.m
//  TP
//
//  Created by moxin on 15/6/1.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPTabBarViewController.h"
#import "TPDiscoveryListViewController.h"
#import "TPMessageListViewController.h"
#import "TPTripListViewController.h"
#import "TPMeViewController.h"
#import "TPMyServiceListViewController.h"

@interface TPTabBarViewController ()

@end

@implementation TPTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self prepare];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepare
{
    
//    UIImage *tabbarBackground = [[UIImage imageNamed:@"tabbar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [[UITabBar appearance] setBackgroundImage:tabbarBackground];
    
    NSDictionary* attr = [NSDictionary dictionaryWithObjectsAndKeys:
                          [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0], NSForegroundColorAttributeName,nil];
    
    NSDictionary* attrSelected = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:119/255.0 green:203/255.0 blue:255/255.0 alpha:1.0],NSForegroundColorAttributeName, nil];
    
    UITabBarItem* a = [[UITabBarItem alloc]initWithTitle:@"发现" image:[[UIImage imageNamed:@"home.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  selectedImage:[[UIImage imageNamed:@"home_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [a setTitleTextAttributes:attr forState:UIControlStateNormal];
    [a setTitleTextAttributes:attrSelected forState:UIControlStateSelected];
    
    UITabBarItem* b = [[UITabBarItem alloc]initWithTitle:@"消息" image:[[UIImage imageNamed:@"record.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"record_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [b setTitleTextAttributes:attr forState:UIControlStateNormal];
    [b setTitleTextAttributes:attrSelected forState:UIControlStateSelected];
    
    
    UITabBarItem* c = [[UITabBarItem alloc]initWithTitle:@"旅程" image:[[UIImage imageNamed:@"discover.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"discover_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [c setTitleTextAttributes:attr forState:UIControlStateNormal];
    [c setTitleTextAttributes:attrSelected forState:UIControlStateSelected];
    
    
    UITabBarItem* d = [[UITabBarItem alloc]initWithTitle:@"我的" image:[[UIImage imageNamed:@"mine.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"mine_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [d setTitleTextAttributes:attr forState:UIControlStateNormal];
    [d setTitleTextAttributes:attrSelected forState:UIControlStateSelected];
    
    
    UIViewController* messages      = [TPMessageListViewController new];
    UIViewController* trip          = [TPTripListViewController new];
    UIViewController* me            = [TPMessageListViewController new];
    
    
    UIViewController* first = nil;
    
    if ([TPUser type] == kCustomer) {
        
        first = [TPDiscoveryListViewController new];
    }
    else if ([TPUser type] == kProvider)
    {
        first = [TPMyServiceListViewController new];
    }
    else
        first = nil;
    
    UINavigationController* firstNav = [[UINavigationController alloc]initWithRootViewController:first];
    firstNav.tabBarItem = a;
    
    
    UINavigationController* secondNav = [[UINavigationController alloc]initWithRootViewController:messages];
    secondNav.tabBarItem = b;
    
    UINavigationController* thirdNav = [[UINavigationController alloc]initWithRootViewController:trip];
    thirdNav.tabBarItem = c;
    
    UINavigationController* forthNav = [[UINavigationController alloc]initWithRootViewController:me];
    forthNav.tabBarItem = d;
    
    if (first) {
        [self setViewControllers:@[firstNav,secondNav,thirdNav,forthNav]];
    }
    
}


@end
