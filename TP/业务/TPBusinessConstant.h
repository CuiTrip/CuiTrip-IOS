//
//  TPBusinessConstant.h
//  TP
//
//  Created by zhou li on 15/7/20.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



typedef NS_ENUM(NSInteger, TripOrderStatus)
{
    kOrderReadyConfirm  = 1,
    kOrderReadyPay      = 2,
    kOrderReadyBegin    = 3,
    kOrderInTrip        = 4,
    kOrderReadyComment  = 5,
    kOrderFinished      = 6,
    kOrderInvalid       = 7,
    kOrderRefunding     = 8,
    kOrderRefundFailed  = 9,
    kOrderUnknown       = -1
    
};
