//
//  TPStarView.m
//  TP
//
//  Created by moxin on 15/6/5.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPStarView.h"


@interface TPStarView()
@property(nonatomic,strong) UIImageView* startView;
@end

@implementation TPStarView

+ (UIImageView* )starViewWithCount:(CGFloat)count
{
    UIImage* img = __image(@"star_highlight");
    
    int ws = (int)(count);
    float remains = count - ws;
    bool hasHalfStar = remains >= 0.5 ? true:false;
    
    int w = ws * (130 / 5) ;
    w += hasHalfStar?0.5*(130 / 5):0;
    
    CGRect rect = CGRectMake(0, 0, w, 24);
    
    CGImageRef imgRef = CGImageCreateWithImageInRect(img.CGImage, rect);
    UIImage* clippedImage = [UIImage imageWithCGImage:imgRef];
    CGImageRelease(imgRef);
    
    UIImageView* icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, w, 24)];
    icon.image = clippedImage;
    icon.clipsToBounds = true;
    icon.contentMode = UIViewContentModeLeft;
    
    return icon;
}



@end
