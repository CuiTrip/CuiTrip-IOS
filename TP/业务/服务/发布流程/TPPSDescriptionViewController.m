//
//  TPPSDescriptionViewController.m
//  TP
//
//  Created by moxin on 15/6/11.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPPSDescriptionViewController.h"

@interface TPPSDescriptionViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation TPPSDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textView.layer.cornerRadius = 5.0f;
    self.textView.layer.borderColor = [TPTheme grayColor].CGColor;
    self.textView.layer.borderWidth = kOnePixel;
    self.textView.layer.masksToBounds = true;
    self.textView.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)onNext
{
    if (self.textView.text.length == 0) {
        TOAST(self, @"请输入描述文字");
        return NO;
    }
    
    else if (self.textView.text.length >= 800) {
        TOAST(self, @"亲，最多只能输入800个字哦~");
        return NO;
    }
    else
    {
        if (self.callback) {
            self.callback(self.textView.text,nil);
        }
        return YES;
    }
}
- (void)onBack
{
    
}

@end
