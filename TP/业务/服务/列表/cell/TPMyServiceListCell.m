  
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
        self.statusLabel.textAlignment = NSTextAlignmentRight;
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
    self.titleLabel.text = item.name;
    
    NSString* status = item.check_status;
    if ([status integerValue] == 0) {
        self.statusLabel.text = @"正在审核中...";
        self.statusLabel.textColor = [TPTheme grayColor];
    }
    else if([status integerValue]==1)
    {
        self.statusLabel.text = @"已审核";
        self.statusLabel.textColor = [TPTheme themeColor];
    }
    else if ([status integerValue]==2)
    {
        self.statusLabel.text = @"审核未通过";
        self.statusLabel.textColor = [UIColor redColor];
    }
  
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.vzOrigin = CGPointMake(12, 21);
    self.titleLabel.vzSize = CGSizeMake(self.vzWidth-150, 14);
    self.statusLabel.vzOrigin = CGPointMake(self.vzWidth-140, 21);
    self.statusLabel.vzSize = CGSizeMake(120, 12);

}
@end
  
