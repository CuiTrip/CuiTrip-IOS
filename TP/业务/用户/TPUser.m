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

+ (NSString* )uid
{
    return [TPUser sharedInstance].userItem.uid;
}


+ (NSString* )userNick
{
    return [TPUser sharedInstance].userItem.nick;
}

+ (NSString* )userName
{
    return [TPUser sharedInstance].userItem.realName;
}

+ (NSString* )mobile
{
    return [TPUser sharedInstance].userItem.mobile;
}

+ (NSString* )pwd
{
    return [TPUser sharedInstance].userItem.pwd;
}

+ (NSString* )token
{
    return [TPUser sharedInstance].userItem.token;
}

+ (NSString* )gender
{
    return [TPUser sharedInstance].userItem.gender;
}

+ (NSString* )country
{
    return [TPUser sharedInstance].userItem.country;
}

+ (NSString* )city
{
    return [TPUser sharedInstance].userItem.city;
}

+ (NSString* )language
{
    return [TPUser sharedInstance].userItem.language;
}

+ (NSString* )hobby
{
    return [TPUser sharedInstance].userItem.interests;
}

+ (NSString* )career
{
    return [TPUser sharedInstance].userItem.career;
}

+ (NSString* )sign
{
    return [TPUser sharedInstance].userItem.sign;
}


+ (NSString* )debugInfo
{
    return [TPUser sharedInstance].userItem.description;
}

+ (BOOL)isLogined
{
    return [TPUser sharedInstance].userItem.token.length > 0;
}

+ (void)clearUserInfo
{
    TPUser* instance = [TPUser sharedInstance];
    instance.userItem.token = @"";
    [self synchronize];
}


+ (void)logout
{
    [self clearUserInfo];
}

+ (void)changeUserType:(TPUserType)type synchronizeToServer:(BOOL)b
{
    [TPUser sharedInstance].userItem.type = type;
    [self synchronize];
    
    if (b) {
        
        NSString* userType = @"0";
        if (type == kProvider) {
            userType = @"1";
        }
        NSDictionary* info  = @{@"uid":[TPUser uid]?:@"",@"token":[TPUser token]?:@"",@"type":userType};
        VZHTTPRequestConfig config = vz_defaultHTTPRequestConfig();
        config.requestMethod = VZHTTPMethodPOST;
        [[VZHTTPNetworkAgent sharedInstance] HTTP:[_API_ stringByAppendingString:@"changeType"]
                                    requestConfig:config
                                   responseConfig:vz_defaultHTTPResponseConfig()
                                           params:info
                                completionHandler:^(VZHTTPConnectionOperation *connection, NSString *responseString, id responseObj, NSError *error) {
                                    
                                    if (!error) {
                                        NSInteger code = [responseObj[@"code"] integerValue];
                                        
                                        if (code == 0) {
                                            //成功
                                        }
                                        else
                                        {
                                            //失败
                                        }
                                    }
                                    else
                                    {
                                        //失败
                                    }
                                    
                                }];
    }
}

+ (void)changeUserTypeToServer:(TPUserType)type
{
    
}

+ (void)changeAvatar:(NSString* )avatar
{
    [TPUser sharedInstance].userItem.headPic = avatar;
    [self synchronize];
}

+ (void)updateUserProfile:(NSDictionary *)info withCompletion:(void (^)(NSError *))callback
{
    VZHTTPRequestConfig config = vz_defaultHTTPRequestConfig();
    config.requestMethod = VZHTTPMethodPOST;
    [[VZHTTPNetworkAgent sharedInstance] HTTP:[_API_ stringByAppendingString:@"modifyUserInfo"]
                                requestConfig:config
                               responseConfig:vz_defaultHTTPResponseConfig()
                                       params:info
                            completionHandler:^(VZHTTPConnectionOperation *connection, NSString *responseString, id responseObj, NSError *error) {
                                
                                if (!error) {
                                    NSInteger code = [responseObj[@"code"] integerValue];
                                    
                                    if (code == 0) {
                                       // TOAST([UIScreen mainScreen], @"更新成功!");
                                        NSDictionary* result = responseObj[@"result"];
                                        [TPUser update:result];
                                        
                                        if (callback) {
                                            callback(nil);
                                        }
                                    }
                                    else
                                    {
                                        NSError* err= [TPUtils errorForHTTP:responseObj];
                                        if (callback) {
                                            callback(err);
                                        }
                                        //TOAST_ERROR(self, err);
                                    }
                                }
                                else
                                {
                                    //TOAST_ERROR(self, error);
                                    if (callback) {
                                        callback(error);
                                    }
                                }
                                
                            }];
}

+ (void)update:(NSDictionary* )info
{
    TPUserItem* item = [TPUserItem new] ;
    [item autoKVCBinding:info];
    item.type = [TPUser sharedInstance].userItem.type;
    [TPUser sharedInstance].userItem = item;
    [self synchronize];
}

+ (void)synchronize
{
    //持久化
    [[TMCache sharedCache] setObject:[TPUser sharedInstance].userItem forKey:kTPCacheKey_User];
}


@end
