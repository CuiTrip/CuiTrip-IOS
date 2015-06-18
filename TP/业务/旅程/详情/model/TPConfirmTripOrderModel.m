  
//
//  TPConfirmTripOrderModel.m
//  TP
//
//  Created by moxin on 2015-06-18 11:44:11 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPConfirmTripOrderModel.h"

@interface TPConfirmTripOrderModel()

@end

@implementation TPConfirmTripOrderModel

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods

- (NSDictionary *)dataParams {
    
    return @{@"uid":[TPUser uid]?:@"",@"token":[TPUser token]?:@"",@"oid":self.oid?:@""};
}

- (NSString *)methodName {
   
    return [_API_ stringByAppendingPathComponent:@"confirmOrder"];
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

