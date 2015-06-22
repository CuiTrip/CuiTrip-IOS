//
//  TPProfileUpdateViewController.m
//  TP
//
//  Created by moxin on 15/6/14.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPProfileUpdateViewController.h"
#import <UIKit/UIKit.h>
@interface TPProfileUpdateViewController ()

@property(nonatomic,strong) UITextField* textField;
@property(nonatomic,strong) UITextView* textView;
@property(nonatomic,strong) UILabel* hintLabel;

@end

@implementation TPProfileUpdateViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [TPTheme yellowColor];
    self.hintLabel = [TPUIKit label:[TPTheme themeColor] Font:ft(12.0f)];
    [self.view addSubview:self.hintLabel];
    
    if (!self.longText) {
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 20, CGRectGetWidth(self.view.bounds)-20, 30)];
        self.textField.textColor = [TPTheme blackColor];
        self.textField.font = ft(16);
        self.textField.backgroundColor = [UIColor whiteColor];
        self.textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 30)];
        self.textField.leftViewMode = UITextFieldViewModeAlways;
        //self.textField.borderStyle = UITextBorderStyleRoundedRect;
        self.textField.layer.borderWidth = 0.5;
        self.textField.layer.borderColor = [TPTheme grayColor].CGColor;
        self.textField.layer.cornerRadius = 8.0f;
        self.textField.layer.masksToBounds = true;

        
        [self.textField becomeFirstResponder];
        [self.view addSubview:self.textField];
        
        if (self.hintText.length > 0) {
            
            self.hintLabel.vzOrigin = CGPointMake(self.textField.vzLeft, self.textField.vzBottom+20);
            self.hintLabel.vzSize = CGSizeMake(self.textField.vzWidth, 13);
            self.hintLabel.text = self.hintText;
        }

    }
    else
    {
        self.textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 20, CGRectGetWidth(self.view.bounds)-20, 60)];
        self.textView.textColor = [TPTheme blackColor];
        self.textView.font = ft(16);
        self.textView.backgroundColor = [UIColor whiteColor];
        self.textView.layer.borderWidth = 0.5;
        self.textView.layer.borderColor = [TPTheme grayColor].CGColor;
        self.textView.layer.cornerRadius = 8.0f;
        self.textView.layer.masksToBounds = true;
        [self.textView becomeFirstResponder];
        [self.view addSubview:self.textView];
        
        if (self.hintText.length > 0) {
            
            self.textView.vzOrigin = CGPointMake(self.textField.vzLeft, self.textField.vzBottom+20);
            self.textView.vzSize = CGSizeMake(self.textField.vzWidth, 13);
            self.textView.text = self.hintText;
        }
    
    }
 
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:0 target:self action:@selector(onback)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:0 target:self action:@selector(onConfirm)];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.textView resignFirstResponder];
    [self.textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onback
{


    
    [self dismissViewControllerAnimated:true completion:nil];
}

/**
 	uid(String): 用户id
 	token(String):  登录凭证
 	realName(String)：真实姓名
 	nick(String)：昵称
 	gender(String)：性别
 	city(String)：城市
 	language(String)：语言
 	career(String)：职业
 	interests(String)：兴趣
 	sign(String)：用户签名
 */
- (void)onConfirm
{
    [self.view endEditing:true];
    NSAssert(self.key!=nil, @"key is nil");
    
    if (self.longText) {
        if (self.textView.text.length == 0) {
            TOAST(self, @"输入不能为空!");
            return;
        }
    }
    else
    {
        if (self.textField.text.length == 0) {
            TOAST(self, @"输入不能为空!");
            return;
        }
        
    }
    
//    NSDictionary* dict = @{
//                           @"uid":[TPUser uid]?:@"",
//                           @"token":[TPUser token]?:@"",
//                           @"realName":[TPUser userName]?:@"",
//                           @"nick":[TPUser userNick]?:@"",
//                           @"gener":[TPUser gender]?:@"",
//                           @"city":[TPUser country]?:@"",
//                           @"language":[TPUser language]?:@"",
//                           @"career":[TPUser career]?:@"",
//                           @"interests":[TPUser hobby]?:@"",
//                           @"sign":[TPUser sign]?:@""
//                            };
    NSDictionary* dict = @{
                           @"uid":[TPUser uid]?:@"",
                           @"token":[TPUser token]?:@"",
                           };
    
    NSMutableDictionary* dictMutable = [dict mutableCopy];
    NSString* value = self.longText?self.textView.text:self.textField.text;
    value = value.length == 0?@"":value;
    dictMutable[self.key] = value;
    
    
    SHOW_SPINNER(self);
    [TPUser updateUserProfile:[dictMutable copy] withCompletion:^(NSError *err) {
       
        HIDE_SPINNER(self);
        if (!err) {
            
            TOAST(self, @"更新成功");
            if (self.callback) {
                self.callback();
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self onback];
            });
        }
        else
        {
            TOAST_ERROR(self, err);
        }
        
    }];
    

}

@end
