
//
//  TPTripDetailSubView.m
//  TP
//
//  Created by moxin on 2015-06-07 21:28:19 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPTripDetailSubView.h"
#import "TPTripDetailItem.h"
#import "O2OStarView.h"

@interface TPTripDetailSubView()

@property(nonatomic,strong) UITableView* tableView;
@property(nonatomic,strong) UIImageView* poster;
@property(nonatomic,strong) UIImageView* headIcon;
@property(nonatomic,strong) UILabel* nameLabel;
@property(nonatomic,strong) UIButton* contactBtn;
@property(nonatomic,strong) UILabel* titleLabel;
@property(nonatomic,strong) UIImageView* addressIcon;
@property(nonatomic,strong) UILabel* addressLabel;
@property (nonatomic,strong) O2OStarView* starView;
@property (nonatomic,strong) UITextView *textView;

@end

@implementation TPTripDetailSubView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //todo...
        self.backgroundColor = [UIColor clearColor];
        
        self.poster = [TPUIKit imageView];
        [self addSubview:self.poster];
        
        self.headIcon = [TPUIKit roundImageView:CGSizeMake(65, 65) Border:[UIColor whiteColor]];
        [self addSubview:self.headIcon];
        
        self.nameLabel = [TPUIKit label:[TPTheme grayColor] Font:ft(16.0f)];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.nameLabel];
        
        self.titleLabel = [TPUIKit label:[TPTheme blackColor] Font:ft(16.0f)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
        
        self.addressIcon = [TPUIKit imageView];
        [self.addressIcon setImage:__image(@"trip_position.png")];
        [self addSubview:self.addressIcon];
        
        self.addressLabel = [TPUIKit label:[UIColor grayColor] Font:[UIFont systemFontOfSize:13.0f]];
        [self addSubview:self.addressLabel];
    }
    
    return self;
}

- (void)setTripDetailModel:(TPTripDetailModel *)tripDetailModel
{
    _tripDetailModel = tripDetailModel;
    //service image
    [self.poster sd_setImageWithURL:__url(tripDetailModel.servicePIC) placeholderImage:__image(@"default_list.jpg")];
    //服务提供者头像
    [self.headIcon sd_setImageWithURL:__url(tripDetailModel.insiderHeadPic) placeholderImage:__image(@"girl.jpg")];
    //服务提供者nick
    self.nameLabel.text = tripDetailModel.insiderNickName;
    if ([self.tripDetailModel.status intValue] != kOrderFinished && [self.tripDetailModel.status intValue] != kOrderInvalid)
    {
        //联系服务者按钮
        self.contactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.contactBtn.layer.cornerRadius = 10.0;
        self.contactBtn.layer.borderWidth = 1.0;
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        [self.contactBtn setTitleColor: [TPTheme themeColor] forState:UIControlStateNormal];
        CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){36 / 255.0, 194 / 255.0, 213 / 255.0, 1});
        self.contactBtn.layer.borderColor = borderColorRef;
        [self addSubview:self.contactBtn];
        [self.contactBtn setTitle:@"联系他" forState:UIControlStateNormal];
    }
    //服务title
    self.titleLabel.text = tripDetailModel.serviceName;
    //服务地址
    self.addressLabel.text = tripDetailModel.serviceAdress;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.poster.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, 160.0f);
    self.headIcon.frame = CGRectMake((self.frame.size.width - 65.0f) / 2, self.poster.vzBottom - 32.5f, 65.0f, 65.0f);
    self.nameLabel.frame = CGRectMake(0.0f, self.headIcon.vzBottom + 10.0f, self.frame.size.width, 18.0f);
    float bottom = self.nameLabel.vzBottom;
    if (self.contactBtn != nil) {
        bottom += 10.0f;
        self.contactBtn.frame = CGRectMake((self.frame.size.width - 105.0f) / 2, bottom, 105.0f, 44.0f);
        bottom += 44.0f;
    }
    self.titleLabel.frame = CGRectMake(0.0f, bottom + 30.0f, self.frame.size.width, 18.0f);
    self.addressIcon.frame = CGRectMake((self.frame.size.width - 44.0f) / 2, self.titleLabel.vzBottom + 13.0f, 14.0f, 14.0f);
    self.addressLabel.frame = CGRectMake(self.addressIcon.vzRight + 5, self.addressIcon.vzTop + 2, 30.0f, 10.0f);
}

@end

