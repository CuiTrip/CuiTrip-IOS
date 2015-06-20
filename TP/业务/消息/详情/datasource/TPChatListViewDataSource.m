  
//
//  TPChatListViewDataSource.m
//  TP
//
//  Created by moxin on 2015-06-10 15:33:15 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPChatListViewDataSource.h"
#import "TPChatListCell.h"
#import "TPChatListItem.h"
#import "TPChatStatusListCell.h"
#import "TPChatStatusListItem.h"


@interface TPChatListViewDataSource()

@end

@implementation TPChatListViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    //default:
    return 1; 

}

- (Class)cellClassForItem:(id)item AtIndex:(NSIndexPath *)indexPath{

    //@REQUIRED:
    if ([item isKindOfClass:[TPChatListItem class]]) {
            return [TPChatListCell class];
    }
    else if ([item isKindOfClass:[TPChatStatusListItem class]])
    {
        return [TPChatStatusListCell class];
    }
    else
        return [super cellClassForItem:item AtIndex:indexPath];

}



@end  
