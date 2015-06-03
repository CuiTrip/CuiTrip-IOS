//
//  TPUtils.m
//  TP
//
//  Created by moxin on 15/6/3.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPUtils.h"

@implementation TPUtils

+ (UIViewController* )rootViewController
{
    return [[[[UIApplication sharedApplication] delegate] window] rootViewController];
}


@end
