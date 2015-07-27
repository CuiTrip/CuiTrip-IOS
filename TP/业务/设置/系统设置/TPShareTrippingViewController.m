//
//  TPShareTrippingViewController.m
//  TP
//
//  Created by 贝贝 on 15/7/27.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import <Foundation/Foundation.h>


//
//  TPTrippingContactInfoViewController.m
//  TP
//
//  Created by zhou li on 15/7/21.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPShareTrippingViewController.h"

#define TELEPHONE_NUMBER    @"8657186992999"

@interface TPShareTrippingViewController()

@property(nonatomic,strong) UIImageView* TripLogo;
@property(nonatomic,strong) UIButton* shareBtn;


@end


@implementation TPShareTrippingViewController

////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods

- (void)loadView
{
    [super loadView];
    [self setTitle:@"邀请朋友"];
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

- (void) viewDidLayoutSubviews {
    CGRect viewBounds = self.view.bounds;
    CGFloat topBarOffset = self.topLayoutGuide.length;
    viewBounds.origin.y = topBarOffset * -1;
    self.view.bounds = viewBounds;
}


-(void)dealloc {
    
    //todo..
}

//////////////////////////////////
#pragma mark - private method

- (void)initViews
{
    self.view.backgroundColor = [UIColor whiteColor];
//    self.TripLogo = [TPUIKit imageView];
//    self.TripLogo.image = __image(@"trip_logo_a.png");
    UIImage *img = __image(@"trip_logo_a.png");
    _TripLogo= [[UIImageView alloc] initWithImage:img];
    _TripLogo.frame = CGRectMake((self.view.vzWidth - 155.0f) / 2, 85.0f, 155.0f, (img.size.height * 155)/img.size.width);

    self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shareBtn.backgroundColor = [TPTheme themeColor];
    self.shareBtn.frame = CGRectMake((self.view.vzWidth - 145.0f) / 2, self.TripLogo.vzBottom + 20.0f, 145.0f, 44.0f);
    [self.shareBtn addTarget:self action:@selector(callTripping) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *btnImage = [TPUIKit imageView];
    btnImage.image = __image(@"trip_share_wx.png");
    btnImage.frame = CGRectMake(10.0f, 10.0f, 25.0f, 24.0f);
    [self.shareBtn addSubview:btnImage];
    UILabel *btnLabel = [TPUIKit label:[UIColor whiteColor] Font:[UIFont systemFontOfSize:15.0f]];
    btnLabel.text = @"分享给朋友";
    btnLabel.textAlignment = NSTextAlignmentCenter;
    btnLabel.frame = CGRectMake(btnImage.vzRight + 5.0f, 0.0f, self.shareBtn.vzWidth - btnImage.vzWidth - 5.0f, 44.0f);
    [self.shareBtn addSubview:btnLabel];
    

    [self.view addSubview:self.TripLogo];
    [self.view addSubview:self.shareBtn];

}

/////////////////////////////

#pragma mark - btn action

- (void)callTripping
{
    //分享//
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:um_appKey
                                      shareText:@"多一个朋友，多一种生活"
                                     shareImage:__image(@"icon.png")
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,nil]
                                       delegate:nil];

}



@end