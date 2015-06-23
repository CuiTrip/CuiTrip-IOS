  
//
//  TPReserveSubView.m
//  TP
//
//  Created by moxin on 2015-06-06 22:33:12 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPReserveSubView.h"
#import "TPReserveItem.h"

@interface TPReserveSubView()


@end

@implementation TPReserveSubView

- (id)initWithFrame:(CGRect)frame 
{

  self = [super initWithFrame:frame]; 

  if (self) { 

    //todo...

  }

  return self;
}

- (IBAction)onConfirm:(id)sender {
    
    if (self.onConfirmCallback) {
        self.onConfirmCallback();
    }

}

- (void)layoutSubviews
{
    [super layoutSubviews];
  
  
}

@end

