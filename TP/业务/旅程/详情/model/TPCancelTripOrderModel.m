
//
//  TPCancelTripOrderModel.m
//  TP
//
//  Created by moxin on 2015-06-18 13:06:36 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPCancelTripOrderModel.h"

@interface TPCancelTripOrderModel()

@end

@implementation TPCancelTripOrderModel

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods

- (NSDictionary *)dataParams {
    
    return @{@"uid" : [TPUser uid] ? : @"", @"token" : [TPUser token] ? : @"" , @"oid" : self.oid? : @"", @"reason":self.reason ? : @""};
}

- (NSString *)methodName {
    
    return [_API_ stringByAppendingString:@"cancelOrder"];
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

