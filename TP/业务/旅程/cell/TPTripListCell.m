  
//
//  TPTripListCell.m
//  TP
//
//  Created by moxin on 2015-06-01 19:41:29 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPTripListCell.h"
#import "TPTripListItem.h"

@interface TPTripListCell()

@end

@implementation TPTripListCell

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

- (void)setItem:(TPTripListItem *)item
{
    [super setItem:item];
  
}

- (void)layoutSubviews
{
    [super layoutSubviews];
  
  
}
@end
  
