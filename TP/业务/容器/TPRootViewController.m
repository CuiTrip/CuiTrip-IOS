//
//  TPRootViewController.m
//  TP
//
//  Created by moxin on 15/6/1.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPRootViewController.h"
#import "TPTabBarViewController.h"
#import "TPPortalViewController.h"

@interface TPRootViewController ()

@end

@implementation TPRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    //token过期
//    __weak typeof(self) weakSelf = self;
//    [self vz_listOnChannel:__kChannel_token_invalid__ withNotificationBlock:^(id obj, id data) {
//        
//        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [BXUser clearUserInfo];
//            [weakSelf reboot];
//        });
//        
//        [weakSelf.view makeToast:@"抱歉，您的账号已经过期,请重新登录" duration:1.5 position:CSToastPositionCenter];
//        
//        
//    }];
//    
//    
//    //推出登录
//    [self vz_listOnChannel:__kChannel__logout__ withNotificationBlock:^(id obj, id data) {
//        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [BXUser clearUserInfo];
//            [weakSelf reboot];
//        });
//        
//        
//    }];
    
    [self reboot];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)transitionAnimationBegin
{
    CGRect rect = self.contentContainerView.bounds;
    if (self.oldSelectedIndex < self.selectedIndex)
        rect.origin.x = rect.size.width;
    else
        rect.origin.x = -rect.size.width;
    
    self.toViewController.view.frame = rect;
}
- (void)transitionAnimationProceeding
{
    CGRect rect = self.fromViewController.view.frame;
    if (self.oldSelectedIndex < self.selectedIndex)
        rect.origin.x = -rect.size.width;
    else
        rect.origin.x = rect.size.width;
    
    self.fromViewController.view.frame = rect;
    self.toViewController.view.frame = self.contentContainerView.bounds;
}
- (void)transitionAnimationEnd
{
    
}

- (void)selectedIndexDidChange
{
    if (self.selectedIndex == 1) {
        
        UINavigationController* nav = (UINavigationController* )self.selectedViewController;
        TPTabBarViewController* tab = (TPTabBarViewController* )nav.topViewController;
      //  [tab prepare];
        
        UINavigationController* nav2= (UINavigationController* )tab.selectedViewController;
        VZListViewController* main = (VZListViewController* ) nav2.topViewController;
        
        if ([main isKindOfClass:[VZListViewController class]]) {
            //[main load];
        }
        else
        {
            //some things is wrong
            [self.view makeToast:@"出错啦"];
        }
        
    }
}


- (void)reboot
{
    if ([TPUser isLogined]) {
        
        TPTabBarViewController* vc2 = [TPTabBarViewController new];
        
        UINavigationController* tabNav = [[UINavigationController alloc]initWithRootViewController:vc2];
        
        self.viewControllers = @[tabNav];
        
    }
    else
    {
        TPPortalViewController* vc1 =  [TPPortalViewController new];
        UINavigationController* portalNav = [[UINavigationController alloc]initWithRootViewController:vc1];
        
        TPTabBarViewController* vc2 = [TPTabBarViewController new];
        
        //UINavigationController* tabNav = [[UINavigationController alloc]initWithRootViewController:vc2];
        
        self.viewControllers = @[portalNav,vc2];
        
        
    }
    
    [self setSelectedIndex:0 animated:NO];
}

@end
