//
//  TPAPNS.h
//  TP
//
//  Created by moxin on 15/6/8.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPAPNS : NSObject

/// 请在appDelete的didRegisterForRemoteNotificationsWithDeviceToken中设置此属性
@property (nonatomic, strong) NSString *deviceToken;
@property (nonatomic, assign, readonly) UIRemoteNotificationType remoteNotificationType;

+ (instancetype)sharedInstance;

- (void)setup:(NSDictionary* )lauchOption;
- (void)tearDown;
- (void)registerRemoteNotification;
- (void)receiveRemoteNotification:(NSDictionary* )message;
- (void)updateDeviceToken:(NSData *)tokenData;
- (void)removeLocalMessage;
- (NSDictionary* )localAPNSMessage;

@end
