//
//  VZStringBuilder.h
//  TP
//
//  Created by moxin on 15/6/4.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VZStringBuilder : NSObject

+ (float) heightForString:(NSString *)myString  Font:(UIFont *)myFont Width:(float)myWidth;

@end


@interface VZStringBuilder(CoreText)

+ (BOOL)isCoreTextAttribute:(NSString* )attribute;

+ (NSDictionary* )transformCoreTextAttributes:(NSDictionary* )coreTextAttributes;

+ (NSAttributedString* )cleanCoreTextAttributes:(NSAttributedString* )attributedString;

@end
