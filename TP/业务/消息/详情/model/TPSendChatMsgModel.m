  
//
//  TPSendChatMsgModel.m
//  TP
//
//  Created by moxin on 2015-06-20 23:26:27 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//


/**
 orderId (String): 订单id
 send (String): 发送者id
 receiver(String): 接收者id
 content(String): 消息内容
 */
#import "TPSendChatMsgModel.h"

@interface TPSendChatMsgModel()

@end

@implementation TPSendChatMsgModel

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods

- (NSDictionary *)dataParams {
    
    return @{@"orderId":self.orderId?:@"",
             @"send":self.send?:@"",
             @"receiver":self.receiver?:@"",
             @"content":self.content?:@"",
             @"token":[TPUser token]?:@""};
}


- (NSString *)methodName {
    
    return [_API_ stringByAppendingString:@""];
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

