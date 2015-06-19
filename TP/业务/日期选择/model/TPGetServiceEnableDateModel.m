  
//
//  TPGetServiceEnableDateModel.m
//  TP
//
//  Created by moxin on 2015-06-17 22:56:10 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPGetServiceEnableDateModel.h"

@interface TPGetServiceEnableDateModel()

@end

@implementation TPGetServiceEnableDateModel

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods

- (NSDictionary *)dataParams {
    
    return @{@"sid":self.sid?:@""};
}

- (NSString *)methodName {
    
    return [_API_ stringByAppendingString:@"getServiceAvailableDate"];
}

- (VZHTTPRequestConfig)requestConfig
{
    VZHTTPRequestConfig config = vz_defaultHTTPRequestConfig();
    config.requestMethod = VZHTTPMethodPOST;
    return config;
}

- (BOOL)parseResponse:(id)JSON
{
    NSArray* ret = JSON[@"enableDate"];
    NSMutableArray* temp = [NSMutableArray new];
    for (NSString* timeStamp in ret) {
        
        NSTimeInterval t = [timeStamp doubleValue];
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:t];
        [temp addObject:date];
    }
    
    _availableDates = [temp copy];
    return YES;
}

@end

