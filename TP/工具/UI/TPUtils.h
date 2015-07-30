//
//  TPUtils.h
//  TP
//
//  Created by moxin on 15/6/3.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPUtils : NSObject

+ (UIViewController* )rootViewController;

+ (NSString* )defaultLocalCode;

+ (NSString* )defaultCountry;

+ (NSError* )errorForHTTP:(NSDictionary* )dict;

+ (void)localCodesWithCompletion:(void(^)(NSArray* list))completion;

+ (NSString* )monthDateFormatString:(NSDate* )date;

+ (NSString* )fullDateFormatString:(NSDate* )date;

+ (NSString* )timeFormatString:(NSDate* )dateString;

+ (NSDate *)dateWithString:(NSString *)dateString forFormat:(NSString *)format;

+ (NSString *)stringWithDate:(NSDate *)date forFormat:(NSString *)format;

+ (NSString *)timeInfoWithDate:(NSDate *)date;

+ (NSString *)timeInfoWithDateString:(NSString *)dateString forFormat:(NSString *)format;

+ (NSString *)shortTimeInfoWithDate:(NSDate *)date;

+ (NSString *)shortTimeInfoWithDateString:(NSString *)dateString forFormat:(NSString *)format;

+ (NSString* )money:(NSString* )money WithType:(NSString* )type;

+ (void)uploadImage:(NSString* )base64 WithCompletion:(void(^)(NSString* url,NSError* err))callback;

+ (NSString* )changeDateFormatString:(NSString *)dateString FromOldFmt:(NSString *)old ToNew:(NSString *)fmt;

+ (void)getLANIPAddressWithCompletion:(void (^)(NSString *IPAddress))completion;

+ (void)getWANIPAddressWithCompletion:(void(^)(NSString *IPAddress))completion;

@end
