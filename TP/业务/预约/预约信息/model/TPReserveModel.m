  
//
//  TPReserveModel.m
//  TP
//
//  Created by moxin on 2015-06-06 22:33:12 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPReserveModel.h"

@interface TPReserveModel()

@end

@implementation TPReserveModel

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods

- (NSDictionary *)dataParams {
    
    return  @{@"sid":self.sid?:@"",
              @"token":[TPUser token]?:@"",
              @"uid":[TPUser uid]?:@"",
              @"insiderId":self.insiderId?:@"",
              @"serviceName":self.serviceName?:@"",
              @"serviceDate":self.serviceDate?:@"",
              @"buyerNum":self.buyerNum?:@"",
              @"servicePrice":self.servicePrice?:@"",
              @"moneyType":self.moneyType?:@""};
}


- (NSString *)methodName {
   
    return [_API_ stringByAppendingString:@"createOrder"];
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

