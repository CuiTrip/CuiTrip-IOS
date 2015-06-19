  
//
//  TPCommentListModel.m
//  TP
//
//  Created by moxin on 2015-06-03 23:49:57 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPCommentListModel.h"
#import "TPCommentListItem.h"

@interface TPCommentListModel()

@end

@implementation TPCommentListModel

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods


- (NSDictionary *)dataParams {
    
    return @{@"uid":[TPUser uid]?:@"",
             @"token":[TPUser token]?:@"",
             @"sid":self.sid?:@""};
}


- (VZHTTPRequestConfig)requestConfig
{
    VZHTTPRequestConfig config = vz_defaultHTTPRequestConfig();
    config.requestMethod = VZHTTPMethodPOST;
    return config;
}

- (NSString *)methodName {
    
    return [_API_ stringByAppendingPathComponent:@"getReviewList"];
}

- (NSMutableArray* )responseObjects:(id)JSON
{
    NSMutableArray* ret = [NSMutableArray new];
    
    NSArray* comments = JSON;
    
    for (NSDictionary* dict in comments) {
        
        TPCommentListItem* item = [TPCommentListItem new];
        [item autoKVCBinding:dict];
        item.itemHeight = 15+item.contentHeight+12+30+12;
        
        [ret addObject:item];
    }

    
    return ret;
}

@end

