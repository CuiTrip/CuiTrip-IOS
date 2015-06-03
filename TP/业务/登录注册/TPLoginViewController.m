//
//  TPLoginViewController.m
//  TP
//
//  Created by moxin on 15/6/1.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPLoginViewController.h"
#import "TPLoginHeader.h"

@interface TPLoginViewController()
@property (strong, nonatomic)  UITextField *nameTextField;
@property (strong, nonatomic)  UITextField *pwdTextField;
@property (strong, nonatomic)  UIButton *loginBtn;
@property (strong, nonatomic)  UIButton *forgetPWDBtn;
@end

@implementation TPLoginViewController

- (void)dealloc
{
    __removeNotifyObserver;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"登录"];


    self.navigationController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(onBackClicked:)];


    __observeNotify(@selector(loginSuccess:), kTPLoginSuccess);
    __observeNotify(@selector(loginFailed:), kTPLoginFailure);
}


- (void)onBackClicked:(id)sender
{
    
}


- (void)loginSuccess:(NSNotification* )notifiy
{

}

- (void)loginFailed:(NSNotification* )notify
{

}

@end
