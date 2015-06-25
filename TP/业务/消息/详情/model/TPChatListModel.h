  
//
//  TPChatListModel.h
//  TP
//
//  Created by moxin on 2015-06-10 15:33:15 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//


  
#import "VZHTTPListModel.h"

@interface TPChatListModel : VZHTTPListModel


@property(nonatomic,strong)NSString* orderId;

@property(nonatomic,strong)NSString* serviceId;
@property(nonatomic,strong)NSString* serviceDate;
@property(nonatomic,strong)NSString* serviceName;
@property(nonatomic,strong)NSString* servicePrice;
@property(nonatomic,strong)NSString* peopleNum;
@property(nonatomic,strong)NSString* orderStatus;
@property(nonatomic,strong)NSString* insiderId;
@property(nonatomic,strong)NSString* moneyType;

@end

