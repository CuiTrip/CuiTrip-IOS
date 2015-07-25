  
//
//  TPChatListViewController.h
//  TP
//
//  Created by moxin on 2015-06-10 15:33:15 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//


  
#import "VZListViewController.h"

@interface TPChatListViewController : VZListViewController

@property(nonatomic,strong)NSString* orderId;
@property(nonatomic,strong)NSString* receiverId;
@property(nonatomic,strong)NSString* orderStatus;
@property(nonatomic,assign)TPUserType msgUserType;

@end
  
