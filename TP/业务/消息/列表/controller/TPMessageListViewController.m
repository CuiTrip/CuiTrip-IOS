  
//
//  TPMessageListViewController.m
//  TP
//
//  Created by moxin on 2015-06-01 19:41:08 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPMessageListViewController.h"
#import "TPChatListViewController.h"
#import "TPMessageListModel.h" 
#import "TPMessageListViewDataSource.h"
#import "TPMessageListViewDelegate.h"
#import "TPMessageListItem.h"

@interface TPMessageListViewController()
@property(nonatomic,strong)UIView *segmentView;
@property(nonatomic,strong)TPMessageListModel *messageListModel;
@property(nonatomic,strong)TPMessageListViewDataSource *ds;
@property(nonatomic,strong)TPMessageListViewDelegate *dl;

@end

@implementation TPMessageListViewController

//////////////////////////////////////////////////////////// 
#pragma mark - setters 



//////////////////////////////////////////////////////////// 
#pragma mark - getters 

   
- (TPMessageListModel *)messageListModel
{
    if (!_messageListModel) {
        _messageListModel = [TPMessageListModel new];
        _messageListModel.key = @"__TPMessageListModel__";
        _messageListModel.userType = [TPUser type];
    }
    return _messageListModel;
}


- (TPMessageListViewDataSource *)ds{

  if (!_ds) {
      _ds = [TPMessageListViewDataSource new];
   }
   return _ds;
}

 
- (TPMessageListViewDelegate *)dl{

  if (!_dl) {
      _dl = [TPMessageListViewDelegate new];
   }
   return _dl;
}


////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods

- (void)loadView
{
    [super loadView];
    
    [self setTitle:@"消息"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    //2,set some properties:下拉刷新，自动翻页
    self.needLoadMore = YES;
    self.needPullRefresh = YES;
    
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"旅行者", @"发现者", nil]];
    segment.segmentedControlStyle = UISegmentedControlStyleBar;
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateSelected];
    segment.frame = CGRectMake(((self.view.vzWidth-200)/2), 6, 200, 32);
    segment.tintColor=[TPTheme themeColor];
    [segment addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    if ([TPUser type] == kCustomer) {   // 旅行者
        [segment setSelectedSegmentIndex:0];
    }
    else
    {
        [segment setSelectedSegmentIndex:1];
    }
    self.tableView.showsHorizontalScrollIndicator = NO;

    _segmentView = [[UIView alloc] initWithFrame: CGRectMake(0, self.navigationItem.titleView.vzBottom, self.tableView.vzWidth, 44)];
    _segmentView.backgroundColor = [UIColor whiteColor];
    [_segmentView addSubview:segment];
    
    UIView *bottomBorder = [UIView new];
    bottomBorder.backgroundColor = [TPTheme grayColor];
    bottomBorder.frame = CGRectMake(0, _segmentView.frame.size.height-0.5, _segmentView.frame.size.width, 0.5);
    [bottomBorder setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
    [_segmentView addSubview:bottomBorder];

    self.tableView.tableHeaderView = _segmentView;
    [self.view addSubview:_segmentView];     // 加上后不随tableview滑动
    
    
//    [[self navigationController] tabBarItem].badgeValue = @"";
//    [self navigationController].tabBarController.tabBar
    

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
    [MobClick beginLogPageView:@"TPMessageListView"];
    [self checkAPNS];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"TPMessageListView"];

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

-(BOOL)hidesBottomBarWhenPushed
{
    return YES;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods - VZViewController



- (void)segmentChanged:(UISegmentedControl*)sender
{
    void(^loadModel)(void) = ^{
        [TPLoginManager hideLoginViewController];
        [TPUIKit removeExceptionView:self.view];
        
        //setupUI
        [self setupTableView];
        [self load];
    };
    
    if (sender.selectedSegmentIndex == 0) {
        _messageListModel.userType = kCustomer;
        loadModel();
        [self hideBadgeOnView:self.segmentView inIndex:0];
    } else {
        _messageListModel.userType = kProvider;
        loadModel();
        [self hideBadgeOnView:self.segmentView inIndex:1];
    }
    
}

- (void)showModel:(VZModel *)model
{
    [super showModel:model];
    
    [self checkAPNS];
    [self.tableView reloadData];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods - VZListViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  //todo...
    TPMessageListItem* item = (TPMessageListItem* )[self.ds itemForCellAtIndexPath:indexPath];
    
    if ([item.type integerValue] == 1) {
        
    }
    else
    {
        if (item.hasNewMsg) {
            
            item.hasNewMsg = NO;
            [[TPAPNS sharedInstance] removeLocalMessage];
            [self.tableView reloadData];
        }

        
        NSString* receiverId = @"";
        
        if ([TPUser type] == kCustomer) {
            receiverId = item.insiderId;
        }
        else
        {
            receiverId = item.trallerId;
        }
        TPChatListViewController* vc = [TPChatListViewController new];
        vc.orderId = item.orderId;
        vc.receiverId = receiverId;
        vc.orderStatus = item.orderStatus;
        vc.msgUserType = _messageListModel.userType;
        [self.navigationController pushViewController:vc animated:true];
    }

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
    self.tableView.separatorStyle = YES;
    //self.tableView.tableFooterView = [TPUIKit emptyView];
    //2,set some properties:下拉刷新，自动翻页
    self.needLoadMore = NO;
    self.needPullRefresh = true;
    
    
    //3，bind your delegate and datasource to tableview
    self.dataSource = self.ds;
    self.delegate = self.dl;
    
    
    //4,@REQUIRED:YOU MUST SET A KEY MODEL!
    self.keyModel = self.messageListModel;
    
    //5,REQUIRED:register model to parent view controller
    [self registerModel:self.keyModel];

}

- (void)registerChannelMsg
{
    __weak typeof(self) weakSelf = self;
    [self vz_listOnChannel:kChannelNewMessage withNotificationBlock:^(id obj, id data) {
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

-(void)checkAPNS
{
    if ([TPUser isLogined]) {
        
        NSDictionary* localPushMsg = [[TPAPNS sharedInstance] localAPNSMessage];
        
        if (!localPushMsg) {
            return;
        }
        
        NSString* orderId = localPushMsg[@"id"];
        for (int i=0; i<[self.ds itemsForSection:0].count; i++) {
            
            TPMessageListItem* item = (TPMessageListItem* )[self.ds itemForCellAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];

            if ([item.orderId isEqualToString:orderId]) {
                item.hasNewMsg = true;
                if (self.messageListModel.userType == kCustomer) {
                    [self showBadgeOnView:self.segmentView inIndex:0];
                } else{
                    [self showBadgeOnView:self.segmentView inIndex:1];
                }
                break;
            }
        }
        
        [self.tableView reloadData];
    }
}


- (void)showBadgeOnView:(UIView*)view inIndex:(int)index{
    [self removeBadgeOnView:view inIndex:index];
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 5;
    badgeView.backgroundColor = [UIColor redColor];
    CGRect tabFrame = view.frame;
    float percentX = (self.view.vzWidth-200)/2 - 5;
    CGFloat x = ceilf(percentX + index*200);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 10, 10);
    [view addSubview:badgeView];
}

- (void)hideBadgeOnView:(UIView*)view inIndex:(int)index{
    [self removeBadgeOnView:view inIndex:index];
}

- (void)removeBadgeOnView:(UIView*)view inIndex:(int)index{
    for (UIView *subView in view.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}


@end

