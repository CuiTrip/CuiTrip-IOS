//
//  VZInspectorView.h
//  VZInspector
//
//  Created by moxin.xt on 14-11-26.
//  Copyright (c) 2014年 VizLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VZInspectorView : UIView

@property(nonatomic,weak) UIViewController* parentViewController;

- (id)initWithFrame:(CGRect)frame parentViewController:(UIViewController* )controller;

@end
