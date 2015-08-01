//
//  TPDatePickerCalenderFooterView.m
//  TP
//
//  Created by 贝贝 on 15/8/1.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//


#import "TPDatePickerCalenderFooterView.h"

@interface TPDatePickerCalenderFooterView()

@property(nonatomic,strong) UIView* titleView;
@property(nonatomic,strong) UIView* titleLabel;

@property(nonatomic,strong) UILabel* addressView;
@property(nonatomic,strong) UILabel* addressLabel;

@end

@implementation TPDatePickerCalenderFooterView



- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 5, 10, 10)];
        view.backgroundColor = [UIColor grayColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(26, 5, 54, 10)];
        label.text = @"已被预定";
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:12.0f];
        label.backgroundColor = [UIColor clearColor];
        
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(94, 5, 10, 10)];
        view1.backgroundColor = [TPTheme bgColor];
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(112, 5, 54, 10)];
        label1.text = @"可以预定";
        label1.textColor = [TPTheme bgColor];;
        label1.backgroundColor = [UIColor clearColor];
        label1.font = [UIFont systemFontOfSize:12.0f];
        [self addSubview:view];
        [self addSubview:label];
        [self addSubview:view1];
        [self addSubview:label1];
        
    }
    
    return self;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

@end

