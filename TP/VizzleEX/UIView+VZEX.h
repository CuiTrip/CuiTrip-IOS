//
//  UIView+VZEX.h
//  TP
//
//  Created by moxin on 15/6/1.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (VZEX)

@property(nonatomic /* override */) CGFloat vzLeft;

@property(nonatomic /* override */) CGFloat vzTop;

@property (nonatomic /* override */) CGFloat vzRight;

@property (nonatomic /* override */) CGFloat vzBottom;

@property (nonatomic /* override */) CGFloat vzWidth;

@property (nonatomic /* override */) CGFloat vzHeight;

@property (nonatomic /* override */) CGFloat vzCenterX;

@property (nonatomic /* override */) CGFloat vzCenterY;

@property (nonatomic /* override */) CGPoint vzOrigin;

@property (nonatomic /* override */) CGSize vzSize;

@property (nonatomic, readonly) CGFloat vzBoundsWidth;
@property (nonatomic, readonly) CGFloat vzBoundsHeight;


@end
