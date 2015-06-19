  
//
//  TPDiscoveryDetailListModel.m
//  TP
//
//  Created by moxin on 2015-06-02 22:32:08 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPDiscoveryDetailListModel.h"
#import "TPDiscoveryDetailListItem.h"
#import "TPDDInfoItem.h"
#import "TPDDProfileItem.h"
#import "TPDDCommentItem.h"
#import "TPDDTripItem.h"


@interface TPDiscoveryDetailListModel()

@end

@implementation TPDiscoveryDetailListModel

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods

- (NSDictionary *)dataParams {
    
    return @{@"sid":self.sid?:@""};

}

- (NSString *)methodName {
    
    return [_API_ stringByAppendingString:@"getServiceDetail"];
}

- (VZHTTPRequestConfig)requestConfig
{
    VZHTTPRequestConfig config = vz_defaultHTTPRequestConfig();
    config.requestMethod = VZHTTPMethodPOST;
    return config;
}

- (NSMutableArray* )responseObjects:(id)JSON
{
  
    TPDiscoveryDetailListItem* item = [TPDiscoveryDetailListItem new];
    [item autoKVCBinding:JSON];
    
    NSMutableArray* list = [NSMutableArray new];
    
    TPDDInfoItem* infoItem = [TPDDInfoItem new];
    NSDictionary* serviceInfo = JSON[@"serviceInfo"];
    infoItem.name = serviceInfo[@"name"];
    infoItem.address = serviceInfo[@"address"];
    infoItem.desc = serviceInfo[@"descpt"];
    infoItem.score = serviceInfo[@"score"];
    infoItem.pics = serviceInfo[@"pics"];
    self.tripInfoItem = infoItem;
    [list addObject:infoItem];
    
    TPDDProfileItem* profileItem = [TPDDProfileItem new];
    NSDictionary* userInfo = JSON[@"userInfo"];
    profileItem.insiderName = userInfo[@"nick"];
    profileItem.insiderSign = userInfo[@"sign"];
    profileItem.avatar = userInfo[@"heapPic"];
    profileItem.language = userInfo[@"language"];
    profileItem.hobby = userInfo[@"interests"];
    profileItem.registerTime = userInfo[@"gmtModified"];
    profileItem.status = userInfo[@"status"];
    self.insiderProfileItem = profileItem;
    [list addObject:profileItem];
    
    TPDDCommentItem* commentItem = [TPDDCommentItem new];
    NSDictionary* commentInfo = JSON[@"reviewInfo"];
    commentItem.comment = commentInfo[@"lastReview"][@"content"];
    commentItem.commentNum = commentInfo[@"reviewNum"];
    self.tripCommentItem = commentItem;
    [list addObject:commentItem];
    
    TPDDTripItem* tripItem = [TPDDTripItem new];
    tripItem.tripTimeLength = serviceInfo[@"serviceTime"];
    tripItem.tripPeopleNum = serviceInfo[@"maxbuyerNum"];
    tripItem.tripTime = serviceInfo[@"bestTime"];
    tripItem.tripFee = [TPUtils money:serviceInfo[@"price"] WithType:serviceInfo[@"moneyType"]];
    self.tripDetailItem = tripItem;
    [list addObject:tripItem];
    
    return list;
}

/**
 career = teacher;
 city = USA;
 country = "";
 countryCode = 86;
 email = "<null>";
 extInfo = "<null>";
 gender = 0;
 gmtModified = "2015-06-18 00:30:04.0";
 headPic = "http://cuitrip.oss-cn-shenzhen.aliyuncs.com/file";
 interests = coding;
 language = English;
 mobile = 15558015022;
 nick = mx;
 realName = moxin;
 sign = "I am a developer";
 status = 0;
 token = "<null>";
 uid = 15;
 */

@end

