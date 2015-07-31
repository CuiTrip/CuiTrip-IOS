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

- (void)setTripTitle:(NSString *)tripTitle
{
    _tripTitle = tripTitle;
    self.titleLabel.text = tripTitle;
}

- (void)setPrice:(NSString *)price
{
    _price = price;
    self.feeLabel.text = price;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    [self setTitle:@"添加发现"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onConfirm:(id)sender {
    
    self.complete();
}

- (void)onBack
{

}



@end
