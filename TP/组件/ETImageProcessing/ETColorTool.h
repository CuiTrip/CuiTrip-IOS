//
//  WBGColorTool.h
//  ColorTouch
//
//  Created by jackiedeng on 13-5-29.
//  Copyright (c) 2013年 jackiedeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface ETColorTool : NSObject

//统计图片灰度的直方图，映射到level区间里
+ (NSArray *)colorSumFromImage:(UIImage*)image totalLevel:(int)level;

+ (UIImage *)imageSharpen:(UIImage*)image;

+ (UIImage *)imageGauss:(UIImage*)image;

+ (UIImage *)imageAutoAdjustment:(UIImage*)image;

@end
