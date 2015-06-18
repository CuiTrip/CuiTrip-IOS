  
//
//  TPCommentListItem.h
//  TP
//
//  Created by moxin on 2015-06-03 23:49:57 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "VZListItem.h"

@interface TPCommentListItem : VZListItem

@property(nonatomic,strong)NSString *No;
@property(nonatomic,strong)NSString *cid;
@property(nonatomic,strong)NSString *travellerId;
@property(nonatomic,strong)NSString *insiderHeadPic;
@property(nonatomic,strong)NSString *insiderNickName;
@property(nonatomic,strong)NSString* insiderLocation;
@property(nonatomic,strong)NSString *gmtCreated;
@property(nonatomic,strong)NSString *content;


@property(nonatomic,assign) CGFloat contentHeight;


@end

  
