//
//  TPUser.h
//  TP
//
//  Created by moxin on 15/6/1.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    kCustomer = 1,
    kProvider = 2,
    kUnknown = -1

}TPUserType;

@class TPUserItem;
@interface TPUser : NSObject

@property(nonatomic,strong,strong) TPUserItem* user;

+ (instancetype)sharedInstance;

+ (TPUserType)type;

+ (NSString* )avatar;

+ (NSString* )userNick;

+ (NSString* )userName;

+ (BOOL)isLogined;

+ (void)clearUserInfo;

+ (void)logout;

@end
