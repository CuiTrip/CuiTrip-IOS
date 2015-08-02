//
//  TPUserItem.m
//  TP
//
//  Created by moxin on 15/6/7.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPUserItem.h"

/**
 "uid ": "1 ", //用户id
 "mobile": "13711112222", //手机
 "countryCode": "86", // 国家代码
 "headPic": "http: //alicdn.aliyun.com/pic1.jpg", //头像
 "realName": "test1", // 姓名
 "nick": "爱微寻", // 昵称
 "gender": 1, // 性别: 1男 2女 3未知
 "country": "中国", // 国家
 "city": "杭州", // 所在城市
 "language": "普通话， 英语", // 语言
 "career": "老师", // 职业
 "interests": "旅游", // 爱好
 "sign": "世界那么大， 我想去看看", // 签名
 " token": "hapt2t852afa04u022854" // 登录凭证
 */

@implementation TPUserItem

- (void)autoKVCBinding:(NSDictionary *)dictionary
{
    [super autoKVCBinding:dictionary];
    
    //todo...
    self.uid = [NSString stringWithFormat:@"%@",dictionary[@"uid"]];
    
    NSString* extInfoDic = dictionary[@"extInfo"];
    NSData *extInfoData = [extInfoDic dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *extInfoObj = [NSJSONSerialization JSONObjectWithData:extInfoData options:0 error:nil];
    NSLog(@"extInfoObj:%@",extInfoObj);
//    self.introduce = extInfoObj[@"introduce"];
//    self.introduceAuditStatus = extInfoObj[@"introduceAuditStatus"];
//    self.introduceFailedReason = extInfoObj[@"introduceFailedReason"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        self.type = [[aDecoder decodeObjectForKey:@"type"] integerValue];;
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.headPic = [aDecoder decodeObjectForKey:@"headPic"];
        self.realName = [aDecoder decodeObjectForKey:@"username"];
        self.nick = [aDecoder decodeObjectForKey:@"nickname"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.token = [aDecoder decodeObjectForKey:@"accesstoken"];
        self.country = [aDecoder decodeObjectForKey:@"country"];
        self.countryCode = [aDecoder decodeObjectForKey:@"countryCode"];
        self.language = [aDecoder decodeObjectForKey:@"language"];
        self.career = [aDecoder decodeObjectForKey:@"career"];
        self.interests = [aDecoder decodeObjectForKey:@"interests"];
        self.sign = [aDecoder decodeObjectForKey:@"sign"];
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.gender = [aDecoder decodeObjectForKey:@"gender"];
        self.pwd = [aDecoder decodeObjectForKey:@"pwd"];
        self.city = [aDecoder decodeObjectForKey:@"city"];
        self.extInfo = [aDecoder decodeObjectForKey:@"extInfo"];
        self.extInfoDic = [aDecoder decodeObjectForKey:@"extInfo"];
        id jsonObject = [NSJSONSerialization JSONObjectWithData:[self.extInfo dataUsingEncoding:NSUTF8StringEncoding]
                                                        options:NSJSONReadingAllowFragments
                                                          error:nil];
        if ([jsonObject isKindOfClass:[NSDictionary class]]) {
            self.extInfoDic = [NSDictionary dictionaryWithDictionary:jsonObject];
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeObject:@(self.type) forKey:@"type"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.headPic forKey:@"headPic"];
    [aCoder encodeObject:self.realName forKey:@"username"];
    [aCoder encodeObject:self.nick forKey:@"nickname"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.token forKey:@"accesstoken"];
    [aCoder encodeObject:self.countryCode forKey:@"countryCode"];
    [aCoder encodeObject:self.country forKey:@"country"];
    [aCoder encodeObject:self.language forKey:@"language"];
    [aCoder encodeObject:self.career forKey:@"career"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.gender forKey:@"gender"];
    [aCoder encodeObject:self.sign forKey:@"sign"];
    [aCoder encodeObject:self.interests forKey:@"interests"];
    [aCoder encodeObject:self.pwd forKey:@"pwd"];
    [aCoder encodeObject:self.city forKey:@"city"];
    [aCoder encodeObject:self.extInfo forKey:@"extInfo"];
}

- (id)copyWithZone:(NSZone *)zone
{
    TPUserItem* item = [super copyWithZone:zone];
    item.type = self.type;
    item.uid = self.uid;
    item.headPic = self.headPic;
    item.nick = self.nick;
    item.realName = self.realName;
    item.country = self.country;
    item.countryCode = self.countryCode;
    item.language = self.language;
    item.career= self.career;
    item.gender = self.gender;
    item.sign = self.sign;
    item.interests = self.interests;
    item.mobile = self.mobile;
    item.token = self.token;
    item.pwd = self.pwd;
    item.city = self.city;
    item.extInfo = self.extInfo;
//    item.introduce = self.introduce;
//    item.introduceAuditStatus = self.introduceAuditStatus;
//    item.introduceFailedReason = self.introduceFailedReason;
    
    return item;
}

@end
