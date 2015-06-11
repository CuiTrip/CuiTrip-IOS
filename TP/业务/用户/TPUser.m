//
//  TPUser.m
//  TP
//
//  Created by moxin on 15/6/1.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPUser.h"

@interface TPUser()

@property(nonatomic,strong)TPUserItem* userItem;

@end

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

- (id)init
{
    self = [super init];
    
    if (self) {
        
        TPUserItem* userItem = [[TMCache sharedCache] objectForKey:kTPCacheKey_User];
        if (userItem) {
            self.userItem = userItem;
        }
        else
        {
            self.userItem = [TPUserItem new];
            self.userItem.type = kCustomer;
        }
    }
    return self;
}

+ (TPUserType)type
{
    return [TPUser sharedInstance].userItem.type;
}

+ (NSString* )avatar
{
    return [TPUser sharedInstance].userItem.headPic;
}

+ (NSString* )userNick
{
    return [TPUser sharedInstance].userItem.nick;
}

+ (NSString* )userName
{
    return [TPUser sharedInstance].userItem.realName;
}

+ (BOOL)isLogined
{
    return [TPUser sharedInstance].userItem.token.length > 0;
}

+ (void)clearUserInfo
{
    TPUser* instance = [TPUser sharedInstance];
    instance -> _userItem = nil;
    [[TMDiskCache sharedCache] removeObjectForKey:kTPCacheKey_User];
}

+ (void)logout
{
    [self clearUserInfo];
}

+ (void)changeUserType:(TPUserType)type
{
    [TPUser sharedInstance].userItem.type = type;
    [self synchronize];
}

+ (void)update:(NSDictionary* )info
{
    TPUserItem* item = [TPUserItem new] ;
    [item autoKVCBinding:info];
    [TPUser sharedInstance].userItem = item;
    [self synchronize];
}

+ (void)synchronize
{
    //持久化
    [[TMCache sharedCache] setObject:[TPUser sharedInstance].userItem forKey:kTPCacheKey_User];
}


@end
