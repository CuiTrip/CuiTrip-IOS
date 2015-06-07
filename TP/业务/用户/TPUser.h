//
//  TPUser.h
//  TP
//
//  Created by moxin on 15/6/1.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPUserItem.h"

@class TPUserItem;
@interface TPUser : NSObject

@property(nonatomic,strong) TPUserItem* user;

+ (instancetype)sharedInstance;

+ (TPUserType)type;

+ (NSString* )avatar;

+ (NSString* )userNick;

+ (NSString* )userName;

+ (BOOL)isLogined;

+ (void)clearUserInfo;

+ (void)logout;

+ (void)changeUserType:(TPUserType)type;

+ (void)synchronize;

@end
