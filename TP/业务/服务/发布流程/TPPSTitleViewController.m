//
//  TPPSTitleViewController.m
//  TP
//
//  Created by moxin on 15/6/11.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPPSTitleViewController.h"

@interface TPPSTitleViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation TPPSTitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
