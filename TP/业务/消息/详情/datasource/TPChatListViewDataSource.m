  
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


//@optional:
- (VZListItem* )itemForCellAtIndexPath:(NSIndexPath*)indexPath{

    if (indexPath.row == 0) {
        
        TPChatStatusListItem* item = [TPChatStatusListItem new];
        item.status = @"贱婢已经提交了预约申请";
        return item;
        
    }
    else if (indexPath.row == 1)
    {
        /**
         @property(nonatomic,strong)NSString* from;
         @property(nonatomic,strong)NSString* to;
         @property(nonatomic,strong)NSString* type;
         @property(nonatomic,strong)NSString* content;
         @property(nonatomic,strong)NSString* fromHeadPic;
         @property(strong,nonatomic)NSString* toHeadPic;
         @property(nonatomic,strong)NSString* timestamp;
         */
        TPChatListItem* item = [TPChatListItem new];
        NSDictionary* json = @{@"from":@"15",@"to":@"20",@"type":@"a",@"fromHeadPic":@"",@"toHeadPic":@"",@"timestamp":@"2015-03-06 18:00",@"content":@"对于未越狱的iOS设备来说，由于强大的沙箱和授权机制，以及Apple自己掌控的App Store， 基本上杜绝了恶意软件的入侵。但除系统安全之外，我们还是面临很多的安"};
        [item autoKVCBinding:json];
        item.itemHeight = item.chatBKSize.height+10;
        return item;
    }
    else if(indexPath.row == 2)
    {
        TPChatListItem* item = [TPChatListItem new];
        NSDictionary* json = @{@"from":@"16",@"to":@"15",@"type":@"a",@"fromHeadPic":@"",@"toHeadPic":@"",@"timestamp":@"2015-03-06 18:30",@"content":@"本人并非专业的安全专家，只是从开发者的角度"};
        [item autoKVCBinding:json];
        item.itemHeight = item.chatBKSize.height+10;
        return item;
    }
    else
        return nil;
}


@end  
