  
//
//  TPCommentListCell.m
//  TP
//
//  Created by moxin on 2015-06-03 23:49:57 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPCommentListCell.h"
#import "TPCommentListItem.h"

@interface TPCommentListCell()

@property(nonatomic,strong) UILabel* contentLabel;
@property(nonatomic,strong) UIImageView* icon;
@property(nonatomic,strong) UILabel* nameLabel;
@property(nonatomic,strong) UILabel* locationLabel;

@end

@implementation TPCommentListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //todo: add some UI code
        self.contentLabel = [TPUIKit label:[TPTheme blackColor] Font:ft(14.0f)];
        self.contentLabel.text = @"aksdljflkajsdf";
        [self.contentView addSubview:self.contentLabel];
        
        self.icon = [TPUIKit roundImageView:CGSizeMake(30, 30) Border:[UIColor whiteColor]];
        [self.contentView addSubview:self.icon];
        
        self.nameLabel = [TPUIKit label:[TPTheme blackColor] Font:ft(12)];
        self.nameLabel.text = @"Jayson";
        [self.contentView addSubview:self.nameLabel];
        
        
        self.locationLabel = [TPUIKit label:[TPTheme grayColor] Font:ft(10)];
        self.locationLabel.text = @"New York";
        [self.contentView addSubview:self.locationLabel];
    }
    return self;
}

- (void)setItem:(TPCommentListItem *)item
{
    [super setItem:item];
    
    [self.icon sd_setImageWithURL:__url(item.avatarUrl) placeholderImage:nil];
    [self.contentLabel setText:item.content];
    [self.nameLabel setText:item.userName];
    [self.locationLabel setText:item.userLocation];
  
}

- (void)layoutSubviews
{
    [super layoutSubviews];
  
    self.contentLabel.vzOrigin = (CGPoint){12,30};
    self.contentLabel.vzWidth = self.vzWidth - 24;
    self.contentLabel.vzHeight = ((TPCommentListItem* )self.item).contentHeight;
    self.icon.vzOrigin = (CGPoint){12,self.contentLabel.vzBottom+12};
    self.nameLabel.vzOrigin = (CGPoint){self.icon.vzRight+12,self.contentLabel.vzBottom+12};
    self.locationLabel.vzOrigin = (CGPoint){self.icon.vzRight+12,self.nameLabel.vzBottom+12};
    
}
@end
  
