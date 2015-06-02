  
//
//  TPDiscoveryListCell.m
//  TP
//
//  Created by moxin on 2015-06-01 19:38:20 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPDiscoveryListCell.h"
#import "TPDiscoveryListItem.h"

@interface TPDiscoveryListCell()

@property(nonatomic,strong) UIView* containerView;
@property(nonatomic,strong) UIImageView* poster;
@property(nonatomic,strong) UIImageView* icon;
@property(nonatomic,strong) UILabel* posterNameLabel;
@property(nonatomic,strong) UILabel* userNameLabel;

@end

@implementation TPDiscoveryListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [TPTheme bgColor];
        //todo: add some UI code
        self.containerView = [[UIView alloc]initWithFrame:CGRectZero];
        self.containerView.layer.cornerRadius = 5.0f;
        self.containerView.layer.masksToBounds = true;
        self.containerView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.containerView];
        
        self.poster = [TPUIKit imageView];
        self.icon   = [TPUIKit roundImageView:CGSizeMake(45,45 ) Border:[UIColor whiteColor]];
        self.posterNameLabel = [TPUIKit label:[UIColor whiteColor] Font:[UIFont systemFontOfSize:18.0f]];
        self.userNameLabel   = [TPUIKit label:[TPTheme subTitleColor] Font:[UIFont systemFontOfSize:10.0f]];
//
//        
        [self.containerView addSubview:self.poster];
        [self.containerView addSubview:self.icon];
        [self.containerView addSubview:self.posterNameLabel];
        [self.containerView addSubview:self.userNameLabel];
    
    }
    return self;
}

+ (CGFloat) tableView:(UITableView *)tableView variantRowHeightForItem:(id)item AtIndex:(NSIndexPath *)indexPath
{
    return 215;
}

- (void)setItem:(TPDiscoveryListItem *)item
{
    [super setItem:item];
    
    [self.poster sd_setImageWithURL:__url(item.cardImageUrl) placeholderImage:__image(@"taiwan.png")];
    [self.icon sd_setImageWithURL:__url(item.avatarUrl) placeholderImage:__image(@"girl.jpg")];
    self.userNameLabel.attributedText = item.attributedUserString;
    self.posterNameLabel.text = item.cardName;
  
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.containerView.frame    = CGRectMake(10, 10, self.vzWidth-20, 205);
    self.poster.frame           = CGRectMake(0, 0, self.contentView.vzWidth, 175);
    self.icon.frame             = CGRectMake(10, self.poster.vzHeight-23, 45, 45);
    self.posterNameLabel.frame  = CGRectMake(self.icon.vzRight+10, self.icon.vzOrigin.y, self.poster.vzWidth-self.icon.vzRight-20, 20);
    self.userNameLabel.frame    = CGRectMake(self.icon.vzRight+10, self.posterNameLabel.vzBottom+13, self.posterNameLabel.vzWidth, 10);
  
  
}
@end
  
