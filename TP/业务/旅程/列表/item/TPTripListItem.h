  
//
//  TPTripListItem.h
//  TP
//
//  Created by moxin on 2015-06-01 19:41:29 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "VZListItem.h"

@interface TPTripListItem : VZListItem

@property(nonatomic,strong) NSString* imageURL;
@property(nonatomic,strong) NSString* status;
@property(nonatomic,strong) NSString* dateString;
@property(nonatomic,strong) NSString* title;
@property(nonatomic,strong) NSString* name;
@property(nonatomic,strong) NSString* location;
@property(nonatomic,strong) NSString* money;

@end

  
