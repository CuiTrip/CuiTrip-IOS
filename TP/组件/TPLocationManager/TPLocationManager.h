//
//  TPLocationManager.h
//  TP
//
//  Created by moxin on 15/6/18.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPLocationManager : NSObject

+ (CLLocationCoordinate2D)currentLocation;

+ (void)startLocation;

+ (void)stopLocation;

@end
