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

+ (void)showLoginViewControllerWithCompletion:(void (^)(void))completion
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
    [self loginWithMobile:[TPUser mobile] Pwd:[TPUser pwd] ContryCode:[TPUtils defaultLocalCode] Completion:completion];
}

+ (void)loginWithMobile:(NSString* )mobile Pwd:(NSString* )pwd ContryCode:(NSString* )contryCode Completion:(void (^)(NSError *))completion
{
    VZHTTPRequestConfig config = vz_defaultHTTPRequestConfig();
    config.requestMethod = VZHTTPMethodPOST;
    [[VZHTTPNetworkAgent sharedInstance] HTTP:[_API_DEBUG_1_ stringByAppendingString:@"/login"]
                                requestConfig:config
                               responseConfig:vz_defaultHTTPResponseConfig()
                                       params:@{@"mobile":mobile?:@"",
                                                @"passwd":pwd?:@"",
                                                @"countryCode":contryCode?:@""}
                            completionHandler:^(VZHTTPConnectionOperation *connection,
                                                NSString *responseString, id responseObj,
                                                NSError *error) {
                                
                                
                                if (!error) {
                                    
                                    NSString* code = responseObj[@"code"];
                                    
                                    if ([code integerValue] == 0 ) {
                                        
                                        NSDictionary* result = responseObj[@"result"];
                                        
                                        if (IsDictionaryValid(result)) {
                                            [TPUser update:result];
                                        }
                                        if (completion) {
                                            completion(nil);
                                        }
                                    }
                                    else
                                    {
                                        if (completion) {
                                            
                                            NSError* err= [NSError errorWithDomain:@"" code:[code integerValue] userInfo:@{ NSLocalizedDescriptionKey:responseObj[@"msg"]}];
                                            completion(err);
                                        }
                                    }
                               
                                    
                                }
                                else
                                {
                                    if (completion) {
                                        completion(error);
                                    }
                                }
                                
                            }];
}

+ (void)logout
{
    
    VZHTTPRequestConfig config = vz_defaultHTTPRequestConfig();
    config.requestMethod = VZHTTPMethodPOST;
    [[VZHTTPNetworkAgent sharedInstance] HTTP:[_API_DEBUG_1_ stringByAppendingString:@"/logout"]
                                requestConfig:config
                               responseConfig:vz_defaultHTTPResponseConfig()
                                       params:@{@"uid":[TPUser uid]?:@"",
                                                @"token":[TPUser token]?:@""}
                            completionHandler:^(VZHTTPConnectionOperation *connection,
                                                NSString *responseString, id responseObj,
                                                NSError *error) {
                                
                                
                                if (!error) {
                                    
                                    NSString* code = responseObj[@"code"];
                                    
                                    if ([code integerValue] == 0 ) {
                                        
                                        [TPUser logout];
                                        __notify(kTPNotifyMessageLogout);

                                    }
                                }
                                else
                                {
                                    //noop..
                                }
                                
                            }];
    
  
}

@end
