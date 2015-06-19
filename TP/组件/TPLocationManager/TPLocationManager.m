//
//  TPLocationManager.m
//  TP
//
//  Created by moxin on 15/6/18.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPLocationManager.h"

@interface TPLocationManager()

@property(nonatomic,assign)INTULocationRequestID requestId;
@property(nonatomic,assign)CLLocationCoordinate2D currentLocation;

@end

@implementation TPLocationManager

+ (instancetype)sharedInstance
{
    static TPLocationManager* manager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [TPLocationManager new];
    });
    return manager;
}

+ (CLLocationCoordinate2D)currentLocation
{
    return [TPLocationManager sharedInstance].currentLocation;
}

+ (void)startLocation
{
    [self startLocationWithCompletion:nil];
}

+ (void)startLocationWithCompletion:(void (^)(CLLocation *))callback
{
    INTULocationRequestID requestId = [[INTULocationManager sharedInstance]requestLocationWithDesiredAccuracy:INTULocationAccuracyBlock timeout:5.0 block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
        
        [TPLocationManager sharedInstance].currentLocation = currentLocation.coordinate;
        if (callback) {
            callback(currentLocation);
        }
    }];
    [TPLocationManager sharedInstance].requestId = requestId;
}

+ (void)stopLocation
{
    INTULocationRequestID requestId = [TPLocationManager sharedInstance].requestId;
    [[INTULocationManager sharedInstance] cancelLocationRequest:requestId];
}

@end
