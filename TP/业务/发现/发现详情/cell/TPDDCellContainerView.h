//
//  TPDDCellContainerView.h
//  TP
//
//  Created by moxin on 15/6/3.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPDDCellContainerView : UIView

@property(nonatomic,strong) id item;
@property(nonatomic,copy) void(^callback)(NSString* type, id item);

@end
