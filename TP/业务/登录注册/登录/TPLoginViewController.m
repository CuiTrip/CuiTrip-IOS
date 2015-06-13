//
//  TPLoginViewController.m
//  TP
//
//  Created by moxin on 15/6/1.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPLoginViewController.h"
#import "TPLoginHeader.h"
#import "TPRegisterViewController.h"
#import "SectionsViewController.h"
#import "TPForgetPWDViewController.h"

@interface TPLoginViewController()<SecondViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *contryLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectCountryBtn;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *hidePWDbtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetPWDBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property(nonatomic,strong) NSString* areaCode;


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

    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(onBackClicked:)];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)]];


    self.pwdTextField.secureTextEntry = YES;
    
    NSString* localCode = [NSString stringWithFormat:@"+%@ %@",[TPUtils defaultLocalCode],[TPUtils defaultCountry]];
    self.contryLabel.text = localCode;
    
    self.areaCode = [TPUtils defaultCountry];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self closeKeyboard];
}

- (void)onBackClicked:(id)sender
{
    [self dismissViewControllerAnimated:true completion:nil];
}


- (IBAction)onHidePwd:(id)sender {
    
    self.pwdTextField.secureTextEntry = !self.pwdTextField.secureTextEntry;
}

- (IBAction)onSelectCountry:(id)sender {

    SHOW_SPINNER(self);
    [TPUtils localCodesWithCompletion:^(NSArray *list) {
        
        HIDE_SPINNER(self);
        
        SectionsViewController* s = [SectionsViewController new];
        s.delegate = self;
        [s setAreaArray:[list mutableCopy]];
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:s] animated:YES completion:nil];
        
    }];
}


- (IBAction)onLogin:(id)sender {
    
    
    SHOW_SPINNER(self);
    [TPLoginManager loginWithMobile:self.nameTextField.text Pwd:self.pwdTextField.text ContryCode:self.areaCode Completion:^(NSError *error) {
        
        HIDE_SPINNER(self);
        
        if (!error) {
            
            [TPLoginManager hideLoginViewController];
            if (self.loginResult) {
                self.loginResult();
            }
        }
        else
        {
            TOAST_ERROR(self,error);
        }
        
    }];
}


- (IBAction)onRegister:(id)sender {
    
    TPRegisterViewController* reg = [[UIStoryboard storyboardWithName:@"TPRegisterViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"tpregister" ];
    
    [self.navigationController pushViewController:reg animated:YES];
    
}
- (IBAction)onForgetPassword:(id)sender {

    TPForgetPWDViewController* v =  [[UIStoryboard storyboardWithName:@"TPForgetPWDViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"tpforgetpwd" ];
    [self.navigationController pushViewController:v animated:YES];
}

- (void)setSecondData:(CountryAndAreaCode *)data
{
    NSLog(@"the area data：%@,%@", data.areaCode,data.countryName);
    
    self.areaCode = data.areaCode;
    self.contryLabel.text=[NSString stringWithFormat:@"+%@ %@",data.areaCode,data.countryName];
}

- (void)closeKeyboard
{
    [self.nameTextField resignFirstResponder];
    [self.pwdTextField resignFirstResponder];
}

@end
