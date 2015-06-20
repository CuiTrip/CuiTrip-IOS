//
//  TPLocationManager.h
//  TP
//
//  Created by moxin on 15/6/18.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPLocationManager : NSObject

+ (instancetype)sharedInstance;

+ (CLLocationCoordinate2D)currentLocation;

+ (NSString* )locationCity;

+ (NSString* )locationCountry;

+ (NSString* )locationCountryCode;

+ (void)startLocation;

+ (void)startLocationWithCompletion:(void(^)(CLLocation* location))callback;

+ (void)stopLocation;


@end
