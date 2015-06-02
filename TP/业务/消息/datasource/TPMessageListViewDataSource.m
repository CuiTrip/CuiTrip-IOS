  
//
//  TPMessageListViewDataSource.m
//  TP
//
//  Created by moxin on 2015-06-01 19:41:08 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPMessageListViewDataSource.h"
#import "TPMessageListCell.h"

@interface TPMessageListViewDataSource()

@end

@implementation TPMessageListViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    //default:
    return 1; 

}

- (Class)cellClassForItem:(id)item AtIndex:(NSIndexPath *)indexPath{

    //@REQUIRED:
    
    return [TPMessageListCell class];
    

}

//@optional:
//- (TBCitySBTableViewItem*)itemForCellAtIndexPath:(NSIndexPath*)indexPath{

    //default:
    //return [super itemForCellAtIndexPath:indexPath]; 

//}


@end  
