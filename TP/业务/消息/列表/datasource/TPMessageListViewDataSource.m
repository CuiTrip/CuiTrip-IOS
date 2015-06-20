  
//
//  TPMessageListViewDataSource.m
//  TP
//
//  Created by moxin on 2015-06-01 19:41:08 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPMessageListViewDataSource.h"
#import "TPMessageListCell.h"
#import "TPSystemMessageListCell.h"
#import "TPMessageListItem.h"


@interface TPMessageListViewDataSource()

@end

@implementation TPMessageListViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    //default:
    return 1; 

}

- (Class)cellClassForItem:(TPMessageListItem* )item AtIndex:(NSIndexPath *)indexPath{

    if ([item.type isEqualToString:@"1"]) {
        return [TPSystemMessageListCell class];
    }
    else if([item.type isEqualToString:@"2"])
        return [TPMessageListCell class];
    else
        return [TPMessageListCell class];
    
}






@end  
