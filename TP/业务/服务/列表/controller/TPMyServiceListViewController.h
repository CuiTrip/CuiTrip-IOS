  
//
//  TPMyServiceListViewController.h
//  TP
//
//  Created by moxin on 2015-06-01 19:52:11 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//


  
#import "VZListViewController.h"

@interface TPMyServiceListViewController : VZListViewController

- (void)deleteUnpassService:(NSString *)sid callback:(VZModelCallback)aCallback;

@end
  
