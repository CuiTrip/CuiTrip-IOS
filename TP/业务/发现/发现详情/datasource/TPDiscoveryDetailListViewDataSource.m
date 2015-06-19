  
//
//  TPDiscoveryDetailListViewDataSource.m
//  TP
//
//  Created by moxin on 2015-06-02 22:32:08 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPDiscoveryDetailListViewDataSource.h"
#import "TPDDInfoCell.h"
#import "TPDDProfileCell.h"
#import "TPDDCommentCell.h"
#import "TPDDTripCell.h"
#import "TPDDInfoItem.h"
#import "TPDDProfileItem.h"
#import "TPDDTripItem.h"
#import "TPDDCommentItem.h"



@interface TPDiscoveryDetailListViewDataSource()

@end

@implementation TPDiscoveryDetailListViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1; 

}

- (Class)cellClassForItem:(id)item AtIndex:(NSIndexPath *)indexPath{

    if ([item isKindOfClass:[TPDDInfoItem class]]) {
        return [TPDDInfoCell class];
    }
    else if ([item isKindOfClass:[TPDDProfileItem class]])
    {
        return [TPDDProfileCell class];
    }
    else if ([item isKindOfClass:[TPDDCommentItem class]])
    {
        return [TPDDCommentCell class];
    }
    else if ([item isKindOfClass:[TPDDTripItem class]])
    {
        return [TPDDTripCell class];
    }
    else
        return [super cellClassForItem:item AtIndex:indexPath];
}

@end  
