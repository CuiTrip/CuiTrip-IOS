//
//  TPPSFeeViewController.m
//  TP
//
//  Created by moxin on 15/6/11.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPPSFeeViewController.h"

@interface TPPSFeeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation TPPSFeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.descLabel.text = @"对于未越狱的iOS设备来说，由于强大的沙箱和授权机制，以及Apple自己掌控的App Store， 基本上杜绝了恶意软件的入侵。但除系统安全之外，我们还是面临很多的安全问题：网络安全、数据安全等，每一项涉及也非常广，安全是非常大的课题，本人并非专业的安全专家，只是从开发者的角度，分析我们常遇到的各项安全问题，并提出通常的解决方法，与各位交流。";
    [self.descLabel sizeToFit];
    
    self.textField.layer.cornerRadius = 5.0f;
    self.textField.layer.borderColor = [TPTheme grayColor].CGColor;
    self.textField.layer.borderWidth = kOnePixel;
    self.textField.layer.masksToBounds = true;
    self.textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, self.textField.vzHeight)];
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onNext
{
    if (self.callback) {
        self.callback(self.textField.text,nil);
    }
}

- (void)onBack
{


}


@end
