//
//  TPAPNS.m
//  TP
//
//  Created by moxin on 15/6/8.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPAPNS.h"
#import "UMessage.h"

static NSString * const kAPNSInfoPersistKey = @"kAPNSInfoPersistKey";
static NSString * const kAPNSInfoKeyDeviceToken = @"DeviceToken";
static NSString * const kAPNSInfoKeyTokenReported = @"TokenReported";

@interface TPAPNS ()
@property (nonatomic, assign) BOOL tokenReported;
@end

@implementation TPAPNS


#pragma mark - Super Methods
- (void)dealloc
{
    // Release code
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        [self recoverApnsInfo];
    }
    
    return self;
}

#pragma mark - Public Methods
+ (instancetype)sharedInstance
{
    static TPAPNS *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TPAPNS alloc] init];;
    });
    return instance;
}

- (void)setup:(NSDictionary* )lauchOption
{
    //友盟
    [UMessage startWithAppkey:um_appKey launchOptions:lauchOption];
    
}

- (void)tearDown
{

}

#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
- (void)registerRemoteNotification
{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    if(UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        //register remoteNotification types
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"Accept";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"category1";//这组动作的唯一标示
        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        
        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                     categories:[NSSet setWithObject:categorys]];
        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
        
    } else{
        //register remoteNotification types
        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
         |UIRemoteNotificationTypeSound
         |UIRemoteNotificationTypeAlert];
    }
#else
    
    //register remoteNotification types
    [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
     |UIRemoteNotificationTypeSound
     |UIRemoteNotificationTypeAlert];
    
#endif
    
}

- (NSString *)deviceTokenStrWithData:(NSData *)data
{
    NSString *dtStr = data.description;
    dtStr = [dtStr stringByReplacingOccurrencesOfString:@"<" withString:@""];
    dtStr = [dtStr stringByReplacingOccurrencesOfString:@">" withString:@""];
    dtStr = [dtStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    return dtStr;
}

- (UIRemoteNotificationType)remoteNotificationType
{
    
    return [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
}

#pragma mark - Delegate Methods

#pragma mark - Private Methods
- (void)updateDeviceToken:(NSData *)tokenData;
{
    if (!tokenData) {
        return;
    }
    [UMessage registerDeviceToken:tokenData];
    
    //同步到服务器
    NSString *deviceToken = [self deviceTokenStrWithData:tokenData];
    
    if (deviceToken.length > 0 && [TPUser uid].length > 0 && [TPUser token].length > 0) {
        
        //upload deviceToken
        VZHTTPRequestConfig config = vz_defaultHTTPRequestConfig();
        config.requestMethod = VZHTTPMethodPOST;
        [[VZHTTPNetworkAgent sharedInstance] HTTP:[_API_ stringByAppendingString:@"upDevicetoken"]
                                    requestConfig:config
                                   responseConfig:vz_defaultHTTPResponseConfig()
                                           params:@{@"client":@"iOS",
                                                    @"uid":[TPUser uid],
                                                    @"token":[TPUser token],
                                                    @"deviceToken":deviceToken}
                                completionHandler:^(VZHTTPConnectionOperation *connection, NSString *responseString, id responseObj, NSError *error) {
                                    
                                    [self onReportDeviceToken:deviceToken success:error == nil];
                                    
                                }];
   
    }
}

- (void)onReportDeviceToken:(NSString *)deviceToken success:(BOOL)success
{
    if (!deviceToken) {
        return;
    }
    
    self.deviceToken = deviceToken;
    self.tokenReported = success;
    [self saveApnsInfo];
}

- (void)saveApnsInfo
{
    if (!self.deviceToken) {
        return;
    }
    
    NSMutableDictionary *apnsInfo = [NSMutableDictionary dictionary];
    apnsInfo[kAPNSInfoKeyDeviceToken] = self.deviceToken;
    apnsInfo[kAPNSInfoKeyTokenReported] = @(self.tokenReported);
    [[TMCache sharedCache] setObject:apnsInfo forKey:kTPCacheKey_APNS];

}

- (void)recoverApnsInfo
{
    NSDictionary *apnsInfo = [[TMCache sharedCache] objectForKey:kTPCacheKey_APNS];
    if (IsDictionaryValid(apnsInfo)) {
        self.deviceToken = apnsInfo[kAPNSInfoKeyDeviceToken];
        self.tokenReported = vzBool(apnsInfo[kAPNSInfoKeyTokenReported], NO);
    }
}


@end
