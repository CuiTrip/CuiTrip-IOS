  
//
//  TPPersonalPageDetailModel.h
//  TP
//
//  Created by wifigo on 2015-07-28 18:16:39 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//


#import "VZHTTPModel.h"

@interface TPPersonalPageDetailModel : VZHTTPModel


@property(nonatomic,strong)NSString* uid;

@property(nonatomic,strong,readonly)NSString* nick;
@property(nonatomic,strong,readonly)NSString* sign;
@property(nonatomic,strong,readonly)NSString* headPic;
@property(nonatomic,strong,readonly)NSString* introduce;
@property(nonatomic,strong,readonly)NSString* introduceAuditStatus;
@property(nonatomic,strong,readonly)NSString* introduceFailedReason;


@end

