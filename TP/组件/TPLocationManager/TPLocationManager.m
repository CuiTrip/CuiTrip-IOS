//
//  TPLocationManager.m
//  TP
//
//  Created by moxin on 15/6/18.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPLocationManager.h"

@interface TPLocationManager()

@property(nonatomic,strong)NSString* city;
@property(nonatomic,strong)NSString* country;
@property(nonatomic,strong)NSString* countryCode;
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

+ (NSString* )locationCity
{
    return [TPLocationManager sharedInstance].city;
}

+ (NSString* )locationCountry
{
    return [TPLocationManager sharedInstance].country;
}

+ (NSString* )locationCountryCode
{
    return [TPLocationManager sharedInstance].countryCode;
}

+ (void)startLocation
{
    [self startLocationWithCompletion:nil];
}

+ (void)startLocationWithCompletion:(void (^)(CLLocation *))callback
{
    INTULocationRequestID requestId = [[INTULocationManager sharedInstance]requestLocationWithDesiredAccuracy:INTULocationAccuracyBlock timeout:5.0 block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
        
        [TPLocationManager sharedInstance].currentLocation = currentLocation.coordinate;
        
        //geocoding
        CLGeocoder *reverseGeocoder = [[CLGeocoder alloc] init];
        [reverseGeocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error){
            
             if (error){
                 return;
             }
            
             CLPlacemark *myPlacemark = [placemarks objectAtIndex:0];
             NSString *countryCode = myPlacemark.ISOcountryCode;
             NSString *countryName = myPlacemark.country;
             NSString* city = myPlacemark.locality;
             NSLog(@"{My country code: %@\n countryName: %@\n city:%@\n", countryCode, countryName,city);
            [TPLocationManager sharedInstance].country = countryName;
            [TPLocationManager sharedInstance].countryCode = countryCode;
            [TPLocationManager sharedInstance].city = city;
             
         }];
        
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
