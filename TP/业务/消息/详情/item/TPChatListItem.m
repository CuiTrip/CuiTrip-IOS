  
//
//  TPChatListItem.m
//  TP
//
//  Created by moxin on 2015-06-10 15:33:15 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPChatListItem.h"
#import "VZStringBuilder.h"
@interface TPChatListItem()

@end

@implementation TPChatListItem

- (void)autoKVCBinding:(NSDictionary *)dictionary
{
    [super autoKVCBinding:dictionary];
    
    CGFloat w = 0.7*kTPScreenWidth;
    CGFloat contentHeight = [VZStringBuilder heightForString:self.content Font:ft(14) Width:w-20];
    self.chatContentSize = CGSizeMake(w-20, contentHeight);
    self.chatBKSize = CGSizeMake(w, contentHeight+10+30);
    self.itemHeight = self.chatBKSize.height + 10;
    
    
}

@end

