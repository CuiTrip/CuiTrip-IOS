  
//
//  TPPayModel.h
//  TP
//
//  Created by wifigo on 2015-07-21 20:44:52 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//


  
#import "VZHTTPModel.h"

@interface TPPayModel : VZHTTPModel

@property(nonatomic,strong)NSString* oid;

@property(nonatomic,strong,readonly)NSString* serviceName;
@property(nonatomic,strong,readonly)NSString* insiderHeadPic;
@property(nonatomic,strong,readonly)NSString* insiderNickName;
@property(nonatomic,strong,readonly)NSString* insiderSign;
@property(nonatomic,strong,readonly)NSString* serviceDate;
@property(nonatomic,strong,readonly)NSString* buyerNum;
@property(nonatomic,strong,readonly)NSString* orderPrice;
@property(nonatomic,strong,readonly)NSString* status;
@property(nonatomic,strong,readonly)NSString* statusContent;
@property(nonatomic,strong,readonly)NSString* moneyType;

@end

