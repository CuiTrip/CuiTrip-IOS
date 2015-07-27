
//
//  TPTripDetailModel.m
//  TP
//
//  Created by moxin on 2015-06-07 21:28:19 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPTripDetailModel.h"

@interface TPTripDetailModel()

@end

@implementation TPTripDetailModel

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods

- (NSDictionary *)dataParams {
    
    return @{@"uid":[TPUser uid]?:@"",@"token":[TPUser token]?:@"",@"oid":self.oid?:@""};
}


- (NSString *)methodName {
    
    return [_API_ stringByAppendingPathComponent:@"getOrderInfo"];
}

- (VZHTTPRequestConfig)requestConfig
{
    VZHTTPRequestConfig config = vz_defaultHTTPRequestConfig();
    config.requestMethod = VZHTTPMethodPOST;
    return config;
}

/**
 "oid": "231 ", //订单ID
 "status": "已结束", //旅程状态
 "insiderId": "25", //发现者id
 "insiderHeadPic": "http://alicdn.aliyun.com/pic1.jpg", //发现者头像
 "insiderNickName": "阿亮", // 发现者昵称
 "serviceDate": "2015-08-09", //服务日期
 "buyerNum": "4人",      //服务人数
 "orderPrice": "免费体验"
 */

- (BOOL)parseResponse:(id)JSON
{
    //todo:
    _insiderHeadPic = JSON[@"headPic"];
    _insiderNickName = JSON[@"userNick"];
    _insiderId = JSON[@"insiderId"];
    _buyerNum = JSON[@"buyerNum"];
    _orderPrice = JSON[@"servicePrice"];
    _serviceName = JSON[@"serviceName"];
    _servicePIC = JSON[@"servicePIC"];
    _serviceAdress = JSON[@"serviceAddress"];
    _insiderSign = JSON[@"insiderSign"];
    _status = JSON[@"status"];
    _statusContent = JSON[@"statusContent"];
    _serviceDate = JSON[@"serviceDate"];
    _moneyType = JSON[@"moneyType"];
    _travellerNickName = JSON[@"travellerName"];
    _oid = JSON[@"oid"];
    _sid = JSON[@"sid"];
    _male = JSON[@"male"];
    _userName = JSON[@"userNick"];
    _userAvatar = JSON[@"headPic"];
    _commentScore = JSON[@"commentScore"];
    _comment = JSON[@"comment"];
    
    return true;
}

@end

