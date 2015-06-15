  
//
//  TPChatListCell.m
//  TP
//
//  Created by moxin on 2015-06-10 15:33:15 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPChatListCell.h"
#import "TPChatListItem.h"

const int kPaddingY = 10;
const int kPaddingX = 10;
@interface TPChatListCell()

@property(nonatomic,strong) UIImageView* icon;
@property(nonatomic,strong) UILabel* chatLabel;
@property(nonatomic,strong) UIView* chatBK;
@property(nonatomic,strong) UILabel* timeLabel;

@end

@implementation TPChatListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //todo: add some UI code
        self.icon = [TPUIKit roundImageView:CGSizeMake(36, 36) Border:[UIColor clearColor]];
        [self.contentView addSubview:self.icon];
        
        self.chatBK = [[UIView alloc]initWithFrame:CGRectZero];
        self.chatBK.layer.cornerRadius = 5.0f;
        self.chatBK.layer.masksToBounds = true;
//        CAShapeLayer* shapLayer = [CAShapeLayer new];
//        UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.chatBK.vzWidth, self.chatBK.vzHeight) cornerRadius:5.0f];
//        shapLayer.strokeColor = [UIColor redColor].CGColor;
//        shapLayer.lineWidth = 1.0f;
//        shapLayer.path = path.CGPath;
//        shapLayer.fillColor = [UIColor yellowColor].CGColor;
//        [self.chatBK.layer addSublayer:shapLayer];
        
        [self.contentView addSubview:self.chatBK];
        
        self.chatLabel = [TPUIKit label:[UIColor whiteColor] Font:ft(14)];
        self.chatLabel.numberOfLines = 0;
        [self.chatBK addSubview:self.chatLabel];
        
        self.timeLabel = [TPUIKit label:[UIColor whiteColor] Font:ft(12)];
        [self.chatBK addSubview:self.timeLabel];
        
        
    }
    return self;
}


- (void)setItem:(TPChatListItem *)item
{
    [super setItem:item];
  
    [self.icon sd_setImageWithURL:__url(item.from) placeholderImage:__image(@"girl.jpg")];
    self.chatLabel.text = item.content;
    self.timeLabel.text = item.timestamp;
    
    //自己发得
    if ([item.from isEqualToString:[TPUser uid]]) {
        
        self.chatBK.backgroundColor = HEXCOLOR(0xeeeeee);
        self.chatLabel.textColor = [UIColor blackColor];
        self.timeLabel.textColor = [TPTheme grayColor];
        
        
    }
    else
    {
        self.chatBK.backgroundColor = HEXCOLOR(0x9b9b9b);
        self.chatLabel.textColor = [UIColor whiteColor];
        self.timeLabel.textColor = [UIColor whiteColor];
        
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    TPChatListItem* item = (TPChatListItem* )self.item;
    
    //自己发得
    if ([item.from isEqualToString:[TPUser uid]]) {
        
        self.icon.vzOrigin = CGPointMake(kPaddingX, kPaddingY);
        self.chatBK.vzOrigin = (CGPoint){self.icon.vzRight+5,kPaddingY};
        self.chatBK.vzSize = item.chatBKSize;
        self.chatLabel.vzOrigin = (CGPoint){10,10};
        self.chatLabel.vzSize = item.chatContentSize;
        self.timeLabel.vzOrigin = (CGPoint){10,self.chatLabel.vzBottom+5};
        self.timeLabel.vzSize = CGSizeMake(self.chatLabel.vzWidth, 12);
        
    }
    else
    {
        self.icon.vzOrigin = CGPointMake(self.vzWidth-self.icon.vzWidth-kPaddingX, kPaddingY);
        self.chatBK.vzOrigin = (CGPoint){self.vzWidth-item.chatBKSize.width-5-10-self.icon.vzWidth,kPaddingY};
        self.chatBK.vzSize = item.chatBKSize;
        self.chatLabel.vzOrigin = (CGPoint){10,10};
        self.chatLabel.vzSize = item.chatContentSize;
        self.timeLabel.vzOrigin = (CGPoint){10,self.chatLabel.vzBottom+5};
        self.timeLabel.vzSize = CGSizeMake(self.chatLabel.vzWidth, 12);
    
    }
  
  
}
@end
  
