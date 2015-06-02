//
//  TPUIKit.m
//  TP
//
//  Created by moxin on 15/6/2.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPUIKit.h"

@implementation TPUIKit

+ (UILabel* )label:(UIColor* )color Font:(UIFont* )font;
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = font;
    label.textColor = color;
    return label;

}

+ (UIImageView* )imageView
{
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = true;
    imageView.userInteractionEnabled = true;
    return imageView;
}

+ (UIImageView* )roundImageView:(CGSize)sz Border:(UIColor* )color
{
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:(CGRect){0,0,sz}];
    imageView.layer.cornerRadius = 0.5*sz.width;
    imageView.layer.borderColor = color.CGColor;
    imageView.layer.borderWidth = 1.0f;
    imageView.layer.masksToBounds=  true;
    imageView.userInteractionEnabled = true;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.userInteractionEnabled = true;
    
    return imageView;
}


@end
