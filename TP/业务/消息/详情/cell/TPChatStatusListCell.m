  
//
//  TPChatStatusListCell.m
//  TP
//
//  Created by moxin on 2015-06-14 21:14:17 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPChatStatusListCell.h"
#import "TPChatStatusListItem.h"

@interface TPChatStatusListCell()
@property(nonatomic,strong) UILabel* label;

@end

@implementation TPChatStatusListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = HEXCOLOR(0xeeeeee);
        self.label = [TPUIKit label:[TPTheme grayColor] Font:ft(13.0f)];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.backgroundColor = [UIColor whiteColor];
        self.label.layer.cornerRadius = 5.0f;
        [self.contentView addSubview:self.label];
    }
    return self;
}

+ (CGFloat) tableView:(UITableView *)tableView variantRowHeightForItem:(id)item AtIndex:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)setItem:(TPChatStatusListItem *)item
{
    [super setItem:item];
    self.label.text = item.content;

}

- (void)layoutSubviews
{
    [super layoutSubviews];
  
    self.label.vzOrigin = CGPointMake(kTPWidthWithMargin(175), 10);
    self.label.vzSize = CGSizeMake(175, 30);
}
@end
  
