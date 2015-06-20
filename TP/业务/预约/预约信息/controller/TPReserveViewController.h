  
//
//  TPReserveViewController.h
//  TP
//
//  Created by moxin on 2015-06-06 22:33:12 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//


  
#import "VZViewController.h"

@interface TPReserveViewController : VZViewController

@property(nonatomic,strong)NSString* sid;
@property(nonatomic,strong)NSString* insiderId;
@property(nonatomic,strong)NSString* serviceName;
@property(nonatomic,strong)NSString* serviceDate;
@property(nonatomic,strong)NSString* servicePrice;
@property(nonatomic,strong)NSString* moneyType;
@property(nonatomic,assign)NSInteger maxNum;
@property(nonatomic,strong)NSString* fee;

@end
  
