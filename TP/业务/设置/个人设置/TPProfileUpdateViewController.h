//
//  TPProfileUpdateViewController.h
//  TP
//
//  Created by moxin on 15/6/14.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "VZViewController.h"

@interface TPProfileUpdateViewController : VZViewController

@property(nonatomic,copy) void(^callback)(void);
@property(nonatomic,assign) BOOL longText;
@property(nonatomic,strong) NSString* key;

@end
