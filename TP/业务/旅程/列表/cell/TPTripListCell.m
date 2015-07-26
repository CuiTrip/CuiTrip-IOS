
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

@property(nonatomic,strong) UIView* topColorView;
@property(nonatomic,strong) UIImageView* icon;
@property(nonatomic,strong) UILabel* statusLabel;
@property(nonatomic,strong) UILabel* dateLabel;
@property(nonatomic,strong) UILabel* titleLabel;
@property(nonatomic,strong) UILabel* nameLabel;
@property(nonatomic,strong) UILabel* addressLabel;
@property(nonatomic,strong) UIImageView* addressIcon;
@property(nonatomic,strong) UIView* bottomColorView;
@property(nonatomic,strong) CAGradientLayer* gradientLayer;

@end

@implementation TPTripListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        //todo: add some UI code
        self.icon = [TPUIKit roundImageView:CGSizeMake(45, 45) Border:[UIColor whiteColor]];
        [self.contentView addSubview:self.icon];
        
        self.titleLabel = [TPUIKit label:[TPTheme blackColor] Font:ft(18.0f)];
        [self.contentView addSubview:self.titleLabel];
        
        self.nameLabel = [TPUIKit label:[TPTheme grayColor] Font:ft(14.0f)];
        [self.contentView addSubview:self.nameLabel];
        
        self.topColorView = [[UIView alloc]initWithFrame:CGRectZero];
        self.topColorView.backgroundColor = [UIColor colorWithRed:216 / 255.0f green:216 / 255.0f  blue:216 / 255.0f alpha:1.0f];
        [self.contentView addSubview:self.topColorView];
        
        self.bottomColorView = [[UIView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:self.bottomColorView];
        
        self.gradientLayer = [CAGradientLayer layer];
        self.gradientLayer.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithWhite:0.8 alpha:0.0].CGColor,(id)[UIColor colorWithWhite:0.0 alpha:0.8].CGColor,nil];
        [self.bottomColorView.layer addSublayer:self.gradientLayer];
        
        self.dateLabel = [TPUIKit label:[TPTheme themeColor] Font:ft(14.0f)];
        [self.bottomColorView addSubview:self.dateLabel];
        
        self.addressIcon = [TPUIKit imageView];
        self.addressIcon.image = __image(@"trip_position.png");
        [self.bottomColorView addSubview:self.addressIcon];
        
        self.addressLabel = [TPUIKit label:[TPTheme grayColor] Font:ft(13.0f)];
        [self.bottomColorView addSubview:self.addressLabel];
        
        self.statusLabel = [TPUIKit label:[TPTheme themeColor] Font:ft(13.0f)];
        self.statusLabel.textAlignment = NSTextAlignmentRight;
        [self.bottomColorView addSubview:self.statusLabel];
    }
    return self;
}

+ (CGFloat) tableView:(UITableView *)tableView variantRowHeightForItem:(id)item AtIndex:(NSIndexPath *)indexPath
{
    return 110;
}

- (void)setItem:(TPTripListItem *)item
{
    [super setItem:item];
    
    [self.icon sd_setImageWithURL:__url(item.headPic) placeholderImage:__image(@"girl.jpg")];
    self.statusLabel.text = item.statusContent;
    self.dateLabel.text = [TPUtils changeDateFormatString:item.serviceDate FromOldFmt:@"yyyy-MM-dd HH:mm:ss" ToNew:@"yyyy/MM/dd"];
    self.titleLabel.text = item.serviceName;
    self.nameLabel.text = item.userNick;
    self.addressLabel.text = item.serviceAddress;
    [self setUIWithStatus];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.topColorView.frame = CGRectMake(0, 0, self.vzWidth, 10);
    
    self.icon.vzOrigin = CGPointMake(10, self.topColorView.vzHeight + 10);
    self.icon.vzWidth = 45;
    self.icon.vzHeight = 45;
    
    self.titleLabel.frame = CGRectMake(self.icon.vzRight + 15, self.icon.frame.origin.y + 5, 220, 10);
    self.nameLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.vzBottom + 10, 220, 15);
    
    self.bottomColorView.frame = CGRectMake(0, 82, self.vzWidth, 28);
    self.gradientLayer.frame = CGRectMake(0, self.bottomColorView.vzHeight - 1, self.vzWidth, 1);
    self.dateLabel.frame = CGRectMake(10, 10, 80, 10);
    
    self.addressIcon.frame = CGRectMake(self.dateLabel.vzRight + 10, 7, 14, 14);
    self.addressLabel.frame = CGRectMake(self.addressIcon.vzRight + 5, self.addressIcon.frame.origin.y + 2, 30, 10);
    self.statusLabel.frame = CGRectMake(self.bottomColorView.vzWidth - 120, self.addressIcon.frame.origin.y + 2, 110, 10);
}


////////////////////////////////////////////////

#pragma mark --------- private method


- (void)setUIWithStatus
{
    TPTripListItem *tripItem = (TPTripListItem *)self.item;
    int status = [tripItem.status intValue];
    if (status == kOrderReadyConfirm || status == kOrderReadyPay || status == kOrderReadyBegin || status == kOrderInTrip || status == kOrderReadyComment)
    {
        self.bottomColorView.backgroundColor = [UIColor colorWithRed:(255 / 255.0f) green:(251 / 255.0f) blue:(244 / 255.0f) alpha:1.0f];
        self.titleLabel.textColor = [TPTheme themeColor];
        self.dateLabel.textColor = [UIColor redColor];
        self.statusLabel.textColor = [TPTheme themeColor];
    }
    else if(status == kOrderFinished || status == kOrderInvalid)
    {
        self.bottomColorView.backgroundColor = [UIColor colorWithRed:(238 / 255.0f) green:(238 / 255.0f) blue:(238 / 255.0f) alpha:1.0f];
        self.titleLabel.textColor = [UIColor colorWithRed:(124 / 255.0f) green:(124 / 255.0f) blue:(124 / 255.0f) alpha:1.0f];
        self.dateLabel.textColor = [UIColor colorWithRed:(204 / 255.0f) green:(204 / 255.0f) blue:(204 / 255.0f) alpha:1.0f];
        self.statusLabel.textColor = [UIColor colorWithRed:(204 / 255.0f) green:(204 / 255.0f) blue:(204 / 255.0f) alpha:1.0f];
    }
    
}



@end

