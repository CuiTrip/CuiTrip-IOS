  
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

@property(nonatomic,strong) UILabel* nickLabel;
@property(nonatomic,strong) UILabel* timeLabel;
@property(nonatomic,strong) UILabel* titleLabel;
@property(nonatomic,strong) UILabel* tripLabel;
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
        self.icon = [TPUIKit roundImageView:CGSizeMake(44, 44) Border:[UIColor whiteColor]];
        self.icon.image = __image(@"girl.jpg");
        [self.contentView addSubview:self.icon];

        self.nickLabel = [TPUIKit label:[TPTheme themeColor] Font:ft(17)];
        [self.contentView addSubview:self.nickLabel];
        
        self.timeLabel = [TPUIKit label:HEXCOLOR(0xd8d8d8) Font:ft(11)];
        [self.contentView addSubview:self.timeLabel];
        
        self.descLabel = [TPUIKit label:[TPTheme blackColor] Font:ft(13)];
        [self.contentView addSubview:self.descLabel];
        
        self.tripLabel = [TPUIKit label:HEXCOLOR(0xffcc00) Font:ft(13)];
        [self.contentView addSubview:self.tripLabel];
        
        self.titleLabel = [TPUIKit label:[TPTheme grayColor] Font:ft(13)];
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
    
    [self.icon sd_setImageWithURL:__url(item.headPic) placeholderImage:__image(@"girl.jpg")];
    self.nickLabel.text = item.nick;
    self.timeLabel.text = [self getTimeString:item.gmtCreated];
    [self.timeLabel setTextAlignment:NSTextAlignmentRight];
    self.descLabel.text = item.lastMsg;
    self.tripLabel.text = @"旅程: ";
    self.titleLabel.text = item.topic;
    self.badge.hidden = !item.hasNewMsg;
   // self.badge.hidden = NO;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
  
    self.icon.vzOrigin = CGPointMake(15, 15);
    self.icon.vzWidth = 44;
    self.icon.vzHeight = 44;
    
    self.nickLabel.vzOrigin = CGPointMake(self.icon.vzRight+10, 15);
    self.nickLabel.vzWidth = self.vzWidth - self.icon.vzRight - 100;
    self.nickLabel.vzHeight = 17;
    
    self.timeLabel.vzOrigin = CGPointMake(self.nickLabel.vzRight+5, 15);
    self.timeLabel.vzWidth = 75;
    self.timeLabel.vzHeight = 11;
    
    self.descLabel.vzOrigin = CGPointMake(self.icon.vzRight+10, self.nickLabel.vzBottom+5);
    self.descLabel.vzWidth = self.vzWidth - self.icon.vzRight - 20;
    self.descLabel.vzHeight = 13;

    self.tripLabel.vzOrigin = CGPointMake(self.icon.vzRight+10, self.descLabel.vzBottom+10);
    self.tripLabel.vzWidth = 30;
    self.tripLabel.vzHeight = 13;
    
    self.titleLabel.vzOrigin = CGPointMake(self.tripLabel.vzRight+10, self.descLabel.vzBottom+10);
    self.titleLabel.vzWidth = self.vzWidth - self.tripLabel.vzRight - 20;
    self.titleLabel.vzHeight = 13;
    
    self.badge.vzOrigin = CGPointMake(45, 20);
    self.badge.vzWidth = 10;
    self.badge.vzHeight = 10;
  
}

- (NSString*)getTimeString:(NSString *)dateStr
{
    NSDate *date = [TPUtils dateWithString:dateStr forFormat:nil];
    NSDate *curDate = [NSDate date];
    
    NSString *strCurDate = [TPUtils stringWithDate:curDate forFormat:@"yyyy-MM-dd"];
    NSDate *dateToday = [TPUtils dateWithString:strCurDate forFormat:@"yyyy-MM-dd"];
    NSTimeInterval timeToday = [dateToday timeIntervalSince1970];   // 这个就是今天0点的那个秒点整数了
    NSTimeInterval timeNow = [curDate timeIntervalSince1970];       // 现在的秒数
    NSTimeInterval nowSec = timeNow - timeToday;    // 现在是今天的第多少秒
    
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    
    NSString* timeStr = [TPUtils stringWithDate:date forFormat:@"YYYY-MM-dd HH:mm"];
    
    if (time < nowSec) { // 小于一天，也就是今天
        return [timeStr componentsSeparatedByString:@" "][1];
    } else if (time < (nowSec + 3600 * 24)) { // 昨天
        return @"昨天";
    } else {
        return [timeStr componentsSeparatedByString:@" "][0];
    }
}

@end
  
