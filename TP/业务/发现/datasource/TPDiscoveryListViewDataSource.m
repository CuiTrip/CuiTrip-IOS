  
//
//  TPDiscoveryListViewDataSource.m
//  TP
//
//  Created by moxin on 2015-06-01 19:38:20 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPDiscoveryListViewDataSource.h"
#import "TPDiscoveryListCell.h"
#import "TPDiscoveryListItem.h"

@interface TPDiscoveryListViewDataSource()

@end

@implementation TPDiscoveryListViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    //default:
    return 1; 

}

- (Class)cellClassForItem:(id)item AtIndex:(NSIndexPath *)indexPath{

    //@REQUIRED:
    
    return [TPDiscoveryListCell class];
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

//@optional:
- (TPDiscoveryListItem* )itemForCellAtIndexPath:(NSIndexPath*)indexPath{
    
    TPDiscoveryListItem* item =  [TPDiscoveryListItem new];
    [item autoKVCBinding:@{@"cardName":@"探索台湾文学之旅",@"userName":@"小佩",@"userCity":@"台北",@"cardImageUrl":@"",@"avatarUrl":@""}];
    return item;

}


@end  
