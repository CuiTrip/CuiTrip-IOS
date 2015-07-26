  
//
//  TPMyServiceListItem.h
//  TP
//
//  Created by moxin on 2015-06-01 19:52:11 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "VZListItem.h"

@interface TPMyServiceListItem : VZListItem
/*审核中（0），已审核（1），审核未通过（2）*/

@property(nonatomic,strong)NSString *sid;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *checkStatus; /*审核中（0），已审核（1），审核未通过（2）*/
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *lat;
@property(nonatomic,strong)NSString *lng;
@property(nonatomic,strong)NSString *proc;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *insiderId;
@property(nonatomic,strong)NSString *score;
@property(nonatomic,strong)NSString *descpt;
@property(nonatomic,strong)NSArray  *pic;
@property(nonatomic,strong)NSString *backPic;
@property(nonatomic,strong)NSString *tag;
@property(nonatomic,strong)NSString *moneyType;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *priceDesc;
@property(nonatomic,strong)NSString *maxbuyerNum;
@property(nonatomic,strong)NSString *serviceTime;
@property(nonatomic,strong)NSString *bestTime;
@property(nonatomic,strong)NSString *availableDate;
@property(nonatomic,strong)NSString *meetingWay;
@property(nonatomic,strong)NSString *extInfo;
@property(nonatomic,strong)NSString *gmtCreated;
@property(nonatomic,strong)NSString *gmtModified;
@property(nonatomic,strong)NSString *country;

@end

  
