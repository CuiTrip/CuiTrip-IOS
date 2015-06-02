  
//
//  TPDDTripCell.m
//  TP
//
//  Created by moxin on 2015-06-02 22:47:45 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPDDTripCell.h"


@interface TPDDTripCell()

@end

@implementation TPDDTripCell

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

- (void)layoutSubviews
{
    [super layoutSubviews];
  
  
}
@end
  
