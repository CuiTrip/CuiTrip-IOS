//
//  TPTripCancelledViewController.m
//  TP
//
//  Created by zhou li on 15/7/22.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPTripCancelledViewController.h"

@interface TPTripCancelledViewController()

@property(nonatomic,strong) UILabel* titleLabel;
@property(nonatomic,strong) UIImageView* addressIcon;
@property(nonatomic,strong) UILabel* addressLabel;
@property(nonatomic,strong) UIImageView* providerIcon;
@property(nonatomic,strong) UILabel* providerNameLabel;
@property(nonatomic,strong) UILabel* cancelLabel;
@property(nonatomic,strong) UIButton* tripListBtn;
@property(nonatomic,strong) UIButton* tripsBtn;

@end

@implementation TPTripCancelledViewController


////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods


- (void)loadView
{
    [super loadView];
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

- (void)dealloc {
    
    //todo..
}


/////////////////////////////////
#pragma mark - private method

- (void)initViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"取消旅程"];
    
    self.titleLabel = [TPUIKit label:[UIColor colorWithRed:74 / 255.0f green:74 / 255.0f blue:74 / 255.0f alpha:1.0f] Font:[UIFont systemFontOfSize:19.0f]];
    self.titleLabel.text = self.tripDetailModel.serviceName;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.frame = CGRectMake(0.0f, 50.0f, self.view.vzWidth, 20.0f);
    [self.view addSubview:self.titleLabel];
    
    self.addressIcon = [TPUIKit imageView];
    [self.addressIcon setImage:__image(@"trip_position.png")];
    self.addressIcon.frame = CGRectMake((self.view.vzWidth - 44.0f) / 2, self.titleLabel.vzBottom + 10.0f, 14.0f, 14.0f);
    [self.view addSubview:self.addressIcon];
    
    self.addressLabel = [TPUIKit label:[UIColor colorWithRed:124 / 255.0f green:124 / 255.0f blue:124 / 255.0f alpha:1.0f] Font:[UIFont systemFontOfSize:13.0f]];
    self.addressLabel.text = self.tripDetailModel.serviceAdress;
    self.addressLabel.textAlignment = NSTextAlignmentCenter;
    self.addressLabel.frame = CGRectMake(self.addressIcon.vzRight + 5, self.addressIcon.vzTop + 2, 30.0f, 10.0f);
    [self.view addSubview:self.addressLabel];
    
    self.providerIcon = [TPUIKit roundImageView:CGSizeMake(65.0f, 65.0f) Border:[UIColor whiteColor]];
    [self.providerIcon sd_setImageWithURL:__url(self.tripDetailModel.insiderHeadPic) placeholderImage:__image(@"girl.jpg")];
    self.providerIcon.frame = CGRectMake((self.view.vzWidth - 65.0f) / 2, self.addressIcon.vzBottom + 20.0f, 65.0f, 65.0f);
    [self.view addSubview:self.providerIcon];
    
    self.providerNameLabel = [TPUIKit label:[UIColor colorWithRed:124 / 255.0f green:124 / 255.0f blue:124 / 255.0f alpha:1.0f] Font:[UIFont systemFontOfSize:15.0f]];
    self.providerNameLabel.text = self.tripDetailModel.insiderNickName;
    self.providerNameLabel.textAlignment = NSTextAlignmentCenter;
    self.providerNameLabel.frame = CGRectMake(0.0f, self.providerIcon.vzBottom + 10.0f, self.view.vzWidth, 18.0f);
    [self.view addSubview:self.providerNameLabel];
    
    self.cancelLabel = [TPUIKit label:[UIColor colorWithRed:124 / 255.0f green:124 / 255.0f blue:124 / 255.0f alpha:1.0f] Font:[UIFont systemFontOfSize:21.0f]];
    self.cancelLabel.text = @"您的旅程已取消";
    self.cancelLabel.textAlignment = NSTextAlignmentCenter;
    self.cancelLabel.frame = CGRectMake(0.0f, self.providerNameLabel.vzBottom + 30.0f, self.view.vzWidth, 24.0f);
    [self.view addSubview:self.cancelLabel];
    
    
    self.tripListBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.tripListBtn.backgroundColor = [UIColor colorWithRed:0 / 255.0f green:204 / 255.0f blue:221 / 255.0f alpha:1.0f];
    self.tripListBtn.frame = CGRectMake(20.0f, self.cancelLabel.vzBottom + 30.0f, self.view.vzWidth - 40.0f, 44.0f);
    [self.tripListBtn addTarget:self action:@selector(toMyTripList) forControlEvents:UIControlEventTouchUpInside];
    [self.tripListBtn setTitle:@"返回旅程列表" forState:UIControlStateNormal];
    [self.tripListBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.tripListBtn];
    
    self.tripsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.tripsBtn.backgroundColor = [UIColor greenColor];
    self.tripsBtn.frame = CGRectMake(20.0f, self.tripListBtn.vzBottom + 20.0f, self.view.vzWidth - 40.0f, 44.0f);
    [self.tripsBtn addTarget:self action:@selector(toTrips) forControlEvents:UIControlEventTouchUpInside];
    [self.tripsBtn setTitle:@"返回旅程列表" forState:UIControlStateNormal];
    [self.tripsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.tripsBtn];
}

/////////////////////////////////
#pragma mark - setter

- (void)setTripDetailModel:(TPTripDetailModel *)tripDetailModel
{
    _tripDetailModel = tripDetailModel;
}

/////////////////////////////////
#pragma mark - btn action

- (void)toMyTripList
{
    [self.tabBarController setSelectedIndex:2];
    [self.navigationController popToRootViewControllerAnimated:true];
}


- (void)toTrips
{
    [self.tabBarController setSelectedIndex:0];
    [self.navigationController popToRootViewControllerAnimated:true];
}




@end
