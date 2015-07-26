  
//
//  TPChatListCell.m
//  TP
//
//  Created by moxin on 2015-06-10 15:33:15 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPChatListCell.h"
#import "TPChatListItem.h"

const int kPaddingY = 15;
const int kPaddingX = 15;
@interface TPChatListCell()

@property(nonatomic,strong) UIImageView* icon;
@property(nonatomic,strong) UIImageView* arrowIcon;
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
        self.icon = [TPUIKit roundImageView:CGSizeMake(44, 44) Border:[UIColor clearColor]];
        self.arrowIcon = [TPUIKit roundImageView:CGSizeMake(6, 12) Border:[UIColor clearColor]];
        self.contentView.backgroundColor = HEXCOLOR(0xeeeeee);
        [self.contentView addSubview:self.arrowIcon];
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
  
    [self.icon sd_setImageWithURL:__url(item.headPic) placeholderImage:__image(@"girl.jpg")];
    self.chatLabel.text = item.content;
    self.timeLabel.text = [TPUtils timeInfoWithDateString:item.gmtCreated forFormat:nil];
    
    //自己发得
    if ([item.from isEqualToString:[TPUser uid]]) {
        [self.arrowIcon setImage:[UIImage imageNamed:@"trip_msg_green.png"] ];
        self.chatBK.backgroundColor = [TPTheme blueColor];
        self.chatLabel.textColor = [UIColor blackColor];
        self.timeLabel.textColor = [TPTheme grayColor];
    }
    else
    {
        [self.arrowIcon setImage:[UIImage imageNamed:@"trip_msg_white.png"]];
        self.chatBK.backgroundColor = [UIColor whiteColor];
        self.chatLabel.textColor = [UIColor blackColor];
        self.timeLabel.textColor = [TPTheme grayColor];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    TPChatListItem* item = (TPChatListItem* )self.item;
    
    //自己发得
    if ([item.from isEqualToString:[TPUser uid]]) {
        self.icon.vzOrigin = CGPointMake(self.vzWidth-self.icon.vzWidth-kPaddingX, kPaddingY);
        self.arrowIcon.vzOrigin = CGPointMake(self.icon.vzLeft-self.arrowIcon.vzWidth, kPaddingY+15);
        self.chatBK.vzOrigin = (CGPoint){self.arrowIcon.vzLeft-item.chatBKSize.width+1,kPaddingY};
        self.chatBK.vzSize = item.chatBKSize;
        self.chatLabel.vzOrigin = (CGPoint){10,10};
        self.chatLabel.vzSize = item.chatContentSize;
        self.timeLabel.vzOrigin = (CGPoint){10,self.chatLabel.vzBottom+5};
        self.timeLabel.vzSize = CGSizeMake(self.chatLabel.vzWidth, 12);
        
    }
    else
    {
        self.icon.vzOrigin = CGPointMake(kPaddingX, kPaddingY);
        self.arrowIcon.vzOrigin = CGPointMake(self.icon.vzRight, kPaddingY+15);
        self.chatBK.vzOrigin = (CGPoint){self.arrowIcon.vzRight-1,kPaddingY};
        self.chatBK.vzSize = item.chatBKSize;
        self.chatLabel.vzOrigin = (CGPoint){10,10};
        self.chatLabel.vzSize = item.chatContentSize;
        self.timeLabel.vzOrigin = (CGPoint){10,self.chatLabel.vzBottom+5};
        self.timeLabel.vzSize = CGSizeMake(self.chatLabel.vzWidth, 12);
        
    }
  
  
}
@end
  
