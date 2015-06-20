  
//
//  TPTripDetailViewController.h
//  TP
//
//  Created by moxin on 2015-06-07 21:28:19 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//


  
#import "VZViewController.h"

typedef enum
{
    kWillBegin = 0,
    kIsOn = 1,
    kFinish = 2
}TripStatus;

@interface TPTripDetailViewController : VZViewController
@property(nonatomic,assign)TripStatus status;
@property(nonatomic,strong)NSString* oid;


@end
  
