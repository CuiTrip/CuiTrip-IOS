  
//
//  TPProfilePageListViewDataSource.m
//  TP
//
//  Created by moxin on 2015-06-04 00:05:25 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPProfilePageListViewDataSource.h"
#import "TPProfilePageListCell.h"

@interface TPProfilePageListViewDataSource()

@end

@implementation TPProfilePageListViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    //default:
    return 1; 

}

- (Class)cellClassForItem:(id)item AtIndex:(NSIndexPath *)indexPath{

    //@REQUIRED:
    
    return [TPProfilePageListCell class];
    

}

//@optional:
//- (TBCitySBTableViewItem*)itemForCellAtIndexPath:(NSIndexPath*)indexPath{

    //default:
    //return [super itemForCellAtIndexPath:indexPath]; 

//}


@end  
