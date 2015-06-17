  
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}



//@optional:
- (TPMyServiceListItem*)itemForCellAtIndexPath:(NSIndexPath*)indexPath{

    if(indexPath.row == 0)
    {
        TPMyServiceListItem* item = [TPMyServiceListItem new];
        [item autoKVCBinding:@{
                               @"sid": @"3",
                               @"name": @"阿亮带你看妈祖绕境",
                               @"check_status": @"0"
                               }];
        return item;
    
    }
    else if (indexPath.row == 1)
    {
        TPMyServiceListItem* item = [TPMyServiceListItem new];
        [item autoKVCBinding:@{
                               @"sid": @"3",
                               @"name": @"阿亮带你看妈祖绕境",
                               @"check_status": @"1"
                               }];
        return item;
    }
    else if (indexPath.row == 2)
    {
        TPMyServiceListItem* item = [TPMyServiceListItem new];
        [item autoKVCBinding:@{
                               @"sid": @"3",
                               @"name": @"阿亮带你看妈祖绕境",
                               @"check_status": @"2"
                               }];
        return item;
    
    }
    else if (indexPath.row == 2)
    {
        TPMyServiceListItem* item = [TPMyServiceListItem new];
        [item autoKVCBinding:@{
                               @"sid": @"3",
                               @"name": @"阿亮带你看妈祖绕境",
                               @"check_status": @"2"
                               }];
        return item;
        
    }
    else if (indexPath.row == 3)
    {
        TPMyServiceListItem* item = [TPMyServiceListItem new];
        [item autoKVCBinding:@{
                               @"sid": @"3",
                               @"name": @"阿亮带你看妈祖绕境",
                               @"check_status": @"2"
                               }];
        return item;
        
    }
    return nil;


    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    TPMyServiceListItem* item = (TPMyServiceListItem* )[self itemForCellAtIndexPath:indexPath];
    
    //没通过的可以删除
    if ([item.check_status integerValue] == 2) {
        
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
