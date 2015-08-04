  
//
//  TPReserveViewController.h
//  TP
//
//  Created by moxin on 2015-06-06 22:33:12 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//


  
#import "VZViewController.h"

typedef enum
{
    kCreateOrder = 0,
    kModifyOrder = 1

}ReserveType;

@interface TPReserveViewController : VZViewController

@property(nonatomic,assign)ReserveType type;

@property(nonatomic,strong)NSString* oid;//orderId,修改订单用
@property(nonatomic,strong)NSString* sid;//serviceId,创建订单
@property(nonatomic,strong)NSString* insiderId;
@property(nonatomic,strong)NSString* serviceName;
@property(nonatomic,strong)NSString* serviceDate;
@property(nonatomic,strong)NSString* servicePrice;
@property(nonatomic,strong)NSString* moneyType;
@property(nonatomic,strong)NSString* payCurrency;
@property(nonatomic,assign)NSInteger maxNum;
@property(nonatomic,strong)NSString* pic;

@end
  
