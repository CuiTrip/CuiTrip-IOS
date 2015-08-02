  
//
//  TPTripListModel.m
//  TP
//
//  Created by moxin on 2015-06-01 19:41:29 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPTripListModel.h"
#import "TPTripListItem.h"

@interface TPTripListModel()

@end

@implementation TPTripListModel

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods

- (NSDictionary *)dataParams {
    
    NSString* userType = [TPUser type] == kCustomer?@"1":@"2";
    
    return @{
             @"uid":[TPUser uid]?:@"",
             @"token":[TPUser token]?:
             @"",@"userType":userType,
             @"size":@"10",
             @"start":[NSString stringWithFormat:@"%ld",(long)self.currentPageIndex*self.pageSize]
             };
    
}

- (NSInteger)pageSize
{
    return 10;
}

- (NSString *)methodName {
    
    return [_API_ stringByAppendingString:@"getOrderList"];
}

- (VZHTTPRequestConfig)requestConfig
{
    VZHTTPRequestConfig config = vz_defaultHTTPRequestConfig();
    config.requestMethod = VZHTTPMethodPOST;
    return config;
}

- (NSMutableArray* )responseObjects:(id)JSON
{
    NSMutableArray* ret = [NSMutableArray new];
    
    NSArray* list = JSON;
    
    for (NSDictionary* dict in list) {
        
        TPTripListItem* item = [TPTripListItem new];
        [item autoKVCBinding:dict];
        [ret addObject:item];
    }
    return ret;
}

@end

