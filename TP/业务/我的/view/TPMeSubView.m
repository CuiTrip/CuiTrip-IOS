
//
//  TPMeSubView.m
//  TP
//
//  Created by moxin on 2015-06-01 19:41:46 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPMeSubView.h"
#import "TPMeItem.h"

@interface TPMeSubView()


@end

@implementation TPMeSubView

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

