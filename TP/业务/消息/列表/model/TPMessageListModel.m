  
//
//  TPMessageListModel.m
//  TP
//
//  Created by moxin on 2015-06-01 19:41:08 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPMessageListModel.h"
#import "TPMessageListItem.h"
@interface TPMessageListModel()

@end

@implementation TPMessageListModel

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods

- (NSDictionary *)dataParams {
    
    TPUserType type = [TPUser type];
    
    NSString* changeType = @"";
    if (type == kCustomer) {
        changeType = @"0";
    }
    else
    {
        changeType = @"1";
    }
    return @{@"uid":[TPUser uid]?:@"",@"token":[TPUser token]?:@"",@"changeType":changeType};
}

- (VZHTTPRequestConfig)requestConfig
{
    VZHTTPRequestConfig config = vz_defaultHTTPRequestConfig();
    config.requestMethod = VZHTTPMethodPOST;
    return config;
}


- (NSString *)methodName {
    
    return [_API_ stringByAppendingString:@"getMessageList"];
}

- (NSMutableArray* )responseObjects:(id)JSON
{
  
    NSMutableArray* ret = [NSMutableArray new];
    NSArray* list = JSON;
    
    for (NSDictionary* info in list) {

        TPMessageListItem* item = [TPMessageListItem new];
        [item autoKVCBinding:info];
        [ret addObject:item];
    }
    return ret;
}

@end

