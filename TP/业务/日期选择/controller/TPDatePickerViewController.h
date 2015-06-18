  
//
//  TPDatePickerViewController.h
//  TP
//
//  Created by moxin on 2015-06-03 23:56:44 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//


  
#import "VZViewController.h"


typedef enum
{
    kCheckOnly = 1,
    kSelection = 2

}DatePickerType;

@interface TPDatePickerViewController : VZViewController

@property(nonatomic,copy) void(^callback)(NSArray* selectedDates);
@property(nonatomic,assign) DatePickerType type;
@property(nonatomic,strong) NSDate* date;
@property(nonatomic,strong) NSString* sid;


@end
  
