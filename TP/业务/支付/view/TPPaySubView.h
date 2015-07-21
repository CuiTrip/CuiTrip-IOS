  
//
//  TPPaySubView.h
//  TP
//
//  Created by wifigo on 2015-07-21 20:44:52 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//


  
@class TPPayItem;

#import <UIKit/UIKit.h>

@interface TPPaySubView : UIView

@property(nonatomic,strong) TPPayItem *item;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property(nonatomic,copy) void(^onConfirmCallback)(void);

@end

