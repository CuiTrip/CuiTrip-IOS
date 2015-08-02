  
//
//  TPTripDetailViewController.h
//  TP
//
//  Created by moxin on 2015-06-07 21:28:19 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//


  
#import "VZViewController.h"
#import "TPTripDetailSubView.h"

/****
    //READY_CONFIRM(1, "待确认"),
    //READY_PAY(2, "待支付"),
    //READY_BEGIN(3, "待开始"),
    //GOING(4, "进行中"),
    //READY_COMMENT(5, "待评价"),
    //FINISHED(6, "已完成"),
    //INVALID(7, "已失效"),
    //REFUNDING(8, "退款中"),
    //REFUND_FAILED(9, "退款失败");
***/


@interface TPTripDetailViewController : VZViewController<UITableViewDelegate, UITableViewDataSource, TripSubViewDelegate>


@property(nonatomic,strong)NSString* oid;


@end
  
