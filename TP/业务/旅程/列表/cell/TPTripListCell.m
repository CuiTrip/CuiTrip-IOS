  
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

@property(nonatomic,strong) UIImageView* icon;
@property(nonatomic,strong) UILabel* statusLabel;
@property(nonatomic,strong) UILabel* dateLabel;
@property(nonatomic,strong) UILabel* titleLabel;
@property(nonatomic,strong) UILabel* nameLabel;
@property(nonatomic,strong) UILabel* moneyLabel;

@end

@implementation TPTripListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //todo: add some UI code
        self.icon = [TPUIKit imageView];
        [self.contentView addSubview:self.icon];
        
        self.statusLabel = [TPUIKit label:[UIColor whiteColor] Font:ft(14)];
        self.statusLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        self.statusLabel.textAlignment = NSTextAlignmentCenter;
        [self.icon addSubview:self.statusLabel];
        
        self.dateLabel = [TPUIKit label:[TPTheme themeColor] Font:ft(14.0f)];
        [self.contentView addSubview:self.dateLabel];
        
        self.titleLabel = [TPUIKit label:[TPTheme blackColor] Font:ft(16.0f)];
        [self.contentView addSubview:self.titleLabel];
        
        self.nameLabel = [TPUIKit label:[TPTheme grayColor] Font:ft(12.0f)];
        [self.contentView addSubview:self.nameLabel];
        
        self.moneyLabel = [TPUIKit label:[TPTheme grayColor] Font:ft(14.0f)];
        [self.contentView addSubview:self.moneyLabel];
        
    }
    return self;
}

+ (CGFloat) tableView:(UITableView *)tableView variantRowHeightForItem:(id)item AtIndex:(NSIndexPath *)indexPath
{
    return 130;
}

- (void)setItem:(TPTripListItem *)item
{
    [super setItem:item];
    
    [self.icon sd_setImageWithURL:__url(item.imageURL) placeholderImage:__image(@"mazu.png")];
    self.statusLabel.text = item.status;
    self.dateLabel.text = item.dateString;
    self.titleLabel.text = item.title;
    self.nameLabel.text = [NSString stringWithFormat:@"%@ @%@",item.name,item.location];
    self.moneyLabel.text = [NSString stringWithFormat:@"RMB: %@",item.money];
  
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.icon.vzOrigin = CGPointMake(10, 10);
    self.icon.vzWidth = 110;
    self.icon.vzHeight = 110;
    self.statusLabel.vzOrigin = CGPointMake(0, 110-28);
    self.statusLabel.vzWidth = 110;
    self.statusLabel.vzHeight = 28;
    
    self.dateLabel.vzOrigin = CGPointMake(self.icon.vzRight+20, 20);
    self.dateLabel.vzWidth = self.vzWidth-self.icon.vzWidth-20;
    self.dateLabel.vzHeight = 14.0f;
    
    self.titleLabel.vzOrigin = CGPointMake(self.icon.vzRight+20, self.dateLabel.vzBottom+10);
    self.titleLabel.vzWidth = self.dateLabel.vzWidth;
    self.titleLabel.vzHeight=  16.0f;
    
    self.nameLabel.vzOrigin = CGPointMake(self.icon.vzRight+20, self.titleLabel.vzBottom+10);
    self.nameLabel.vzWidth = self.dateLabel.vzWidth;
    self.nameLabel.vzHeight=  12.0f;
    
    self.moneyLabel.vzOrigin = CGPointMake(self.icon.vzRight+20, self.nameLabel.vzBottom+10);
    self.moneyLabel.vzWidth = self.dateLabel.vzWidth;
    self.moneyLabel.vzHeight=  14.0f;
    
  
  
}
@end
  
