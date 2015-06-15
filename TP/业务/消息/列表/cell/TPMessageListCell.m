  
//
//  TPMessageListCell.m
//  TP
//
//  Created by moxin on 2015-06-01 19:41:08 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPMessageListCell.h"
#import "TPMessageListItem.h"

@interface TPMessageListCell()

@property(nonatomic,strong) UILabel* titleLabel;
@property(nonatomic,strong) UILabel* descLabel;
@property(nonatomic,strong) UIImageView* icon;
@property(nonatomic,strong) UIView* badge;

@end

@implementation TPMessageListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {

        //todo: add some UI code
        self.icon = [TPUIKit roundImageView:CGSizeMake(36, 36) Border:[UIColor whiteColor]];
        [self.contentView addSubview:self.icon];
        
        self.titleLabel = [TPUIKit label:[TPTheme themeColor] Font:ft(16)];
        [self.contentView addSubview:self.titleLabel];
        
        self.descLabel = [TPUIKit label:[TPTheme grayColor] Font:ft(12)];
        [self.contentView addSubview:self.descLabel];
        
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
    
    [self.icon sd_setImageWithURL:__url(item.avatarURL) placeholderImage:__image(@"girl.jpg")];
    self.titleLabel.text = item.title;
    self.descLabel.text = item.desc;
   // self.badge.hidden = !item.hasNewMsg;
    self.badge.hidden = NO;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
  
    self.icon.vzOrigin = CGPointMake(20, 20);
    self.icon.vzWidth = 36;
    self.icon.vzHeight = 36;
    
    self.titleLabel.vzOrigin = CGPointMake(self.icon.vzRight+10, 20);
    self.titleLabel.vzWidth = self.vzWidth - self.icon.vzRight - 20;
    self.titleLabel.vzHeight = 16;

    self.descLabel.vzOrigin = CGPointMake(self.icon.vzRight + 10, self.titleLabel.vzBottom+10);
    self.descLabel.vzWidth = self.titleLabel.vzWidth;
    self.descLabel.vzHeight = 12;
    
    self.badge.vzOrigin = CGPointMake(45, 20);
    self.badge.vzWidth = 10;
    self.badge.vzHeight = 10;
  
}
@end
  
