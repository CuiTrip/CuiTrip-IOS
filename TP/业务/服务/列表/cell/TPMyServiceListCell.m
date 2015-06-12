  
//
//  TPMyServiceListCell.m
//  TP
//
//  Created by moxin on 2015-06-01 19:52:11 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPMyServiceListCell.h"
#import "TPMyServiceListItem.h"

@interface TPMyServiceListCell()

@property(nonatomic,strong) UILabel* titleLabel;
@property(nonatomic,strong) UILabel* statusLabel;

@end

@implementation TPMyServiceListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //todo: add some UI code
        self.titleLabel = [TPUIKit label:[TPTheme blackColor] Font:ft(14)];
        [self.contentView addSubview:self.titleLabel];
        
        
        self.statusLabel = [TPUIKit label:[TPTheme grayColor] Font:ft(12)];
        [self.contentView addSubview:self.statusLabel];
        
    }
    return self;
}

+ (CGFloat) tableView:(UITableView *)tableView variantRowHeightForItem:(id)item AtIndex:(NSIndexPath *)indexPath
{
    return 56;
}

- (void)setItem:(TPMyServiceListItem *)item
{
    [super setItem:item];
  
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.vzOrigin = CGPointMake(12, 21);
    self.titleLabel.vzSize = CGSizeMake(self.vzWidth-150, 14);
    self.statusLabel.vzOrigin = CGPointMake(self.vzWidth-120, 21);
    self.statusLabel.vzSize = CGSizeMake(120, 12);

}
@end
  
