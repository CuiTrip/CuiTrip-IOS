  
//
//  TPPublishCommentModel.m
//  TP
//
//  Created by moxin on 2015-06-11 19:56:48 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//


/**
uid(String): 用户id
token(String):  登录凭证
oid(String) : 订单id
serviceScore(int): 订单打分（默认5分）
content(String) : 评论内容
 */

#import "TPPublishCommentModel.h"

@interface TPPublishCommentModel()

@end

@implementation TPPublishCommentModel

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods

- (NSDictionary *)dataParams {
    
    return @{@"uid":[TPUser uid]?:@"",
             @"token":[TPUser token]?:@"",
             @"oid":self.oid?:@"",
             @"serviceScore":self.score?:@"",
             @"content":self.content?:@""};
}



- (NSString *)methodName {
   
    return [_API_ stringByAppendingString:@"submitReview"];
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

