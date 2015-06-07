  
//
//  TPMeViewController.m
//  TP
//
//  Created by moxin on 2015-06-01 19:41:46 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPMeViewController.h"
#import "TPMeSubView.h"
#import "TPMeModel.h"
#import "TPSystemSettingsViewController.h"

@interface TPMeViewController()

 
@property(nonatomic,strong)TPMeModel *meModel;
@property(nonatomic,strong) TPMeSubView* headerView;

@end

@implementation TPMeViewController


//////////////////////////////////////////////////////////// 
#pragma mark - setters 



//////////////////////////////////////////////////////////// 
#pragma mark - getters 

   
- (TPMeModel *)meModel
{
    if (!_meModel) {
        _meModel = [TPMeModel new];
        _meModel.key = @"__TPMeModel__";
    }
    return _meModel;
}



////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods

- (void)loadView
{
    [super loadView];
    //todo..
    [self setTitle:@"我的"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(onSetting) ];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //todo..
    
    void(^loadModel)(void) = ^{
        
        [TPUIKit removeExceptionView:self.view];
        
        
        //setupUI
        [self setupTableView];
        
        
    };
    
    if (![TPUser isLogined]) {
        
        [TPUIKit showSessionErrorView:self.view loginSuccessCallback:^{
           
            loadModel();
            
        }];
        
        [TPLoginManager showLoginViewControllerWithCompletion:^(NSError *error) {
            
            [TPLoginManager hideLoginViewController];
            
            loadModel();
            
        }];
    }
    else
    {
        loadModel();
    }
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //todo..
    self.tabBarController.tabBar.hidden = false;
    

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //todo..
    self.tabBarController.tabBar.hidden = true;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    //todo..
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

-(void)dealloc {
    
    //todo..
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods

- (UIView* )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return self.headerView;
    }
    else
    {
        return nil;
    }
}


- (void)setupTableView
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TPMeSubView" owner:self options:nil];
    self.headerView = (TPMeSubView *)[nib objectAtIndex:0];
    self.headerView.vzWidth = self.view.vzWidth;
    self.headerView.vzHeight = 350;
    self.tableView.tableHeaderView = self.headerView;
    
    UIView* footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.vzWidth, 160)];
    UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake((self.view.vzWidth-200)/2, 50, 200, 44)];
    [btn setTitle:@"切换到发现者模式" forState:UIControlStateNormal];
    [btn setBackgroundColor:[TPTheme themeColor]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        //跳转到发现者
        
        
    }];
    [footerView addSubview:btn];
    self.tableView.tableFooterView = footerView;
}


- (void)onSetting
{
    TPSystemSettingsViewController* vc = [[UIStoryboard storyboardWithName:@"TPSystemSettingsViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"tpsettings"];
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
 
