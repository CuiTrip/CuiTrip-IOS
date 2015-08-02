//
//  TPSystemSettingsViewController.m
//  TP
//
//  Created by moxin on 15/6/7.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPAboutViewController.h"
#import "TPFeedbackViewController.h"
#import "TPTrippingContactInfoViewController.h"
#import "TPShareTrippingViewController.h"

@interface TPAboutViewController ()

@end

@implementation TPAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"关于脆饼"];
    
    [self.view setBackgroundColor:[TPTheme yellowColor]];
    
    UIView* footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.vzWidth, 160)];
    
//    [footerView addSubview:btn];
    self.tableView.tableFooterView = footerView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = true;
    //todo..
    [MobClick beginLogPageView:@"TPAboutView"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //todo..
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"TPAboutView"];
    //todo..
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidLayoutSubviews {
    CGRect viewBounds = self.view.bounds;
    CGFloat topBarOffset = self.topLayoutGuide.length;
    viewBounds.origin.y = topBarOffset * -1;
    self.view.bounds = viewBounds;
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
//    if (indexPath.row == 1)
//    {
//        UIViewController* vc = [TPFeedbackViewController new];
//        [self.navigationController pushViewController:vc animated:true];
//        
//    }
    if(indexPath.row == 1)
    {
        UIViewController* vc = [TPShareTrippingViewController new];
        [self.navigationController pushViewController:vc animated:true];

    }
    else if(indexPath.row == 2)
    {
        UIViewController* vc = [TPTrippingContactInfoViewController new];
        [self.navigationController pushViewController:vc animated:true];
    }
    else
    {
        //打分
    }
}

@end
