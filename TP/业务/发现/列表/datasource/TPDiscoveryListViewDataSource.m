  
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
    [item autoKVCBinding:@{ @"serviceBackPic":@"",
                            @"serviceNo": @"1", //列表中旅程序号
                            @"sid": @"231", //服务ID
                            @"serviceName": @"阿亮带你看妈祖绕境", //旅程名称
                            @"address": @"台湾彰化县", //旅程所在地
                            @"insiderHeadPic": @"http://alicdn.aliyun.com/pic1.jpg", //发现者头像
                            @"insiderNickName": @"阿亮" // 发现者昵称}];
                            }];
    return item;
}


@end  
