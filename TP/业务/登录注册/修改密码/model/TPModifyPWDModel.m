  
//
//  TPModifyPWDModel.m
//  TP
//
//  Created by moxin on 2015-06-25 22:52:10 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPModifyPWDModel.h"

@interface TPModifyPWDModel()

@end

@implementation TPModifyPWDModel

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods


- (NSDictionary *)dataParams {
    
    return @{@"uid":[TPUser uid]?:@"",
             @"token":[TPUser token]?:@"",
             @"newPasswd":self.pwd?:@"",
             @"rePasswd":self.confirmPwd?:@""};
}

- (NSDictionary* )headerParams{
    
    //todo:
    
    return nil;
}

- (NSString *)methodName {
    
    //todo:
    
    return [_API_ stringByAppendingString:@"modifyPassword"];
}

- (VZHTTPRequestConfig)requestConfig
{
    VZHTTPRequestConfig config = vz_defaultHTTPRequestConfig();
    config.requestMethod = VZHTTPMethodPOST;
    return config;
}

- (BOOL)parseResponse:(id)JSON
{
    return true;
}

@end

