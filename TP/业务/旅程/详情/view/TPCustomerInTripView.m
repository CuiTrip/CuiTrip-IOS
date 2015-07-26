//
//  TPCustomerInTripView.m
//  TP
//
//  Created by zhou li on 15/7/20.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPCustomerInTripView.h"

@interface TPCustomerInTripView()

@property(nonatomic,strong) UIImageView* poster;
@property(nonatomic,strong) UILabel* titleLabel;
@property(nonatomic,strong) UIImageView* addressIcon;
@property(nonatomic,strong) UILabel* addressLabel;
@property(nonatomic,strong) UIImageView* providerIcon;
@property(nonatomic,strong) UIImageView* customerIcon;
@property(nonatomic,strong) UILabel* providerNameLabel;
@property(nonatomic,strong) UILabel* customerNameLabel;
@property(nonatomic,strong) UIImageView* arrow;
@property(nonatomic,strong) UILabel* dateLabel;
@property(nonatomic,strong) UILabel* statusLabel;
@property(nonatomic,strong) UILabel* tipLabel;
@property(nonatomic,strong) CAGradientLayer* gradientLayer;
@property(nonatomic,strong) UIButton* finishBtn;


@end


@implementation TPCustomerInTripView : UIView



- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        //todo...
        self.poster = [TPUIKit imageView];
        self.poster.layer.masksToBounds = true;
        self.poster.backgroundColor = [UIColor clearColor];
        self.titleLabel = [TPUIKit label:[UIColor whiteColor] Font:[UIFont systemFontOfSize:19.0f]];
        self.addressIcon = [TPUIKit imageView];
        self.addressLabel = [TPUIKit label:[UIColor whiteColor] Font:[UIFont systemFontOfSize:13.0f]];
        self.providerIcon = [TPUIKit roundImageView:CGSizeMake(65.0f, 65.0f) Border:[UIColor whiteColor]];
        self.customerIcon = [TPUIKit roundImageView:CGSizeMake(65.0f, 65.0f) Border:[UIColor whiteColor]];
        self.providerNameLabel = [TPUIKit label:[UIColor grayColor] Font:[UIFont systemFontOfSize:15.0f]];
        self.customerNameLabel = [TPUIKit label:[UIColor grayColor] Font:[UIFont systemFontOfSize:15.0f]];
        self.arrow = [TPUIKit imageView];
        self.dateLabel = [TPUIKit label:[TPTheme themeColor] Font:[UIFont systemFontOfSize:15.0f]];
        self.statusLabel = [TPUIKit label:[TPTheme themeColor] Font:[UIFont systemFontOfSize:19.0f]];
        self.tipLabel = [TPUIKit label:[UIColor grayColor] Font:[UIFont systemFontOfSize:11.0f]];
        self.gradientLayer = [CAGradientLayer layer];
        self.gradientLayer.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithWhite:0.8 alpha:0.0].CGColor,(id)[UIColor colorWithWhite:0.0 alpha:0.8].CGColor,nil];
    }
    
    return self;
}


- (void)setModel:(TPTripDetailModel *)model
{
    _model = model;
    [self.poster sd_setImageWithURL:__url(self.model.servicePIC) placeholderImage:__image(@"default_list.jpg")];
    [self addSubview:self.poster];
    [self.poster.layer addSublayer:self.gradientLayer];
    
    self.titleLabel.text = self.model.serviceName;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
    
    [self.addressIcon setImage:__image(@"trip_position.png")];
    [self addSubview:self.addressIcon];
    
    self.addressLabel.text = self.model.serviceAdress;
    self.addressLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.addressLabel];
    
    
    NSString *providerAvatar;
    NSString *providerName;
    NSString *customerAvatar;
    NSString *customerName;
    if ([TPUser type] == kProvider) {
        providerAvatar = [TPUser avatar];
        providerName = @"我";
        customerAvatar = self.model.userAvatar;
        customerName = self.model.userName;
    }
    else if([TPUser type] == kCustomer){
        providerAvatar = self.model.userAvatar;
        providerName = self.model.userName;
        customerAvatar = [TPUser avatar];
        customerName = @"我";
    }
    
    [self.providerIcon sd_setImageWithURL:__url(providerAvatar) placeholderImage:__image(@"girl.jpg")];
    [self.customerIcon sd_setImageWithURL:__url(customerAvatar) placeholderImage:__image(@"girl.jpg")];
    [self addSubview:self.providerIcon];
    [self addSubview:self.customerIcon];
    
    self.providerNameLabel.text = providerName;
    self.providerNameLabel.textAlignment = NSTextAlignmentCenter;
    
    self.customerNameLabel.text = customerName;
    self.customerNameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.providerNameLabel];
    [self addSubview:self.customerNameLabel];
    
    self.arrow.image = __image(@"trip_connect.png");
    [self addSubview:self.arrow];
    
    self.dateLabel.text = [TPUtils changeDateFormatString:self.model.serviceDate FromOldFmt:@"yyyy-MM-dd HH:mm:ss" ToNew:@"yyyy/M/d"];
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.dateLabel];
    
    self.statusLabel.text = @"您的旅程已经开始了，享受旅程吧";
    self.statusLabel.textAlignment = NSTextAlignmentCenter;
    
    self.tipLabel.text = @"在旅程中遇到问题请点击右上角“联系脆饼”与我们取得联系";
    self.tipLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.statusLabel];
    [self addSubview:self.tipLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.poster.frame = CGRectMake(0.0f, 0.0f, self.vzWidth, 425.0f);
    self.gradientLayer.frame = CGRectMake(0.0f, 340.0f, self.vzWidth, 85.0f);
    self.titleLabel.frame = CGRectMake(0.0f, 360.0f, self.poster.vzWidth, 20.0f);
    self.providerIcon.frame = CGRectMake(25.0f, self.poster.vzBottom - 32.5f, 65.0f, 65.0f);
    self.customerIcon.frame = CGRectMake(self.poster.vzWidth - 90.0f, self.poster.vzBottom - 32.5f, 65.0f, 65.0f);
    self.addressIcon.frame = CGRectMake((self.frame.size.width - 44.0f) / 2, self.titleLabel.vzBottom + 10.0f, 14.0f, 14.0f);
    self.addressLabel.frame = CGRectMake(self.addressIcon.vzRight + 5, self.addressIcon.vzTop + 2, 30.0f, 10.0f);
    self.arrow.frame = CGRectMake(self.providerIcon.vzRight, self.poster.vzBottom + 10.0f, self.vzWidth - 180.0f, 15.0f);
    self.providerNameLabel.frame = CGRectMake(0.0f, self.providerIcon.vzBottom + 5.0f, 115.0f, 18.0f);
    self.customerNameLabel.frame = CGRectMake(self.vzWidth - 115.0f, self.customerIcon.vzBottom + 5.0f, 115.0f, 18.0f);
    self.dateLabel.frame = CGRectMake(self.providerNameLabel.vzRight, self.arrow.vzBottom + 10.0f, self.vzWidth - 230.0f, 18.0f);
    self.statusLabel.frame = CGRectMake(0.0f, self.providerNameLabel.vzBottom + 20.0f, self.poster.vzWidth, 20.0f);
    self.tipLabel.frame = CGRectMake(0.0f, self.statusLabel.vzBottom + 5.0f, self.poster.vzWidth, 10.0f);
}

@end


