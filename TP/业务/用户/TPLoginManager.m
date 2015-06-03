//
//  TPLoginManager.m
//  TP
//
//  Created by moxin on 15/6/1.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPLoginManager.h"
#import "TPLoginViewController.h"

@implementation TPLoginManager


- (id)init
{
    self = [super init];
    
    if(self)
    {
  

        
    }
    return self;
}

+ (void)showLoginViewControllerWithCompletion:(void (^)(void))completion
{
    if ([TPUser isLogined]) {
        return;
    }
    else
    {
        
        void(^presentLoginVC)(void) = ^{
            
            TPLoginViewController* loginVC = [TPLoginViewController new];
            UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:loginVC];
             [[TPUtils rootViewController] presentViewController:nav animated:YES completion:nil];
        };
        
        
        
        if ([[TPUtils rootViewController] presentingViewController]) {
            
            [[TPUtils rootViewController] dismissViewControllerAnimated:YES completion:^{
                presentLoginVC();
            }];
        }
        else
        {
            presentLoginVC();
        }
    }
}


@end
