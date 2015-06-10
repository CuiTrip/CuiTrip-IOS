  
//
//  TPMessageListItem.h
//  TP
//
//  Created by moxin on 2015-06-01 19:41:08 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "VZListItem.h"

@interface TPMessageListItem : VZListItem

@property(nonatomic,strong) NSString* title;
@property(nonatomic,strong) NSString* avatarURL;
@property(nonatomic,strong) NSString* desc;
@property(nonatomic,assign) BOOL hasNewMsg;

@end

  
