//
//  TPEditServiceContentModel.m
//  TP
//
//  Created by zhou li on 15/8/2.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPEditServiceContentModel.h"


@interface TPEditServiceContentModel()

@end


@implementation TPEditServiceContentModel

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods

- (NSDictionary *)dataParams {
    return @{
             @"uid":[TPUser uid]?:@"",
             @"token":[TPUser token]?:@"",
             @"name":self.name?:@"",
             @"address":self.address?:@"",
             @"country":self.country?:[TPLocationManager locationCountry]?:@"",
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
             @"descpt":self.descpt?:@"",
             @"priceType":self.priceType?:@"",
             @"moneyType":self.moneyType?:@"",
             @"sid":self.sid?:@""
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