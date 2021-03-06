//
//  TPSystemSettingsViewController.m
//  TP
//
//  Created by moxin on 15/6/7.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPSystemSettingsViewController.h"
#import "TPAboutViewController.h"

@interface TPSystemSettingsViewController ()

@end

@implementation TPSystemSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"系统设置"];
    
    [self.view setBackgroundColor:[TPTheme yellowColor]];
    
    UIView* footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.vzWidth, 160)];
    UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake((self.view.vzWidth-200)/2, 50, 200, 44)];
    btn.layer.cornerRadius = 5.0f;
    btn.layer.masksToBounds = true;
    [btn setTitle:@"退出登录" forState:UIControlStateNormal];
    [btn setBackgroundColor:[TPTheme themeColor]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
    
        [WCAlertView showAlertWithTitle:@"" message:@"确定要退出登录吗?" customizationBlock:^(WCAlertView *alertView) {
            
        } completionBlock:^(NSUInteger buttonIndex, WCAlertView *alertView) {
            
            if (buttonIndex == 1) {
                [TPLoginManager logout];
            }
            
        } cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
  
        
    }];
    [footerView addSubview:btn];
    self.tableView.tableFooterView = footerView;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = true;
    //todo..
    [MobClick beginLogPageView:@"TPSystemSettingsView"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //todo..
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"TPSystemSettingsView"];
    //todo..
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {

        UIViewController* vc = [[UIStoryboard storyboardWithName:@"TPModifyPWDViewController" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"tpmodifypwd"];
        [self.navigationController pushViewController:vc animated:true];
        
    }
    else if(indexPath.row == 1)
    {
        //UIViewController* vc = [[UIStoryboard storyboardWithName:@"TPAboutViewController" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"tpabout"];
        TPAboutViewController* vc = [TPAboutViewController new];
        [self.navigationController pushViewController:vc animated:true];
    }
    else
    {
        //打分
    }
}

@end
