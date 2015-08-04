  
//
//  TPReserveModel.h
//  TP
//
//  Created by moxin on 2015-06-06 22:33:12 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//


  
#import "VZHTTPModel.h"

/**
 	token(String):  登录凭证
 	uid (String): 买家id
 	insiderId (String): 卖家id
 	sid (String): 服务id
 	serviceName (String): 服务名称
 	serviceDate (String): 预约日期， 1970后的毫秒数
 	buyerNum (String):  游玩人数
 	servicePrice (String): 服务原价
 	moneyType (String): 货币种类：如：人民币CNY
 */
@interface TPReserveModel : VZHTTPModel

@property(nonatomic,assign)NSInteger type; //0.创建订单，1，修改订单
@property(nonatomic,strong)NSString* oid;
@property(nonatomic,strong)NSString* sid;
@property(nonatomic,strong)NSString* insiderId;
@property(nonatomic,strong)NSString* serviceName;
@property(nonatomic,strong)NSString* buyerNum;
@property(nonatomic,strong)NSString* servicePrice;
@property(nonatomic,strong)NSString* serviceDate;
@property(nonatomic,strong)NSString* moneyType;
@property(nonatomic,strong)NSString* payCurrency;


@end

