  
//
//  TPDDProfileItem.m
//  TP
//
//  Created by moxin on 2015-06-02 22:56:45 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPDDProfileItem.h"

@interface TPDDProfileItem()

@end

@implementation TPDDProfileItem

- (void)autoKVCBinding:(NSDictionary *)dictionary
{
    [super autoKVCBinding:dictionary];
    
    //todo...
    NSString* extInfoDic = dictionary[@"extInfo"];
    NSData *extInfoData = [extInfoDic dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *extInfoObj = [NSJSONSerialization JSONObjectWithData:extInfoData options:0 error:nil];
    NSLog(@"extInfoObj:%@",extInfoObj);
    self.introduce = extInfoObj[@"introduce"];
    self.introduceAuditStatus = extInfoObj[@"introduceAuditStatus"];
    self.introduceFailedReason = extInfoObj[@"introduceFailedReason"];
}

@end

