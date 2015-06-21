  
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
    

    self.tableView.tableFooterView = [TPUIKit emptyView];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    __observeNotify(@selector(onLoginSuccess),kTPNotifyMessageLoginSuccess);

    void(^loadModel)(void) = ^{
        
        [TPLoginManager hideLoginViewController];
        [TPUIKit removeExceptionView:self.view];
        
        
        //setupUI
        [self setupTableView];
        
        
    };
    
    if (![TPUser isLogined]) {
        
        [TPUIKit showSessionErrorView:self.view loginSuccessCallback:^{
           
            
            loadModel();
            
        }];
        
        [TPLoginManager showLoginViewControllerWithCompletion:^(void) {

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
    
    if ([TPUser isLogined]) {
     
        [self.headerView.imageView sd_setImageWithURL:__url([TPUser avatar]) placeholderImage:__image(@"girl.jpg")];
        self.headerView.nameLabel.text = [TPUser userNick];
        self.headerView.descLabel.text = [TPUser sign];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
   

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

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

-(BOOL)hidesBottomBarWhenPushed
{
    return YES;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        
        UIViewController* vc = [[UIStoryboard storyboardWithName:@"TPForgetPWDViewController" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"tpforgetpwd"];
        [self.navigationController pushViewController:vc animated:true];
        
        
    }
    else if(indexPath.row == 2)
    {
        UIViewController* vc = [[UIStoryboard storyboardWithName:@"TPAboutViewController" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"tpabout"];
        [self.navigationController pushViewController:vc animated:true];
    }
    else
    {
        //打分
    }
}


- (void)setupTableView
{
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(onSetting) ];
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TPMeSubView" owner:self options:nil];
    self.headerView = (TPMeSubView *)[nib objectAtIndex:0];
    self.headerView.vzWidth = self.view.vzWidth;
    self.headerView.vzHeight = 200;
    [self.headerView.imageView sd_setImageWithURL:__url([TPUser avatar]) placeholderImage:__image(@"girl.jpg")];
    self.headerView.nameLabel.text = [TPUser userNick];
    self.headerView.descLabel.text = [TPUser sign];
    self.tableView.tableHeaderView = self.headerView;

    
    TPUserType type = [TPUser type];
    NSString* title = type == kCustomer? @"切换到发现者模式":@"切换到旅行者模式";
    
    UIView* footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.vzWidth, 160)];
    UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake((self.view.vzWidth-200)/2, 20, 200, 44)];
    btn.layer.cornerRadius  = 5.0;
    btn.layer.masksToBounds = true;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundColor:[TPTheme themeColor]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        
        [WCAlertView showAlertWithTitle:@"" message:@"确定要切换身份吗?" customizationBlock:nil completionBlock:^(NSUInteger buttonIndex, WCAlertView *alertView) {
            
            if (buttonIndex == 1) {
                
                //跳转到发现者
                if(type == kCustomer)
                {
                    [TPUser changeUserType:kProvider];
                    __notify(kTPNofityMessageSwitchIdentity);
                }
                else if (type == kProvider)
                {
                    [TPUser changeUserType:kCustomer];
                    __notify(kTPNofityMessageSwitchIdentity);
                }
                else
                {
                }
            }
            
        } cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        

        
    }];
    [footerView addSubview:btn];

    self.tableView.tableFooterView = footerView;
}


- (void)onSetting
{
    TPSystemSettingsViewController* vc = [[UIStoryboard storyboardWithName:@"TPSystemSettingsViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"tpsettings"];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)onLoginSuccess
{
    [TPLoginManager hideLoginViewController];
    [TPUIKit removeExceptionView:self.view];
    
    
    //setupUI
    [self setupTableView];
}
@end

