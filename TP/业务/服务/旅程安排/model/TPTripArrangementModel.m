  
//
//  TPTripArrangementModel.m
//  TP
//
//  Created by moxin on 2015-06-14 15:23:45 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPTripArrangementModel.h"

@interface TPTripArrangementModel()

@end

@implementation TPTripArrangementModel

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods

/**
uid(String): 发现者id
token(String):  登录凭证
sid(String)：服务 id
availableDate(String[]) : 字段值(可约日期timestap数组)
 */
- (NSDictionary *)dataParams
{
    
    return @{@"uid":[TPUser uid]?:@"",
             @"token":[TPUser token]?:@"",
             @"sid":self.sid?:@"",
             @"availableDate":self.availableDates?:@[]};

}


- (VZHTTPRequestConfig)requestConfig
{
    VZHTTPRequestConfig config = vz_defaultHTTPRequestConfig();
    config.requestMethod = VZHTTPMethodPOST;
    return config;
}

- (NSString *)methodName {
    
    return [_API_ stringByAppendingString:@"modifyServiceInfo"];
}


- (BOOL)parseResponse:(id)JSON
{
    return YES;
}

@end

