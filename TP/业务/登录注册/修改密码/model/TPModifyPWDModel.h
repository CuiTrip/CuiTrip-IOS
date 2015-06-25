  
//
//  TPModifyPWDModel.h
//  TP
//
//  Created by moxin on 2015-06-25 22:52:10 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//


  
#import "VZHTTPModel.h"

@interface TPModifyPWDModel : VZHTTPModel

@property(nonatomic,strong)NSString* pwd;
@property(nonatomic,strong)NSString* confirmPwd;

@end

