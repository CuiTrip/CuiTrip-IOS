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
/**
 *	@brief	注册remote notification，请在appDelete的becomeActive方法中调用此方法进行注册。
 */
- (void)registerRemoteNotification;
- (void)updateDeviceToken:(NSData *)tokenData;

@end
