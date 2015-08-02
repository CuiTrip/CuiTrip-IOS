  
//
//  TPMyServiceListModel.m
//  TP
//
//  Created by moxin on 2015-06-01 19:52:11 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPMyServiceListModel.h"
#import "TPMyServiceListItem.h"

@interface TPMyServiceListModel()

@end

@implementation TPMyServiceListModel

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods

- (NSDictionary *)dataParams {
    
    return @{@"uid":[TPUser uid]?:@"",@"token":[TPUser token]?:@"",
             @"start":[NSString stringWithFormat:@"%ld",(long)self.currentPageIndex*self.pageSize],
             @"size":@"10"
             };
}

- (NSInteger)pageSize
{
    return 10;
}

- (VZHTTPRequestConfig)requestConfig
{
    VZHTTPRequestConfig config = vz_defaultHTTPRequestConfig();
    config.requestMethod = VZHTTPMethodPOST;
    return config;
}


- (NSString *)methodName {
    
    return [_API_ stringByAppendingString:@"getServiceList"];
}

- (NSMutableArray* )responseObjects:(id)JSON
{
    NSMutableArray* list = [NSMutableArray new];
    
    for (NSDictionary* info in JSON) {
        
        TPMyServiceListItem* item = [TPMyServiceListItem new];
        [item autoKVCBinding:info];
        [list addObject:item];
    }
    
    return list;
}

@end

