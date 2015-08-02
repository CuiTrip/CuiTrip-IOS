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

@end


@implementation TPPSFeeExplanView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backImageView = [[UIImageView alloc] initWithFrame:frame];
        self.backImageView.image = __image(@"trip_fee_explan.jpg");
        [self addSubview:self.backImageView];
    }
    
    return self;
}


@end