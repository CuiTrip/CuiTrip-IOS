  
//
//  TPMyServiceListViewDataSource.m
//  TP
//
//  Created by moxin on 2015-06-01 19:52:11 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPMyServiceListViewDataSource.h"
#import "TPMyServiceListItem.h"
#import "TPMyServiceCell.h"
#import "TPMyServiceListViewController.h"


@interface TPMyServiceListViewDataSource()

@end

@implementation TPMyServiceListViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    //default:
    return 1; 

}

- (Class)cellClassForItem:(id)item AtIndex:(NSIndexPath *)indexPath{

    //@REQUIRED:
    
    return [TPMyServiceCell class];
    

}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    TPMyServiceListItem* item = (TPMyServiceListItem* )[self itemForCellAtIndexPath:indexPath];
    
    //没通过的可以删除
    if ([item.checkStatus integerValue] == 2) {
        
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        TPMyServiceListViewController *serviceVC = (TPMyServiceListViewController *)self.controller;
        TPMyServiceListItem* item = (TPMyServiceListItem* )[self itemForCellAtIndexPath:indexPath];

        SHOW_SPINNER(serviceVC);
        __weak typeof(TPMyServiceListViewController *) weakSelf = serviceVC;
        [serviceVC deleteUnpassService:item.sid callback:^(VZModel *model, NSError *error) {
            HIDE_SPINNER(weakSelf);
            if (!error) {
                TOAST(weakSelf, @"删除成功");
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self removeItemAtIndexPath:indexPath];
                    [tableView reloadData];
                });
            }
            else
            {
                TOAST_ERROR(weakSelf, error);
            }
        }];
    }

}


@end  
