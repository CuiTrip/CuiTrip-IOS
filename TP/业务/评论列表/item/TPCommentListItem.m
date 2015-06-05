  
//
//  TPCommentListItem.m
//  TP
//
//  Created by moxin on 2015-06-03 23:49:57 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPCommentListItem.h"
#import "VZStringBuilder.h"

@interface TPCommentListItem()

@end

@implementation TPCommentListItem

- (void)autoKVCBinding:(NSDictionary *)dictionary
{
    [super autoKVCBinding:dictionary];
    
    //todo...
    self.contentHeight = [VZStringBuilder heightForString:self.content Font:ft(14) Width:kTPScreenWidth-24];
}

@end

