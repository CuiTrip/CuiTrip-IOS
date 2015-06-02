//
//  UIView+VZEX.m
//  TP
//
//  Created by moxin on 15/6/1.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "UIView+VZEX.h"

@implementation UIView (VZEX)

- (CGFloat)vzLeft {
    return self.frame.origin.x;
}

- (void)setVzLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)vzTop {
    return self.frame.origin.y;
}

- (void)setVzTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)vzRight {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setVzRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)vzBottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setVzBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


- (CGFloat)vzCenterX {
    return self.center.x;
}

- (void)setVzCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)vzCenterY {
    return self.center.y;
}

- (void)setVzCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)vzWidth {
    return self.frame.size.width;
}

- (void)setVzWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)vzHeight {
    return self.frame.size.height;
}

- (void)setVzHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)vzOrigin {
    return self.frame.origin;
}

- (void)setVzOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)vzSize {
    return self.frame.size;
}

- (void)setVzSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)vzBoundsHeight
{
    return self.bounds.size.height;
}

- (CGFloat)vzBoundsWidth
{
    return self.bounds.size.width;
}

@end
