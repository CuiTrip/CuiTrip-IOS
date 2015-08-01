//
//  TPMyServiceListDeleteModel.m
//  TP
//
//  Created by zhou li on 15/8/1.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPMyServiceListDeleteModel.h"

@interface TPMyServiceListDeleteModel()

@end

@implementation TPMyServiceListDeleteModel

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods

- (NSDictionary *)dataParams {
    return @{@"uid":[TPUser uid]?:@"",@"token":[TPUser token]?:@"",@"sid":self.sid?:@""};
}

- (VZHTTPRequestConfig)requestConfig
{
    VZHTTPRequestConfig config = vz_defaultHTTPRequestConfig();
    config.requestMethod = VZHTTPMethodPOST;
    return config;
}


- (NSString *)methodName {
    
    return [_API_ stringByAppendingString:@"deleteServiceInfo"];
}

- (BOOL)parseResponse:(id)JSON
{
    return true;
}

@end

