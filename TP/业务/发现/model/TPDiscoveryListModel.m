  
//
//  TPDiscoveryListModel.m
//  TP
//
//  Created by moxin on 2015-06-01 19:38:20 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPDiscoveryListModel.h"
#import "TPDiscoveryListItem.h"

@interface TPDiscoveryListModel()

@end


/**
 	uid(String): 用户id
 	token(String):  登录凭证
 	insiderId(String)：发现者id
 */
@implementation TPDiscoveryListModel

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods

- (NSDictionary *)dataParams {
    
    //todo:
    return @{@"uid":[TPUser uid],@"token":[TPUser token],@"insiderId":[TPUser uid]};
}

- (NSDictionary* )headerParams{

    return nil;
}


- (NSString *)methodName {
    
    return [_API_ stringByAppendingString:@"getServiceList"];
}

- (NSMutableArray* )responseObjects:(id)JSON
{
  

    self.totalCount = [JSON[@"num"] integerValue];
    //todo:
    NSMutableArray* list = [NSMutableArray new];
    NSArray* result = JSON[@""];
    
    for (NSDictionary* dict in result) {
        
        TPDiscoveryListItem* item =  [TPDiscoveryListItem new];
        [item autoKVCBinding:dict];
        [list addObject:item];
    }
  
    
    return list;
}

@end

