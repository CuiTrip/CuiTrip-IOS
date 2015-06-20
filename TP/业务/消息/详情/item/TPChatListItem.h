  
//
//  TPChatListItem.h
//  TP
//
//  Created by moxin on 2015-06-10 15:33:15 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "VZListItem.h"

@interface TPChatListItem : VZListItem

@property(nonatomic,strong)NSString* from;
@property(nonatomic,strong)NSString* to;
@property(nonatomic,strong)NSString* content;
@property(strong,nonatomic)NSString* headPic;
@property(nonatomic,strong)NSString* gmtCreated;

@property(nonatomic,assign)CGSize chatBKSize;
@property(nonatomic,assign)CGSize chatContentSize;
@end

  
