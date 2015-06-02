  
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

@interface TPDiscoveryDetailListViewDataSource()

@end

@implementation TPDiscoveryDetailListViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    //default:
    return 1; 

}

- (Class)cellClassForItem:(id)item AtIndex:(NSIndexPath *)indexPath{

    //@REQUIRED:
    switch (indexPath.row) {
        case 0:
        {
            return [TPDDInfoCell class];
            break;
        }
        case 1:
        {
            return [TPDDProfileCell class];
            break;
        }
        case 2:
        {
            return [TPDDCommentCell class];
            break;
        }
        case 3:
        {
            return [TPDDTripCell class];
            break;
        }
            
        default:
        {
            return [super cellClassForItem:item AtIndex:indexPath];
            break;
        }
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

//@optional:
//- (TBCitySBTableViewItem*)itemForCellAtIndexPath:(NSIndexPath*)indexPath{
//
//    default:
//    return [super itemForCellAtIndexPath:indexPath]; 
//
//}


@end  
