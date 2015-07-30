  
//
//  TPPersonalPageDetailSubView.m
//  TP
//
//  Created by wifigo on 2015-07-28 18:16:39 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPPersonalPageDetailSubView.h"
#import "TPPersonalPageDetailItem.h"

@interface TPPersonalPageDetailSubView()

@end

@implementation TPPersonalPageDetailSubView


- (void)awakeFromNib
{
    [super awakeFromNib];
    self.imageView.layer.cornerRadius = 0.5*self.imageView.vzWidth;
    self.imageView.layer.masksToBounds = true;
    
}

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //todo...
        
    }
    
    return self;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

@end


