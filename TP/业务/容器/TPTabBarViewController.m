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
    
    __observeNotify(@selector(prepare),kTPNofityMessageSwitchIdentity);
    __observeNotify(@selector(prepare), kTPNotifyMessageLogout);
    __observeNotify(@selector(tokenInvalid), kTPNotifyMessageTokenInvalid);
    
    [self prepare];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepare
{

    UITabBarItem* a = [[UITabBarItem alloc]initWithTitle:@"" image:[[UIImage imageNamed:@"trip_nav_r.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  selectedImage:[[UIImage imageNamed:@"trip_nav_r_A.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    a.imageInsets = UIEdgeInsetsMake(5, 5, -5, -5);
    a.titlePositionAdjustment = UIOffsetMake(0, 12.0);

    UITabBarItem* b = [[UITabBarItem alloc]initWithTitle:@"" image:[[UIImage imageNamed:@"trip_nav_m.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"trip_nav_m_A.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    b.imageInsets = UIEdgeInsetsMake(5, 5, -5, -5);
    b.titlePositionAdjustment = UIOffsetMake(0, 12.0);
    
    UITabBarItem* c = [[UITabBarItem alloc]initWithTitle:@"" image:[[UIImage imageNamed:@"trip_nav_j.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"trip_nav_j_A.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    c.imageInsets = UIEdgeInsetsMake(5, 5, -5, -5);
    c.titlePositionAdjustment = UIOffsetMake(0, 12.0);
    
    UITabBarItem* d = [[UITabBarItem alloc]initWithTitle:@"" image:[[UIImage imageNamed:@"trip_nav_p.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"trip_nav_p_A.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    d.imageInsets = UIEdgeInsetsMake(5, 5, -5, -5);
    d.titlePositionAdjustment = UIOffsetMake(0, 12.0);
    
    UIViewController* messages      = [TPMessageListViewController new];
    UIViewController* trip          = [TPTripListViewController new];
    UIViewController* me            = [[UIStoryboard storyboardWithName:@"TPMeViewController" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"me"];
    UIViewController* first = nil;
    
    if ([TPUser type] == kCustomer) {
        
        first = [TPDiscoveryListViewController new];
    }
    else if ([TPUser type] == kProvider)
    {
        first = [TPMyServiceListViewController new];
    }
    else
    {
        [TPUser changeUserType:kCustomer];
        first = [TPDiscoveryListViewController new];
    }
    
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
    
    [self setSelectedIndex:0];
    
}

- (void)tokenInvalid
{
    [TPUser logout];
    [self prepare];
}


@end
