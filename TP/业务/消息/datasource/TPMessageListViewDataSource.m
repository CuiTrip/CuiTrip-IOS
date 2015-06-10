  
//
//  TPMessageListViewDataSource.m
//  TP
//
//  Created by moxin on 2015-06-01 19:41:08 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPMessageListViewDataSource.h"
#import "TPMessageListCell.h"
#import "TPMessageListItem.h"


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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

//@optional:
- (TPMessageListItem *)itemForCellAtIndexPath:(NSIndexPath*)indexPath{

    NSDictionary* dict = @{@"avatarURL":@"",@"title":@"台湾区看妈祖表演",@"desc":@"谢谢，我也很高兴为您服务!"};
    TPMessageListItem* item = [TPMessageListItem new];
    [item autoKVCBinding:dict];
    return item;

}


@end  
