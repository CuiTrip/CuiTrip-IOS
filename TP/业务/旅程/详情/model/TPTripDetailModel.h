
//
//  TPTripDetailModel.h
//  TP
//
//  Created by moxin on 2015-06-07 21:28:19 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "VZHTTPModel.h"


/**
 "insiderHeadPic": "http://alicdn.aliyun.com/pic1.jpg", //发现者头像
 "insiderNickName": "阿亮", // 发现者昵称
 "serviceDate": "2015-08-09", //服务日期
 "buyerNum": "4人",      //服务人数
 "orderPrice": "免费体验"
 */
@interface TPTripDetailModel : VZHTTPModel

@property(nonatomic,strong)NSString* oid;
@property(nonatomic,strong,readonly)NSString* serviceName;
@property(nonatomic,strong,readonly)NSString* insiderHeadPic;
@property(nonatomic,strong,readonly)NSString* insiderNickName;
@property(nonatomic,strong,readonly)NSString* insiderId;
@property(nonatomic,strong,readonly)NSString* insiderSign;
@property(nonatomic,strong,readonly)NSString* serviceDate;
@property(nonatomic,strong,readonly)NSString* servicePIC;
@property(nonatomic,strong,readonly)NSString* serviceAdress;
@property(nonatomic,strong,readonly)NSString* buyerNum;
@property(nonatomic,strong,readonly)NSString* orderPrice;
@property(nonatomic,strong,readonly)NSString* status;
@property(nonatomic,strong,readonly)NSString* statusContent;
@property(nonatomic,strong,readonly)NSString* moneyType;
@property(nonatomic,strong,readonly)NSString* travellerNickName;
@property(nonatomic,strong,readonly)NSString* sid;
@property(nonatomic,strong,readonly)NSString* userName;
@property(nonatomic,strong,readonly)NSString* userAvatar;
@property(nonatomic,strong,readonly)NSString* commentScore;
@property(nonatomic,strong,readonly)NSString* comment;

@end

