  
//
//  TPPayModel.m
//  TP
//
//  Created by wifigo on 2015-07-21 20:44:52 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPPayModel.h"

@interface TPPayModel()

@end

@implementation TPPayModel


//● orderId (String): 订单id
//● channel (String): 支付渠道: alipay. 支付宝移动端支付；wx，微信移动端支付
//● clientIp (String)：客户端ip
//● payCurrency(String)：支付的货币类型，现在ping++只支持人民币:cny


////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods

- (NSDictionary *)dataParams {
    
//    return @{
//             @"orderId":self.oid?:@"",
//             @"channel":self.channel?:@"",
//             @"clientIp":self.clientIp?:@"",
//             @"payCurrency":self.payCurrency?:@""
//             };
    return nil;

}


- (NSString *)methodName {
    
    return [_API_ stringByAppendingPathComponent:@"getCharge"];
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


