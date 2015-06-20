  
//
//  TPSendChatMsgModel.h
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
#import "VZHTTPModel.h"



@interface TPSendChatMsgModel : VZHTTPModel

@property(nonatomic,strong)NSString* orderId;
@property(nonatomic,strong)NSString* send;
@property(nonatomic,strong)NSString* receiver;
@property(nonatomic,strong)NSString* content;


@end

