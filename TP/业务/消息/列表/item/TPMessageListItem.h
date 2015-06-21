  
//
//  TPMessageListItem.h
//  TP
//
//  Created by moxin on 2015-06-01 19:41:08 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "VZListItem.h"


/**
 "type":"2",
 "headPic":"http://****",	// 头像
 "topic":"阿亮带您环岛游",	//消息title
 "lastMsg":"好的，到时见",	// 上一条消息
 "orderId":"11111_22222",	// 订单号，根据订单号跳
 */

@interface TPMessageListItem : VZListItem

@property(nonatomic,strong) NSString* messageId;
@property(nonatomic,strong) NSString* type;
@property(nonatomic,strong) NSString* topic;
@property(nonatomic,strong) NSString* headPic;
@property(nonatomic,strong) NSString* lastMsg;
@property(nonatomic,strong) NSString* orderId;
@property(nonatomic,strong) NSString* trallerId;
@property(nonatomic,strong) NSString* insiderId;
@property(nonatomic,assign) BOOL hasNewMsg;

@end

  
