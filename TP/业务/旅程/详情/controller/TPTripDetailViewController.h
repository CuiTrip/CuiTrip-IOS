  
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
    kOrderCreated = 0,
    kOrderConfirmed,
    kOrderWillBegin,
    kOrderDidBegin,
    kOrderComplted,
    kOrderClosed,
    kOrderPaied,
    kOrderUnknown = -1
    
}TripOrderStatus;

@interface TPTripDetailViewController : VZViewController

@property(nonatomic,strong)NSString* oid;


@end
  
