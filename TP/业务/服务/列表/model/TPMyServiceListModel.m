  
//
//  TPMyServiceListModel.m
//  TP
//
//  Created by moxin on 2015-06-01 19:52:11 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPMyServiceListModel.h"

@interface TPMyServiceListModel()

@end

@implementation TPMyServiceListModel

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods

- (NSDictionary *)dataParams {
    
    return @{@"uid":[TPUser uid]?:@"",@"token":[TPUser token]?:@""};
}

- (VZHTTPRequestConfig)requestConfig
{
    VZHTTPRequestConfig config = vz_defaultHTTPRequestConfig();
    config.requestMethod = VZHTTPMethodPOST;
    return config;
}


- (NSString *)methodName {
    
    return [_API_ stringByAppendingString:@"getServiceList"];
}

- (NSMutableArray* )responseObjects:(id)JSON
{
    NSMutableArray* list = [NSMutableArray new];
    return list;
}

@end

