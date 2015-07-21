  
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
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone* timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    
    NSDateFormatter *df=[[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    [df setTimeZone:timeZone];
    
    NSDate* date = [formatter dateFromString:dateStr]; //------------将字符串按formatter转成nsdate
    
    NSString* datenowStr1 = [df stringFromDate:[NSDate date]];//现在时间,你可以输出来看下是什么格式
    NSString* datenowStr = [NSString stringWithFormat:@"%@ %@",datenowStr1,@" 00:00:00"];
    NSDate* datenow = [formatter dateFromString:datenowStr];
    
    NSString* formateDate = [NSString new];
    switch ([date compare:datenow]) {
        case NSOrderedSame:
            NSLog(@"same");
            formateDate = [TPUtils timeFormatString:date];
            break;
        case NSOrderedAscending:
            NSLog(@"dateday is earlier than now");
            formateDate = [dateStr componentsSeparatedByString:@" "][0];
            break;
        case NSOrderedDescending:
            NSLog(@"dateday is later than now");
            formateDate = [TPUtils timeFormatString:date];
            break;
        default:
            NSLog(@"Bad date");
            formateDate = [dateStr componentsSeparatedByString:@" "][0];
            break;
    }
    return formateDate;
}

@end
  
