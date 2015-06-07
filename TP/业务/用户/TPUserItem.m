//
//  TPUserItem.m
//  TP
//
//  Created by moxin on 15/6/7.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPUserItem.h"

@implementation TPUserItem

- (void)autoKVCBinding:(NSDictionary *)dictionary
{
    [super autoKVCBinding:dictionary];
    
    //todo...
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        self.type = [[aDecoder decodeObjectForKey:@"type"] integerValue];;
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.avatar = [aDecoder decodeObjectForKey:@"avatar"];
        self.username = [aDecoder decodeObjectForKey:@"username"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        self.nickname = [aDecoder decodeObjectForKey:@"nickname"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.accesstoken = [aDecoder decodeObjectForKey:@"accesstoken"];

    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeObject:@(self.type) forKey:@"type"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.avatar forKey:@"avatar"];
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.accesstoken forKey:@"accesstoken"];
;
}

- (id)copyWithZone:(NSZone *)zone
{
    TPUserItem* item = [super copyWithZone:zone];
    item.type = self.type;
    item.uid = self.uid;
    item.avatar = self.avatar;
    item.username = self.username;
    item.password = self.password;
    item.nickname = self.nickname;
    item.mobile = self.mobile;
    item.accesstoken = self.accesstoken;
    
    return item;
}

@end
