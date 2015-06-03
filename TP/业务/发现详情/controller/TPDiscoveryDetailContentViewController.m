//
//  TPDiscoveryDetailContentViewController.m
//  TP
//
//  Created by moxin on 15/6/3.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPDiscoveryDetailContentViewController.h"

@interface TPDiscoveryDetailContentViewController ()

@property(nonatomic,strong) UILabel* titleLabel;
@property(nonatomic,strong) UITextView* textView;

@end

@implementation TPDiscoveryDetailContentViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.view.vzWidth, 18)];
    self.titleLabel.textColor = HEXCOLOR(0x4a4a4a);
    self.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    self.titleLabel.text = self.titleString;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.titleLabel];
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(30, self.titleLabel.vzBottom+20, self.view.vzWidth-60, self.view.vzHeight-self.titleLabel.vzBottom - 50)];
    self.textView.editable = false;
    self.textView.textColor = HEXCOLOR(0x9b9b9b);
    self.textView.font = [UIFont systemFontOfSize:14.0f];

    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineHeightMultiple = 20.0f;
    paragraphStyle.maximumLineHeight = 20.0f;
    paragraphStyle.minimumLineHeight = 20.0f;
    
    NSString *string = self.content;
    NSDictionary *ats = @{
                          NSFontAttributeName : [UIFont systemFontOfSize:14.0f],
                          NSParagraphStyleAttributeName : paragraphStyle,
                          };
    
    self.textView.attributedText = [[NSAttributedString alloc] initWithString:string attributes:ats];
    
   // self.textView.text = self.content;

    
    [self.view addSubview:self.textView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
