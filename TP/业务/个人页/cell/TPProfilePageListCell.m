  
//
//  TPProfilePageListCell.m
//  TP
//
//  Created by moxin on 2015-06-04 00:05:25 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPProfilePageListCell.h"
#import "TPProfilePageListItem.h"

@interface TPProfilePageListCell()

@end

@implementation TPProfilePageListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //todo: add some UI code
    
        
    }
    return self;
}

+ (CGFloat) tableView:(UITableView *)tableView variantRowHeightForItem:(id)item AtIndex:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)setItem:(TPProfilePageListItem *)item
{
    [super setItem:item];
  
}

- (void)layoutSubviews
{
    [super layoutSubviews];
  
  
}
@end
  
