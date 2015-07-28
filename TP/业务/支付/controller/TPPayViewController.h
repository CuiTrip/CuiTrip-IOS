  
//
//  TPPayViewController.h
//  TP
//
//  Created by wifigo on 2015-07-21 20:44:52 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//


  
#import "VZViewController.h"
#import "TPTripDetailModel.h"
#import "TPPayModel.h"


@interface TPPayViewController : VZViewController

@property(nonatomic,strong)NSString* oid;
@property(nonatomic, retain)NSString *channel;
@property (nonatomic,strong) TPPayModel *payModel;
@property (nonatomic,strong) TPTripDetailModel *tripDetailModel;

@end
  
