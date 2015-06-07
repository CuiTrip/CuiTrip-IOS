//
//  TPUser.m
//  TP
//
//  Created by moxin on 15/6/1.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPUser.h"

@implementation TPUser

+ (instancetype)sharedInstance
{
    static TPUser* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [TPUser new];
    });
    
    return instance;
}

+ (TPUserType)type
{
    return kCustomer;
}

+ (NSString* )avatar
{
    return nil;
}

+ (NSString* )userNick
{
    return nil;
}

+ (NSString* )userName
{
    return nil;
}

+ (BOOL)isLogined
{
    return NO;
}

+ (void)clearUserInfo
{
    
}

+ (void)logout
{
    [self clearUserInfo];

}


@end
