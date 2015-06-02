  
//
//  TPDiscoveryListItem.h
//  TP
//
//  Created by moxin on 2015-06-01 19:38:20 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "VZListItem.h"

@interface TPDiscoveryListItem : VZListItem

@property(nonatomic,strong) NSString* cardImageUrl;
@property(nonatomic,strong) NSString* avatarUrl;
@property(nonatomic,strong) NSString* cardName;
@property(nonatomic,strong) NSString* userName;
@property(nonatomic,strong) NSString* userCity;

@property(nonatomic,strong) NSMutableAttributedString* attributedUserString;


@end

  
