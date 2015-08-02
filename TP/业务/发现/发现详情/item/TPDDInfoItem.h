  
//
//  TPDDInfoItem.h
//  TP
//
//  Created by moxin on 2015-06-02 22:56:36 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "VZListItem.h"

@interface TPDDInfoItem : VZListItem

@property(nonatomic,strong)NSString* name; //service name
@property(nonatomic,strong)NSString* address; //service address
@property(nonatomic,strong)NSString* desc; //service desc
@property(nonatomic,strong)NSString* score; //service score
@property(nonatomic,strong)NSArray* pics;
@property(nonatomic,strong)NSString* insiderId;
@property(nonatomic,strong)NSString* moneyType;
@property(nonatomic,strong)NSString* priceType;
@property(nonatomic,strong)NSString* checkStatus;
@property(nonatomic,strong)NSString* bestTime;
@property(nonatomic,strong)NSString* meetingWay;

@end

  
