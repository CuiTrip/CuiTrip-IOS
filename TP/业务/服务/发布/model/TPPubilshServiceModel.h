  
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
@property(nonatomic,strong) NSString* desc;
@property(nonatomic,strong) NSString* pic;
@property(nonatomic,strong) NSString* price;
@property(nonatomic,strong) NSString* maxbuyerNum;
@property(nonatomic,strong) NSString* serviceTme;
@property(nonatomic,strong) NSString* bestTime;
@property(nonatomic,strong) NSString* meetingWay;

@end

