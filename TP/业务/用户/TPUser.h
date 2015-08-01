//
//  TPUser.h
//  TP
//
//  Created by moxin on 15/6/1.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPUserItem.h"

@interface TPUser : NSObject
+ (instancetype)sharedInstance;

+ (TPUserType)type;

+ (NSString* )avatar;

+ (NSString* )uid;

+ (NSString* )userNick;

+ (NSString* )userName;

+ (NSString* )mobile;

+ (NSString* )pwd;

+ (NSString* )token;

+ (NSString* )gender;

+ (NSString* )country;

+ (NSString* )city;

+ (NSString* )language;

+ (NSString* )hobby;

+ (NSString* )career;

+ (NSString* )sign;

+ (NSString* )debugInfo;

+ (NSString* )extInfo;

+ (NSString* )introduce;

+ (NSString* )introduceAuditStatus;

+ (NSString* )introduceFailedReason;

//+ (NSString* )

+ (BOOL)isLogined;

+ (void)clearUserInfo;

+ (void)logout;

+ (void)changeUserType:(TPUserType)type synchronizeToServer:(BOOL)b;

+ (void)changeAvatar:(NSString* )avatar;

+ (void)updateUserProfile:(NSDictionary* )info withCompletion:(void(^)(NSError* err))callback;

+ (void)update:(NSDictionary* )info;

+ (void)synchronize;

@end
