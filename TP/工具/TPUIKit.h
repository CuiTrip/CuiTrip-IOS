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


@end
