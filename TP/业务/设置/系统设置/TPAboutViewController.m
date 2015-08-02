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

@property(nonatomic,weak)  UIView *headView;
@property(nonatomic,weak)  UIView *footView;

@end

@implementation TPAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"关于脆饼"];
    self.tableView.tableFooterView = [TPUIKit emptyView];
//    
//    [self.view setBackgroundColor:[UIColor whiteColor]];
//    
//    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.vzWidth, self.view.vzHeight) style:UITableViewStyleGrouped];
//    self.tableView.backgroundColor = [UIColor whiteColor];
//    self.tableView.opaque = YES;
//    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    self.tableView.dataSource = self;
//    self.tableView.delegate = self;
//    //[self.view addSubview:self.tableView];
//    
//   
//    UIImage *img = __image(@"trip_logo_a.png");
//    _tripLogo= [[UIImageView alloc] initWithImage:img];
//    _tripLogo.frame = CGRectMake((self.view.vzWidth - 155.0f) / 2, 85.0f, 155.0f, (img.size.height * 155)/img.size.width);
//    
//    UIView* footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.vzWidth, 160)];
//    UILabel *label = [TPUIKit label:[TPTheme blackColor] Font:[UIFont systemFontOfSize:9.0f]];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.frame = CGRectMake(0.0f, 0.0f, footerView.vzWidth, 15.0f);
//    
//    label.text = @"Copyright © 2015  Cuitrip All Rights Reserved";
//    [footerView addSubview:label];
//    
////    [footerView addSubview:btn];
//    self.tableView.tableHeaderView = _tripLogo;
//    self.tableView.tableFooterView = footerView;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"aboutTripCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }

    if (indexPath.row == 0)
    {
        cell.textLabel.text = @"版本号";
        cell.detailTextLabel.text = @"V1.1.0";
    }
    else if (indexPath.row == 1)
    {
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"支持脆饼";
    }
    else if (indexPath.row == 2)
    {
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"联系脆饼";
    }
    return cell;
    
}

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
