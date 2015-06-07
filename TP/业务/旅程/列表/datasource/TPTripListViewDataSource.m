  
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

//@optional:

/**
 @property(nonatomic,strong) NSString* imageURL;
 @property(nonatomic,strong) NSString* status;
 @property(nonatomic,strong) NSString* dateString;
 @property(nonatomic,strong) NSString* title;
 @property(nonatomic,strong) NSString* name;
 @property(nonatomic,strong) NSString* location;
 @property(nonatomic,strong) NSString* money;

 */
- (TPTripListItem*)itemForCellAtIndexPath:(NSIndexPath*)indexPath{

    TPTripListItem* item = [TPTripListItem new];
    
    [item autoKVCBinding:@{@"imageURL":@"",@"status":@"已经结束",@"dateString":@"2015年6月5日",@"title":@"在台北看妈祖表演",@"name":@"真刚",@"location":@"台北",@"money":@"120"}];
    
    return item;

}


@end  
