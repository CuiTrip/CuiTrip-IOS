  
//
//  TPDiscoveryDetailListViewController.h
//  TP
//
//  Created by moxin on 2015-06-02 22:32:08 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//


  
#import "VZListViewController.h"

typedef NS_ENUM(NSInteger, Type)
{
    kDetail= 0,
    kArrangeMent = 1

};

@interface TPDiscoveryDetailListViewController : VZListViewController

@property(nonatomic,assign)Type type;
@property(nonatomic,strong)NSString* sid;
@property(nonatomic,assign)int checkStatus;

@end
  
