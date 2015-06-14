  
//
//  TPForgetPWDModel.m
//  TP
//
//  Created by moxin on 2015-06-06 17:11:51 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPForgetPWDModel.h"

@interface TPForgetPWDModel()

@end

@implementation TPForgetPWDModel

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods

/**
 	mobile (String)： 用户手机号
 	countryCode (String) : 国家代码
 	vcode (String):  验证码
 	newPasswd (String)：新密码
 	rePasswd (String): 确认新密码
 */
- (NSDictionary *)dataParams {
    
    return @{@"mobile":self.mobile?:@"",
             @"countryCode":self.countryCode?:@"",
             @"vcode":self.vcode?:@"",
             @"newPasswd":self.anewPasswd?:@"",
             @"rePasswd":self.rePasswd?:@""};
}

- (NSDictionary* )headerParams{
   
    //todo:
    
    return nil;
}

- (NSString *)methodName {
   
    //todo:
   
    return [_API_ stringByAppendingString:@"resetPassword"];
}

- (VZHTTPRequestConfig)requestConfig
{
    VZHTTPRequestConfig config = vz_defaultHTTPRequestConfig();
    config.requestMethod = VZHTTPMethodPOST;
    return config;
}

- (BOOL)parseResponse:(id)JSON
{
    //todo:
  


    return NO;
}

@end

