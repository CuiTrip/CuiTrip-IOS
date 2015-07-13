//
//  TPDiscoveryDetailContentViewController.m
//  TP
//  发现详情页，点击查看详情后的跳转页面，需要修改为图文混排详情页
//  Created by moxin on 15/6/3.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPDiscoveryDetailContentViewController.h"

@interface TPDiscoveryDetailContentViewController ()

@property(nonatomic,strong) UIScrollView* scrollView;
@property(nonatomic,strong) UILabel* titleLabel;
@property(nonatomic,strong) UILabel* textLabel;

@end

@implementation TPDiscoveryDetailContentViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = HEXCOLOR(0xfffaf1);
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.vzWidth, self.view.vzHeight)];
    [self.view addSubview:self.scrollView];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.view.vzWidth-40, 18)];
    self.titleLabel.textColor = HEXCOLOR(0x4a4a4a);
    self.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    self.titleLabel.text = self.titleString;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 1;
    [self.scrollView addSubview:self.titleLabel];
    
    self.textLabel = [TPUIKit label:HEXCOLOR(0x9b9b9b) Font:ft(14.0f)];
    self.textLabel.numberOfLines = 0;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineHeightMultiple = 16.0f;
    paragraphStyle.maximumLineHeight = 16.0f;
    paragraphStyle.minimumLineHeight = 16.0f;
    
    NSString *string = self.content;
    NSDictionary *ats = @{
                          NSFontAttributeName : [UIFont systemFontOfSize:14.0f],
                          NSParagraphStyleAttributeName : paragraphStyle,
                          };
    
    self.textLabel.attributedText = [[NSAttributedString alloc] initWithString:string attributes:ats];
    CGSize sz = [self.textLabel sizeThatFits:CGSizeMake(self.view.vzWidth-40, CGFLOAT_MAX)];
    self.textLabel.vzOrigin = CGPointMake(20, self.titleLabel.vzBottom+20);
    self.textLabel.vzSize = CGSizeMake(sz.width, sz.height);
    self.scrollView.contentSize = CGSizeMake(self.view.vzWidth, self.textLabel.vzBottom+100);
    [self.scrollView addSubview:self.textLabel];
    
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
