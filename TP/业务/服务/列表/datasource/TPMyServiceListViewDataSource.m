  
//
//  TPMyServiceListViewDataSource.m
//  TP
//
//  Created by moxin on 2015-06-01 19:52:11 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPMyServiceListViewDataSource.h"
#import "TPMyServiceListCell.h"
#import "TPMyServiceListItem.h"

@interface TPMyServiceListViewDataSource()

@end

@implementation TPMyServiceListViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    //default:
    return 1; 

}

- (Class)cellClassForItem:(id)item AtIndex:(NSIndexPath *)indexPath{

    //@REQUIRED:
    
    return [TPMyServiceListCell class];
    

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
        
        [self removeItemAtIndexPath:indexPath];
        [tableView reloadData];
    }

}


@end  
