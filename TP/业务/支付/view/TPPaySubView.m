  
//
//  TPPaySubView.m
//  TP
//
//  Created by wifigo on 2015-07-21 20:44:52 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPPaySubView.h"
#import "TPPayItem.h"

@interface TPPaySubView()

@end

@implementation TPPaySubView

- (id)initWithFrame:(CGRect)frame 
{

  self = [super initWithFrame:frame]; 

  if (self) { 

    //todo...

  }

  return self;
}

- (void)setItem:(TPPayItem *)item
{
  
}

- (IBAction)confirmBtn:(id)sender {
    //    [self.tabBarController setSelectedIndex:2];
    
    if (self.onConfirmCallback) {
        self.onConfirmCallback();
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
  
  
}

@end

