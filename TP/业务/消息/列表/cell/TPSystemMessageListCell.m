//
//  TPSystemMessageListCell.m
//  TP
//
//  Created by moxin on 15/6/20.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPSystemMessageListCell.h"
#import "TPMessageListItem.h"

@interface TPSystemMessageListCell()

@property(nonatomic,strong) UIView* badge;
@property(nonatomic,strong) UILabel* titleLabel;
@property(nonatomic,strong) UIImageView* icon;

@end

@implementation TPSystemMessageListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //todo: add some UI code
        self.icon = [TPUIKit roundImageView:CGSizeMake(36, 36) Border:[UIColor whiteColor]];
        self.icon.image = __image(@"default.sys.jpg");
        [self.contentView addSubview:self.icon];
        
        self.titleLabel = [TPUIKit label:[TPTheme themeColor] Font:ft(16)];
        [self.contentView addSubview:self.titleLabel];
        
        self.badge = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        self.badge.backgroundColor = [UIColor redColor];
        self.badge.layer.cornerRadius = 5.0f;
        self.badge.layer.masksToBounds = true;
        self.badge.hidden = true;
        [self.contentView addSubview:self.badge];
        
    }
    return self;
}

+ (CGFloat) tableView:(UITableView *)tableView variantRowHeightForItem:(id)item AtIndex:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)setItem:(TPMessageListItem *)item
{
    [super setItem:item];

    self.titleLabel.text = item.topic;
    self.badge.hidden = NO;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.icon.vzOrigin = CGPointMake(20, 20);
    self.icon.vzWidth = 36;
    self.icon.vzHeight = 36;
    
    self.titleLabel.vzOrigin = CGPointMake(self.icon.vzRight+10, (self.vzHeight-16)/2);
    self.titleLabel.vzWidth = self.vzWidth - self.icon.vzRight - 20;
    self.titleLabel.vzHeight = 16;
    
    self.badge.vzOrigin = CGPointMake(45, 20);
    self.badge.vzWidth = 10;
    self.badge.vzHeight = 10;
    
}

@end
