  
//
//  TPCommentListItem.h
//  TP
//
//  Created by moxin on 2015-06-03 23:49:57 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "VZListItem.h"

@interface TPCommentListItem : VZListItem

@property(nonatomic,strong) NSString* content;
@property(nonatomic,strong) NSString* userName;
@property(nonatomic,strong) NSString* avatarUrl;
@property(nonatomic,strong) NSString* userLocation;

@property(nonatomic,assign) CGFloat contentHeight;


@end

  
