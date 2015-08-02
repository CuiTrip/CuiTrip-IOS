  
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
@property(nonatomic,strong) UILabel* timeLabel;

@end

@implementation TPChatStatusListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = HEXCOLOR(0xeeeeee);
        
        self.label = [TPUIKit label:[TPTheme grayColor] Font:ft(13.0f)];
        self.label.textAlignment = NSTextAlignmentCenter;
//        self.label.layer.cornerRadius = 7.0f;
        self.label.layer.masksToBounds = true;
        self.label.backgroundColor = [UIColor whiteColor];
        
        self.timeLabel = [TPUIKit label:[TPTheme grayColor] Font:ft(12)];
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
//        self.timeLabel.layer.cornerRadius = 6.0f;
        self.timeLabel.layer.masksToBounds = true;
        self.timeLabel.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.label];
        [self.contentView addSubview:self.timeLabel];
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
    self.timeLabel.text = [TPUtils timeInfoWithDateString:item.gmtCreated forFormat:nil];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.label.vzOrigin = CGPointMake(kTPWidthWithMargin(175), 10);
    self.label.vzSize = CGSizeMake(175, 13);
    self.timeLabel.vzOrigin = CGPointMake(kTPWidthWithMargin(175), self.label.vzBottom);
    self.timeLabel.vzSize = CGSizeMake(175, 12);
}
@end
  
