//
//  TPUserItem.h
//  TP
//
//  Created by moxin on 15/6/7.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VZItem.h"


typedef NS_ENUM(NSInteger, TPUserType)
{
    kCustomer = 1,
    kProvider = 2,
    kUnknown = -1
    
};


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

@interface TPUserItem : VZItem<NSCoding,NSCopying>

@property(nonatomic,assign)TPUserType type;
@property(nonatomic,strong)NSString *uid;
@property(nonatomic,strong)NSString* country;
@property(nonatomic,strong)NSString* countryCode;
@property(nonatomic,strong)NSString* headPic;
@property(nonatomic,strong)NSString *nick;
@property(nonatomic,strong)NSString* realName;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *token;
@property(nonatomic,strong)NSString* gender;
@property(nonatomic,strong)NSString* language;
@property(nonatomic,strong)NSString* interests;
@property(nonatomic,strong)NSString* career;
@property(nonatomic,strong)NSString* sign;




@end
