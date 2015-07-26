//
//  TPTrippingContactInfoViewController.m
//  TP
//
//  Created by zhou li on 15/7/21.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPTrippingContactInfoViewController.h"


#define TELEPHONE_NUMBER    @"8657186992999"

@interface TPTrippingContactInfoViewController()

@property(nonatomic,strong) UIImageView* QRCode;
@property(nonatomic,strong) UILabel* tipLabel;
@property(nonatomic,strong) UIButton* callBtn;
@property(nonatomic,strong) UIImageView* emailIcon;
@property(nonatomic,strong) UILabel* emailLabel;

@end


@implementation TPTrippingContactInfoViewController

////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods

- (void)loadView
{
    [super loadView];
    [self setTitle:@"联系脆饼"];
    [self initViews];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = true;
    //todo..
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //todo..
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //todo..
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    //todo..
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

-(void)dealloc {
    
    //todo..
}

//////////////////////////////////
#pragma mark - private method

- (void)initViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.QRCode = [TPUIKit imageView];
    self.QRCode.image = __image(@"trip_weixin2wm.png");
    self.QRCode.frame = CGRectMake((self.view.vzWidth - 155.0f) / 2, 50.0f, 155.0f, 155.0f);
    self.tipLabel = [TPUIKit label:[UIColor colorWithRed:155 / 255.0f green:155 / 255.0f blue:155 / 255.0f alpha:1.0f] Font:[UIFont systemFontOfSize:15.0]];
    self.tipLabel.text = @"请扫描二维码或加微信号：cuibinglvxing";
    self.tipLabel.textAlignment = NSTextAlignmentCenter;
    
    self.tipLabel.frame = CGRectMake(0.0f, self.QRCode.vzBottom + 25.0f, self.view.vzWidth, 16.0f);
    self.callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.callBtn.backgroundColor = [UIColor colorWithRed:0 / 255.0f green:204 / 255.0f blue:221 / 255.0f alpha:1.0f];
    self.callBtn.frame = CGRectMake((self.view.vzWidth - 195.0f) / 2, self.tipLabel.vzBottom + 45.0f, 195.0f, 44.0f);
    [self.callBtn addTarget:self action:@selector(callTripping) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *btnImage = [TPUIKit imageView];
    btnImage.image = __image(@"trip_tel.png");
    btnImage.frame = CGRectMake(10.0f, 10.0f, 25.0f, 24.0f);
    [self.callBtn addSubview:btnImage];
    UILabel *btnLabel = [TPUIKit label:[UIColor whiteColor] Font:[UIFont systemFontOfSize:15.0f]];
    btnLabel.text = @"紧急情况请致电我们";
    btnLabel.textAlignment = NSTextAlignmentLeft;
    btnLabel.frame = CGRectMake(btnImage.vzRight + 5.0f, 0.0f, self.callBtn.vzWidth - btnImage.vzWidth - 5.0f, 44.0f);
    [self.callBtn addSubview:btnLabel];
    
    self.emailIcon = [TPUIKit imageView];
    self.emailIcon.image = __image(@"trip_mail_blue.png");
    self.emailIcon.frame = CGRectMake((self.view.vzWidth - 36.0f) / 2, self.callBtn.vzBottom + 50.0f, 36.0f, 24.0f);
    
    self.emailLabel = [TPUIKit label:[UIColor colorWithRed:0 / 255.0f green:204 / 255.0f blue:221 / 255.0f alpha:1.0f] Font:[UIFont systemFontOfSize:15.0f]];
    self.emailLabel.text = @"service@cuitrip.com";
    self.emailLabel.textAlignment = NSTextAlignmentCenter;
    self.emailLabel.frame = CGRectMake(0.0f, self.emailIcon.vzBottom + 10.0f, self.view.vzWidth, 16.0f);
    
    [self.view addSubview:self.QRCode];
    [self.view addSubview:self.tipLabel];
    [self.view addSubview:self.callBtn];
    [self.view addSubview:self.emailIcon];
    [self.view addSubview:self.emailLabel];
}

/////////////////////////////

#pragma mark - btn action

- (void)callTripping
{
    NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@", TELEPHONE_NUMBER];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}



@end