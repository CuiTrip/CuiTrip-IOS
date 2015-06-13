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

+ (NSString* )uid;

+ (NSString* )userNick;

+ (NSString* )userName;

+ (NSString* )mobile;

+ (NSString* )pwd;

+ (NSString* )token;

+ (BOOL)isLogined;

+ (void)clearUserInfo;

+ (void)logout;

+ (void)changeUserType:(TPUserType)type;

+ (void)update:(NSDictionary* )info;

+ (void)synchronize;

@end
