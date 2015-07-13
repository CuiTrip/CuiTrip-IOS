  
//
//  TPDiscoveryListItem.h
//  TP
//
//  Created by moxin on 2015-06-14 13:55:04 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "VZListItem.h"

/**
 "sid": "231", //服务ID
 "serviceName": "阿亮带你看妈祖绕境", //旅程名称
 "serviceAddress": "台湾彰化县", //旅程所在地
 "headPic": "http://alicdn.aliyun.com/pic1.jpg", //发现者头像
 "userNick": "阿亮"， // 发现者昵称
 "servicePicUrl": "http://******"， // 发现者昵称
 */
@interface TPDiscoveryListItem : VZListItem

@property(nonatomic,strong)NSString *serviceAddress;
@property(nonatomic,strong)NSString *sid;  
@property(nonatomic,strong)NSString *serviceName;
@property(nonatomic,strong)NSString *headPic;
@property(nonatomic,strong)NSString *userNick;
@property(nonatomic,strong)NSString *servicePicUrl;
@property(nonatomic,strong)NSMutableAttributedString* attributedUserString;
@end

  
