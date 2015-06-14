  
//
//  TPMyServiceListItem.h
//  TP
//
//  Created by moxin on 2015-06-01 19:52:11 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "VZListItem.h"

@interface TPMyServiceListItem : VZListItem
/*审核中（0），已审核（1），审核未通过（2）*/
@property(nonatomic,strong)NSString *check_status;
@property(nonatomic,strong)NSString *sid;
@property(nonatomic,strong)NSString *name;

@end

  
