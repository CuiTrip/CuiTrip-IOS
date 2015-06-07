//
//  TPLoginManager.h
//  TP
//
//  Created by moxin on 15/6/1.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPLoginManager : NSObject

+ (void)autoLogin;

+ (void)showLoginViewControllerWithCompletion:(void(^)(NSError* error))completion;

+ (void)hideLoginViewController;

+ (void)loginWithCompletion:(void(^)(NSError* error))completion;

+ (void)logout;


@end
