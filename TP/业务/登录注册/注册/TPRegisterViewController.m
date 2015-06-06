//
//  TPRegisterViewController.m
//  TP
//
//  Created by moxin on 15/6/5.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPRegisterViewController.h"
#import "SectionsViewController.h"


@interface TPRegisterViewController ()<SecondViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *contryLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectContryBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *vCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *vCodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *nickTextField;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIButton *privacyBtn;

@end

@implementation TPRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"注册"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)selectCountry:(id)sender {
    
    SHOW_SPINNER(self);
    [TPUtils localCodesWithCompletion:^(NSArray *list) {
        
        HIDE_SPINNER(self);
        
        SectionsViewController* s = [SectionsViewController new];
        s.delegate = self;
        [s setAreaArray:[list mutableCopy]];
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:s] animated:YES completion:nil];
        
    }];
}
- (IBAction)onGetVCode:(id)sender {
    
    
}
- (IBAction)onHidePWD:(id)sender {
}
- (IBAction)onConfirm:(id)sender {
}
- (IBAction)onPrivacy:(id)sender {
}

- (void)setSecondData:(CountryAndAreaCode *)data
{
    
}

@end
