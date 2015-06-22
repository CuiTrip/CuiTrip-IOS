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
    self.descLabel.text = @"1. 本费⽤为发现者的基本服务费⽤，不包含双⽅任何⻔门票、餐饮、公共交通费⽤。\n\n2. 发现者在旅程中产⽣的门票、餐饮、私家车费⽤，均由旅⾏者承担。\n\n3. 其他可能产生的费用，双方自行沟通协调。";
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
    if (self.textField.text == 0) {
        TOAST(self, @"请输入价格");
        return;
    }
    if (self.callback) {
        self.callback(self.textField.text,nil);
    }
}

- (void)onBack
{


}


@end
