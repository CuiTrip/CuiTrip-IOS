//
//  TPPSFeeExplanView.m
//  TP
//
//  Created by zhou li on 15/8/2.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPPSFeeExplanView.h"

@interface TPPSFeeExplanView()

@property (nonatomic) UIImageView *backImageView;

@property (nonatomic, strong) UIButton *exitBtn;


@end


@implementation TPPSFeeExplanView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backImageView = [[UIImageView alloc] initWithFrame:frame];
        self.backImageView.image = __image(@"trip_fee_explan.jpg");
        [self addSubview:self.backImageView];
        
        self.exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.exitBtn.frame = CGRectMake((self.vzWidth - 44.0f) / 2, self.vzBottom - 53.0f, 44.0f, 44.0f);
        [self.exitBtn setImage:__image(@"trip_close.png") forState:UIControlStateNormal];
        [self.exitBtn addTarget:self action:@selector(removeView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.exitBtn];
    }
    
    return self;
}

- (void)removeView
{
    [self removeFromSuperview];
}

@end