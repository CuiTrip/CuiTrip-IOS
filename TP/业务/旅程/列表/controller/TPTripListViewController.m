
//
//  TPTripListViewController.m
//  TP
//
//  Created by moxin on 2015-06-01 19:41:29 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPTripListViewController.h"
#import "TPTripListModel.h"
#import "TPTripListViewDataSource.h"
#import "TPTripListViewDelegate.h"
#import "TPTripDetailViewController.h"
#import "TPTripListItem.h"


@interface TPTripListViewController()


@property(nonatomic,strong)TPTripListModel *tripListModel;
@property(nonatomic,strong)TPTripListViewDataSource *ds;
@property(nonatomic,strong)TPTripListViewDelegate *dl;

@end

@implementation TPTripListViewController

////////////////////////////////////////////////////////////
#pragma mark - setters



////////////////////////////////////////////////////////////
#pragma mark - getters


- (TPTripListModel *)tripListModel
{
    if (!_tripListModel) {
        _tripListModel = [TPTripListModel new];
        _tripListModel.key = @"__TPTripListModel__";
    }
    return _tripListModel;
}


- (TPTripListViewDataSource *)ds{
    
    if (!_ds) {
        _ds = [TPTripListViewDataSource new];
    }
    return _ds;
}


- (TPTripListViewDelegate *)dl{
    
    if (!_dl) {
        _dl = [TPTripListViewDelegate new];
    }
    return _dl;
}


////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods

- (void)loadView
{
    [super loadView];
    
    [self setTitle:@"旅程"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 解决底部上拉不了
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    __observeNotify(@selector(onLoginSuccess),kTPNotifyMessageLoginSuccess);
    
    [self registerChannelMsg];
    
    void(^loadModel)(void) = ^{
        
        [TPLoginManager hideLoginViewController];
        [TPUIKit removeExceptionView:self.view];
        
        //setupUI
        [self setupTableView];
        [self load];
        
        
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
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //todo..
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    //todo..
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

- (void) viewDidLayoutSubviews {
    CGRect viewBounds = self.view.bounds;
    CGFloat topBarOffset = self.topLayoutGuide.length;
    viewBounds.origin.y = topBarOffset * -1;
    self.view.bounds = viewBounds;
}


-(void)dealloc {
    
    //todo..
}

- (BOOL)hidesBottomBarWhenPushed
{
    return true;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods - VZViewController

- (void)showEmpty:(VZModel *)model
{
    [[self.view viewWithTag:100]removeFromSuperview];
    
    UIView* empty = nil;
    if ([TPUser type] == kCustomer) {
        
        empty = [TPUIKit defaultExceptionView:@"您的旅程" SubTitle:@"如果您已经确认了旅程，将会在这里看到" btnTitle:@"来看看旅程推荐吧" Callback:^{
            
            [self.tabBarController setSelectedIndex:0];
            
        }];
    }
    if ([TPUser type] == kProvider) {
        
        empty = [TPUIKit defaultExceptionView:@"您创建的旅程" SubTitle:@"如果您已经创建了旅程，将会在这里看到" btnTitle:@"去创建旅程吧" Callback:^{
            
            [self.tabBarController setSelectedIndex:0];
            
        }];
    }
    
    empty.tag = 100;
    [self.view addSubview:empty];
}

- (void)showNoResult:(VZHTTPListModel *)model
{
    [super showNoResult:model];
    
    [self showEmpty:model];
}


////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods - VZListViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //todo...
    TPTripListItem* item = (TPTripListItem* )[self.dataSource itemForCellAtIndexPath:indexPath];
    
    //    TPTripDetailViewController* vc = [[UIStoryboard storyboardWithName:@"TPTripDetailViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"tptripdetail"];
    
    TPTripDetailViewController* vc = [TPTripDetailViewController new];
    vc.oid = item.oid;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    [self.navigationController pushViewController:vc animated:true];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath component:(NSDictionary *)bundle{
    
    //todo:...
    
}

////////////////////////////////////////////////////////////
#pragma mark - public method



////////////////////////////////////////////////////////////
#pragma mark - private callback method

- (void)setupTableView
{
    //1,config your tableview
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44);
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.showsVerticalScrollIndicator = YES;
    //self.tableView.tableFooterView = [TPUIKit emptyView];
    //2,set some properties:下拉刷新，自动翻页
    self.needLoadMore = NO;
    self.needPullRefresh = true;
    
    
    //3，bind your delegate and datasource to tableview
    self.dataSource = self.ds;
    self.delegate = self.dl;
    
    
    //4,@REQUIRED:YOU MUST SET A KEY MODEL!
    self.keyModel = self.tripListModel;
    
    //5,REQUIRED:register model to parent view controller
    [self registerModel:self.keyModel];
    
}

- (void)registerChannelMsg
{
    __weak typeof(self) weakSelf = self;
    [self vz_listOnChannel:kChannelNewOrder withNotificationBlock:^(id obj, id data) {
        
        if ([TPUser isLogined]) {
            [weakSelf load];
        }
        
    }];
    
}

- (void)onLoginSuccess
{
    
    [TPLoginManager hideLoginViewController];
    [TPUIKit removeExceptionView:self.view];
    
    //setupUI
    [self setupTableView];
    [self load];
}

@end

