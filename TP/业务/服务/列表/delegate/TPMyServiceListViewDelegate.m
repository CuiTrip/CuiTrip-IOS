  
//
//  TPMyServiceListViewDelegate.m
//  TP
//
//  Created by moxin on 2015-06-01 19:52:11 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPMyServiceListViewDelegate.h"

@interface TPMyServiceListViewDelegate()

@end

@implementation TPMyServiceListViewDelegate

//点击更新服务日期按钮触发
- (void)editMyServiceCal
{
    NSLog(@"editMyServiceCal, yeah!");
}


////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - uitableView delegate override

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}


@end
  
