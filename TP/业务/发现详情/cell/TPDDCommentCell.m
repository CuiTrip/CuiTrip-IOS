  
//
//  TPDDCommentCell.m
//  TP
//
//  Created by moxin on 2015-06-02 22:48:00 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPDDCommentCell.h"


@interface TPDDCommentCell()

@end

@implementation TPDDCommentCell

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
  
