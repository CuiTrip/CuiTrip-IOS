  
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
    
    return [_API_ stringByAppendingString:@"getServiceInfo"];
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
    
    TPDDInfoItem* info = [TPDDInfoItem new];
    info.name = item.name;
    info.address = item.address;
    info.desc = item.descpt;
    info.score = item.score;
    [list addObject:item];
    
    TPDDProfileItem* profileItem = [TPDDProfileItem new];
//    profileItem.insiderName = item.
//    profileItem.avatar = i
    TPDDCommentItem* commentItem = [TPDDCommentItem new];
    
    TPDDTripItem* tripItem = [TPDDTripItem new];
    tripItem.tripTimeLength = item.serviceTime;
    tripItem.tripTime = item.bestTime;
    tripItem.tripPeopleNum = item.maxbuyerNum;
    
    
    return list;
}

@end

