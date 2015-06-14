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

@end
