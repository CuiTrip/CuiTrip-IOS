  
//
//  TPPubilshServiceModel.h
//  TP
//
//  Created by moxin on 2015-06-11 23:01:53 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//


  
#import "VZHTTPModel.h"


@interface TPPubilshServiceModel : VZHTTPModel

@property(nonatomic,strong) NSString* name;
@property(nonatomic,strong) NSString* address;
@property(nonatomic,strong) NSString* country;
@property(nonatomic,strong) NSString* city;
@property(nonatomic,strong) NSArray* pic;
@property(nonatomic,strong) NSString* price;
@property(nonatomic,strong) NSString* maxbuyerNum;
@property(nonatomic,strong) NSString* serviceTme;
@property(nonatomic,strong) NSString* bestTime;
@property(nonatomic,strong) NSString* meetingWay;
@property(nonatomic,strong) NSString* lat;
@property(nonatomic,strong) NSString* lng;
@property(nonatomic,strong) NSString* descpt;
@property(nonatomic,strong) NSString* priceType;
@property(nonatomic,strong) NSString* moneyType;

@end

