  
//
//  TPChatListModel.m
//  TP
//
//  Created by moxin on 2015-06-10 15:33:15 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPChatListModel.h"
#import "TPChatStatusListItem.h"
#import "TPChatListItem.h"

/**
 	uid(String): 必选，用户id
 	token(String):  必选，登录凭证
 	orderId (String): 必选，订单id
 	size (String): 可选，每次返回的消息数，默认20
 	start(String): 可选，每次开始的请求点，默认0，start=（请求次数-1）*size
 */

@interface TPChatListModel()

@end

@implementation TPChatListModel



////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods



- (NSDictionary *)dataParams {
    
    return @{@"orderId":self.orderId?:@"",
             @"uid":[TPUser uid]?:@"",
             @"token":[TPUser token]?:@"",
             @"size":@"20",
             @"start":[NSString stringWithFormat:@"%ld",(long)self.currentPageIndex*self.pageSize]
             };
}

- (NSInteger)pageSize
{
    return 10;
}

- (VZHTTPRequestConfig)requestConfig
{
    VZHTTPRequestConfig config = vz_defaultHTTPRequestConfig();
    config.requestMethod = VZHTTPMethodPOST;
    return config;
}

- (NSString *)methodName {
    
    return [_API_ stringByAppendingString:@"getDialogList"];
}

- (NSMutableArray* )responseObjects:(id)JSON
{
    NSMutableArray* ret = [NSMutableArray new];
    
    self.orderStatus    = JSON[@"orderStatus"];
    self.serviceDate    = JSON[@"serviceDate"];
    self.peopleNum      = JSON[@"peopleNum"];
    self.insiderId      = JSON[@"insiderId"];
    self.serviceName    = JSON[@"serviceName"];
    self.servicePrice   = JSON[@"servicePrice"];
    self.serviceId      = JSON[@"sid"];
    self.moneyType      = JSON[@"moneyType"];
    
    NSArray* list = JSON[@"dialog"];
    
    for(NSDictionary* info in list)
    {
        NSInteger type = [info[@"type"] integerValue];
 
        //聊天消息
        if (type == 4)
        {
            TPChatListItem* item = [TPChatListItem new];
            [item autoKVCBinding:info];
            [ret addObject:item];
        }
        //系统消息
        else if(type != 1)
        {
            TPChatStatusListItem* item = [TPChatStatusListItem new];
            [item autoKVCBinding:info];
            [ret addObject:item];
        }
    
    }
    
    return ret;

}

@end

