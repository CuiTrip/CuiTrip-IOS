  
//
//  TPGetServiceEnableDateModel.h
//  TP
//
//  Created by moxin on 2015-06-17 22:56:10 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//


  
#import "VZHTTPModel.h"

@interface TPGetServiceEnableDateModel : VZHTTPModel

@property(nonatomic,strong) NSString* sid;

@property(nonatomic,strong,readonly) NSArray* availableDates;

@end

