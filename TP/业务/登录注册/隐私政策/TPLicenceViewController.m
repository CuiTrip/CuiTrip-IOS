  
//
//  TPLicenceViewController.m
//  TP
//
//  Created by moxin on 2015-06-06 17:11:27 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPLicenceViewController.h"


@interface TPLicenceViewController()

@property(nonatomic,strong) UITextView* licence;

@end

@implementation TPLicenceViewController


//////////////////////////////////////////////////////////// 
#pragma mark - setters 



//////////////////////////////////////////////////////////// 
#pragma mark - getters 



////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods

- (void)loadView
{
    [super loadView];
    //todo..
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //todo..
    [self setTitle:@"协议"];
    
    self.licence = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, self.view.vzWidth, self.view.vzHeight)];
    self.licence.editable = NO;
    [self.view addSubview:self.licence];
    
    self.licence.text = @"As a small change of pace, today's post is written by guest author Gwynne Raskind. My last post touched a bit on disassembling object files, and Gwynne wanted to dive deeply into just how to read the output in detail. Without further ado, I present her wonderful in-depth look at reading x86_64 assembly";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods

- (void)showModel:(VZModel *)model
{
    //todo:
    [super showModel:model];
}

- (void)showEmpty:(VZModel *)model
{
    //todo:
    [super showEmpty:model];
}


- (void)showLoading:(VZModel*)model
{
    //todo:
    [super showLoading:model];
}

- (void)showError:(NSError *)error withModel:(VZModel*)model
{
    //todo:
    [super showError:error withModel:model];
}

@end
 
