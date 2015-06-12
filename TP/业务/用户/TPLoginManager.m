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

+ (void)autoLogin
{

}

+ (void)showLoginViewControllerWithCompletion:(void (^)(NSError *))completion
{
    if ([TPUser isLogined]) {
        return;
    }
    else
    {
        
        void(^presentLoginVC)(void) = ^{
            
            TPLoginViewController* loginVC = [[UIStoryboard storyboardWithName:@"TPLoginViewController" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"tplogin"];
            loginVC.loginResult = completion;
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

+ (void)hideLoginViewController
{
    [[TPUtils rootViewController] dismissViewControllerAnimated:true completion:nil];
}

+ (void)loginWithCompletion:(void(^)(NSError* error))completion
{
//    
//    [[VZHTTPNetworkAgent sharedInstance] HTTP:@"" params:@{} completionHandler:^(VZHTTPConnectionOperation *connection, NSString *responseString, id responseObj, NSError *error) {
//       
//        if (!error)
//        {
//            [TPUser update:responseObj];
//            
//            if (completion) {
//                completion(nil);
//            }
//        }
//        else
//        {
//            if (completion) {
//                completion(error);
//            }
//        }
//    }];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //test
        TPUserType oldUserType = [TPUser type];
        NSDictionary* dict = @{@"token":@"12"};
        [TPUser update:dict];
        [TPUser changeUserType:oldUserType];
        
        if (completion) {
            completion(nil);
        }
    });
}

+ (void)logout
{
    [TPUser logout];
}

@end
