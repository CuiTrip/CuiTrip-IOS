//
//  TPPublishComfirmViewController.h
//  TP
//
//  Created by moxin on 15/6/13.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPPSViewController.h"

@interface TPPSComfirmViewController : VZViewController

@property(nonatomic,strong) NSString* tripTitle;
@property(nonatomic,strong) NSString* price;
@property(nonatomic,copy)void(^complete)(void);


@end
