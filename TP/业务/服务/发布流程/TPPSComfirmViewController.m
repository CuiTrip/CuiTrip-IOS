//
//  TPPublishComfirmViewController.m
//  TP
//
//  Created by moxin on 15/6/13.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPPSComfirmViewController.h"

@interface TPPSComfirmViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *feeLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@end

@implementation TPPSComfirmViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = self.tripTitle;
    self.feeLabel.text = self.fee;
    [self setTitle:@"添加发现"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onConfirm:(id)sender {
    
    self.complete();
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
