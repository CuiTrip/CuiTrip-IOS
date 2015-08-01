  
//
//  TPPersonalPageModel.m
//  TP
//
//  Created by wifigo on 2015-07-28 13:09:52 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//


//● token (String): 登录凭证
//● uid (String): 用户id
//● content(String): 自我简介，文字中图片用url代替



#import "TPPersonalPageModel.h"

@interface TPPersonalPageModel()

@end

@implementation TPPersonalPageModel

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods

- (NSDictionary *)dataParams {
    
    return @{
             @"uid":[TPUser uid]?:@"",
             @"token":[TPUser token]?:@"",
             @"content":self.content?:@""
             };
}

- (NSDictionary* )headerParams{
   
    //todo:
    
    return nil;
}

- (NSString *)methodName {
   
    return [_API_ stringByAppendingPathComponent:@"updateIntroduce"];
}

- (VZHTTPRequestConfig)requestConfig
{
    VZHTTPRequestConfig config = vz_defaultHTTPRequestConfig();
    config.requestMethod = VZHTTPMethodPOST;
    return config;
}


- (BOOL)parseResponse:(id)JSON
{
    NSDictionary* result = JSON;
    [TPUser update:result];
    return true;
}


@end

