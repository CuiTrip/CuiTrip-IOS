  
//
//  TPForgetPWDModel.h
//  TP
//
//  Created by moxin on 2015-06-06 17:11:51 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//


  
#import "VZHTTPModel.h"
/**
 	mobile (String)： 用户手机号
 	countryCode (String) : 国家代码
 	vcode (String):  验证码
 	newPasswd (String)：新密码
 	rePasswd (String): 确认新密码
 */
@interface TPForgetPWDModel : VZHTTPModel

@property(nonatomic,strong) NSString* mobile;
@property(nonatomic,strong) NSString* countryCode;
@property(nonatomic,strong) NSString* vcode;
@property(nonatomic,strong) NSString* anewPasswd;
@property(nonatomic,strong) NSString* rePasswd;

@end

