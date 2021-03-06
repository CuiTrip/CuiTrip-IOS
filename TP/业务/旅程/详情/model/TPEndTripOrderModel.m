//
//  TPEndTripOrderModel.m
//  TP
//
//  Created by moxin on 15/6/24.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPEndTripOrderModel.h"

@implementation TPEndTripOrderModel

- (NSDictionary *)dataParams {
    
    return @{@"uid":[TPUser uid]?:@"",@"token":[TPUser token]?:@"",@"oid":self.oid?:@""};
}

- (NSString *)methodName {
    
    return [_API_ stringByAppendingPathComponent:@"endOrder"];
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
