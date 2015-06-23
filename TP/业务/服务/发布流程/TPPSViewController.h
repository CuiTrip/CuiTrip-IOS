//
//  TPPSViewController.h
//  TP
//
//  Created by moxin on 15/6/13.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "VZViewController.h"

@interface TPPSViewController : VZViewController

@property(nonatomic,copy)void(^callback)(id arg1,...);

- (BOOL)onNext;
- (void)onBack;

@end
