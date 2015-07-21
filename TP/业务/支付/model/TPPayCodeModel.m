  
//
//  TPPayModel.m
//  TP
//
//  Created by moxin on 2015-06-15 17:32:26 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPPayCodeModel.h"

@interface TPPayCodeModel()

@end

@implementation TPPayCodeModel

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods

- (NSDictionary *)dataParams {
    
    return @{
             @"uid":[TPUser uid]?:@"",
             @"token":[TPUser token]?:@"",
             @"orderId":self.orderId?:@"",
             @"inviteCode":self.inviteCode?:@""
             };
    
    
}


- (NSString *)methodName {
    
    return [_API_ stringByAppendingString:@"payOrder"];
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

