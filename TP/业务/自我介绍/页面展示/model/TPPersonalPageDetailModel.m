  
//
//  TPPersonalPageDetailModel.m
//  TP
//
//  Created by wifigo on 2015-07-28 18:16:39 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPPersonalPageDetailModel.h"

@interface TPPersonalPageDetailModel()

@end

@implementation TPPersonalPageDetailModel

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods

- (NSDictionary *)dataParams {
    
    
    return @{
             @"uid":[TPUser uid]?:@"",
             @"token":[TPUser token]?:@""
             };
}

- (NSDictionary* )headerParams{
   
    //todo:
    
    return nil;
}


- (NSString *)methodName {
    
    return [_API_ stringByAppendingPathComponent:@"getIntroduce"];
}

- (VZHTTPRequestConfig)requestConfig
{
    VZHTTPRequestConfig config = vz_defaultHTTPRequestConfig();
    config.requestMethod = VZHTTPMethodPOST;
    return config;
}

- (BOOL)parseResponse:(id)JSON
{
    _nick = JSON[@"nick"];
    _sign = JSON[@"sign"];
    _headPic = JSON[@"headPic"];
    _introduce = JSON[@"introduce"];
    _introduceAuditStatus = JSON[@"introduceAuditStatus"];
    _introduceFailedReason = JSON[@"introduceFailedReason"];
    
    return true;
}

@end

