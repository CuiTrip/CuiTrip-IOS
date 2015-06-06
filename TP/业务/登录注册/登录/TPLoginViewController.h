//
//  TPLoginViewController.h
//  TP
//
//  Created by moxin on 15/6/1.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPLoginViewController : VZViewController

@property(nonatomic,copy) void(^loginResult)(NSError* err);

@end
