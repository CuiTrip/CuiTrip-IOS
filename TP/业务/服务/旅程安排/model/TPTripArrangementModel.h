  
//
//  TPTripArrangementModel.h
//  TP
//
//  Created by moxin on 2015-06-14 15:23:45 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//


  
#import "VZHTTPModel.h"

/**
 	uid(String): 发现者id
 	token(String):  登录凭证
 	sid(String)：服务 id
 	availableDate(String[]) : 字段值(可约日期timestap数组)
 */
@interface TPTripArrangementModel : VZHTTPModel

@property(nonatomic,strong)NSString* sid;
@property(nonatomic,strong)NSArray* availableDates;

@end

