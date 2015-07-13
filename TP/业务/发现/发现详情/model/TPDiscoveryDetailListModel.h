  
//
//  TPDiscoveryDetailListModel.h
//  TP
//
//  Created by moxin on 2015-06-02 22:32:08 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//


  
#import "VZHTTPListModel.h"

@class TPDDInfoItem;
@class TPDDProfileItem;
@class TPDDCommentItem;
@class TPDDTripItem;

@interface TPDiscoveryDetailListModel : VZHTTPListModel

@property(nonatomic,strong) NSString* sid;

@property(nonatomic,strong)TPDDInfoItem* tripInfoItem;
@property(nonatomic,strong)TPDDProfileItem* insiderProfileItem;
@property(nonatomic,strong)TPDDCommentItem* tripCommentItem;
@property(nonatomic,strong)TPDDTripItem* tripDetailItem;

@end

