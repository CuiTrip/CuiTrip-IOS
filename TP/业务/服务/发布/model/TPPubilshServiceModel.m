  
//
//  TPPubilshServiceModel.m
//  TP
//
//  Created by moxin on 2015-06-11 23:01:53 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPPubilshServiceModel.h"

/**
 	uid(String): 发现者id
 	token(String):  登录凭证
 	name(String) : 服务名称
 	address(String) : 服务者所在地
 	desc(String) : 服务描述
 	pic(String[]) : 服务图片(图片URL的json数组)
 	backPic(String) : 服务主图( 默认第一张)
 	price(String) : 服务费用
 	maxbuyerNum(String) : 最多接待人数
 	serviceTme(String) : 服务时长
 	bestTime(String) : 最佳时间段
 	meetingWay(String) : 见面方式
  0：约定地点，1：接送
 */


@interface TPPubilshServiceModel()

@end

@implementation TPPubilshServiceModel

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods

- (NSDictionary *)dataParams {
    
    return @{
             @"uid":[TPUser uid]?:@"",
             @"token":[TPUser token]?:@"",
             @"name":self.name?:@"",
             @"address":self.address?:@"",
             @"city":self.city?:[TPLocationManager locationCity]?:@"",
             @"descpt":self.descpt?:@"",
             @"pic":self.pic?:@"",
             @"price":self.price?:@"",
             @"maxbuyerNum":self.maxbuyerNum?:@"",
             @"bestTime":self.bestTime?:@"",
             @"meetingWay":self.meetingWay?:@"",
             @"serviceTime":self.serviceTme?:@"",
             @"lat":[NSString stringWithFormat:@"%f",[TPLocationManager currentLocation].latitude],
             @"lng":[NSString stringWithFormat:@"%f",[TPLocationManager currentLocation].longitude],
             @"country":@"CN",
             @"descpt":self.descpt?:@""
             };
}


- (VZHTTPRequestConfig)requestConfig
{
    VZHTTPRequestConfig config = vz_defaultHTTPRequestConfig();
    config.requestMethod = VZHTTPMethodPOST;
    return config;
}

- (NSString *)methodName {
    
    return [_API_ stringByAppendingString:@"commitServiceInfo"];
}

- (BOOL)parseResponse:(id)JSON
{
    return true;
}

@end

