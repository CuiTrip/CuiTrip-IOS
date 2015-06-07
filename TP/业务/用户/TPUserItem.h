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


@interface TPUserItem : VZItem<NSCoding,NSCopying>

@property(nonatomic,assign)TPUserType type;
@property(nonatomic,strong)NSString *uid;
@property(nonatomic,strong)NSString* avatar;
@property(nonatomic,strong)NSString *username;
@property(nonatomic,strong)NSString *password;
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *accesstoken;



@end
