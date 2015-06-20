  
//
//  TPTripListViewDataSource.m
//  TP
//
//  Created by moxin on 2015-06-01 19:41:29 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPTripListViewDataSource.h"
#import "TPTripListCell.h"
#import "TPTripListItem.h"

@interface TPTripListViewDataSource()

@end

@implementation TPTripListViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    //default:
    return 1; 

}

- (Class)cellClassForItem:(id)item AtIndex:(NSIndexPath *)indexPath{

    //@REQUIRED:
    
    return [TPTripListCell class];
    

}



@end  
