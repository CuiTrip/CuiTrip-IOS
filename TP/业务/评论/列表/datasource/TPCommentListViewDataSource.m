  
//
//  TPCommentListViewDataSource.m
//  TP
//
//  Created by moxin on 2015-06-03 23:49:57 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPCommentListViewDataSource.h"
#import "TPCommentListCell.h"
#import "TPCommentListItem.h"

@interface TPCommentListViewDataSource()

@end

@implementation TPCommentListViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    //default:
    return 1; 

}

- (Class)cellClassForItem:(id)item AtIndex:(NSIndexPath *)indexPath{

    //@REQUIRED:
    
    return [TPCommentListCell class];

}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 1;
//}
//
////@optional:
//- (TPCommentListItem* )itemForCellAtIndexPath:(NSIndexPath*)indexPath{
//
//    TPCommentListItem* item = [TPCommentListItem new];
//    [item autoKVCBinding:@{@"content":@"雷·盖恩斯（道恩·强森 Dwayne Johnson 饰）正驱车前往旧金山，随着一声巨响，周围的树木与电线杆变得七扭八歪，紧急刹车查看状况的盖恩斯被眼前的景象“惊呆了”:公路被一条深不见底的裂隙截断，甚至错位，加油站被裂成两半隔着“峡谷”遥遥相对。随着这场超级地震毫无预 兆的来袭，整个城市浓烟滚滚、火光冲天，高楼大厦相继倒塌，到处都是惊慌失措的市民。更要命的是，如此强烈的地震，“摧枯拉朽”般粉碎了坚实的大坝，洪水如猛兽一般涌向已经水深火热的城市，“天崩地陷”的景象犹如“末日”已然来临",@"userName":@"Alexson",@"userLocation":@"New York",@"avatarUrl":@""}];
//    item.itemHeight = 15+item.contentHeight+12+30+12;
//    
//    return item;
//}


@end  
