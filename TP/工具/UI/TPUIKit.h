//
//  TPUIKit.h
//  TP
//
//  Created by moxin on 15/6/2.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPUIKit : NSObject

+ (UILabel* )label:(UIColor* )color Font:(UIFont* )font;

+ (UIImageView* )imageView;

+ (UIImageView* )roundImageView:(CGSize)sz Border:(UIColor* )color;

+ (UIView* )emptyView;

+ (UIView* )defaultExceptionView:(NSString* )title SubTitle:(NSString* )subTitle btnTitle:(NSString* )btn Callback:(void(^)(void))c;

+ (void )showRequestErrorView:(UIView* )v retryCallback:(void(^)(void))c;

+ (void )showSessionErrorView:(UIView* )v loginSuccessCallback:(void(^)(void))c;

+ (void)removeExceptionView:(UIView* )v;


@end
