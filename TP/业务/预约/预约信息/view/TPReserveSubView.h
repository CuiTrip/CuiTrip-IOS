  
//
//  TPReserveSubView.h
//  TP
//
//  Created by moxin on 2015-06-06 22:33:12 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//


  
@class TPReserveItem;

#import <UIKit/UIKit.h>

@interface TPReserveSubView : UIView

@property(nonatomic,strong) TPReserveItem *item;
@property(nonatomic,copy) void(^onConfirmCallback)(void);

@end

