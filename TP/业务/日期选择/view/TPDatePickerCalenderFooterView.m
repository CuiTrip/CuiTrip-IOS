//
//  TPDatePickerCalenderFooterView.m
//  TP
//
//  Created by 贝贝 on 15/8/1.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//


#import "TPDatePickerCalenderFooterView.h"

@interface TPDatePickerCalenderFooterView()


@end

@implementation TPDatePickerCalenderFooterView



- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.grayView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, 10, 10)];
        self.grayView.backgroundColor = [UIColor grayColor];
        self.grayLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 5, 54, 10)];
        self.grayLabel.text = @"不可预定";
        self.grayLabel.textColor = [UIColor grayColor];
        self.grayLabel.font = [UIFont systemFontOfSize:12.0f];
        self.grayLabel.backgroundColor = [UIColor clearColor];
        
        self.blueview = [[UIView alloc] initWithFrame:CGRectMake(94, 5, 10, 10)];
        self.blueview.backgroundColor = [TPTheme bgColor];
        self.blueLabel = [[UILabel alloc] initWithFrame:CGRectMake(112, 5, 54, 10)];
        self.blueLabel.text = @"可以预定";
        self.blueLabel.textColor = [TPTheme bgColor];;
        self.blueLabel.backgroundColor = [UIColor clearColor];
        self.blueLabel.font = [UIFont systemFontOfSize:12.0f];
        [self addSubview:self.grayView];
        [self addSubview:self.grayLabel];
        [self addSubview:self.blueview];
        [self addSubview:self.blueLabel];
        
    }
    
    return self;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

@end

