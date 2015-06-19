  
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
@property(nonatomic,strong)NSArray* availableDates;
@property(nonatomic,assign)NSInteger maxNum;
@property(nonatomic,strong)NSString* fee;

@end
  
