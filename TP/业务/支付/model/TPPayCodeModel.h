  
//
//  TPPayCodeModel.h
//  TP
//
//  Created by moxin on 2015-06-15 17:32:26 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//


  
#import "VZHTTPModel.h"

@interface TPPayCodeModel : VZHTTPModel

@property(nonatomic,strong)NSString* inviteCode;
@property(nonatomic,strong)NSString* orderId;

@end

