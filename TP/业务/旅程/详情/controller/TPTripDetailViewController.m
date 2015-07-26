
//
//  TPTripDetailViewController.m
//  TP
//
//  Created by moxin on 2015-06-07 21:28:19 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPTripDetailViewController.h"
#import "TPTripDetailModel.h"
#import "TPCustomerInTripView.h"
#import "TPTripDetailSubView.h"
#import "TPCustomerInTripView.h"
#import "TPTrippingContactInfoViewController.h"
#import "TPCancelTripViewController.h"
#import "TPReserveViewController.h"
#import "TPTripCancelledViewController.h"
#import "TPPublishCommentViewController.h"

@interface TPTripDetailViewController()

@property(nonatomic,strong) UITableView* tableView;
@property(nonatomic,strong) TPTripDetailSubView* subView;
@property(nonatomic,strong) TPCustomerInTripView* inTripView;
@property(nonatomic,strong) TPTripDetailModel *tripDetailModel;


@end

@implementation TPTripDetailViewController


////////////////////////////////////////////////////////////
#pragma mark - setters



////////////////////////////////////////////////////////////
#pragma mark - getters


- (TPTripDetailModel *)tripDetailModel
{
    if (!_tripDetailModel) {
        _tripDetailModel = [TPTripDetailModel new];
        _tripDetailModel.key = @"__TPTripDetailModel__";
    }
    return _tripDetailModel;
}

////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods

- (void)loadView
{
    [super loadView];
    [self setTitle:@"旅程"];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tripDetailModel.oid = self.oid;
    [self registerModel:self.tripDetailModel];
    
    __observeNotify(@selector(onLoginSuccess),kTPNotifyMessageLoginSuccess);
    void(^loadModel)(void) = ^{
        
        [TPLoginManager hideLoginViewController];
        [TPUIKit removeExceptionView:self.view];
        
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
    self.tabBarController.tabBar.hidden = true;
    //todo..
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //todo..
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

-(void)dealloc {
    
    //todo..
}


/////////////////////////////////
#pragma mark ---------- private method

- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.vzWidth, self.view.vzHeight) style:UITableViewStyleGrouped];
    //self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.opaque = YES;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}


- (void)initSubViews
{
    if ([self.tripDetailModel.status intValue] == kOrderInTrip)
    {
        self.inTripView = [[TPCustomerInTripView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.vzWidth, self.view.vzHeight)];
        self.inTripView.model = self.tripDetailModel;
        self.tableView.tableHeaderView = self.inTripView;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"联系脆饼" style:UIBarButtonItemStylePlain target:self action:@selector(callTripping)];
    }
    else
    {
        self.subView = [[TPTripDetailSubView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 362.5f)];
        self.subView.tripDetailModel = self.tripDetailModel;
        self.tableView.tableHeaderView = self.subView;
    }
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
}

- (void)cellWithStatus:(UITableViewCell *)cell
{
    UILabel *textLabel = [TPUIKit label:[UIColor whiteColor] Font:[UIFont systemFontOfSize:18.0f]];
    textLabel.frame = CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 44.0f);
    textLabel.textAlignment = NSTextAlignmentCenter;
    [cell addSubview:textLabel];
    if ([self.tripDetailModel.status intValue] == kOrderReadyConfirm) {
        cell.backgroundView.backgroundColor = [TPTheme themeColor];
        cell.selectedBackgroundView.backgroundColor = [TPTheme themeColor];
        textLabel.text = @"修改预约";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消行程" style:UIBarButtonItemStylePlain target:self action:@selector(cancelTrip)];
    }
    if ([self.tripDetailModel.status intValue] == kOrderReadyPay) {
        cell.backgroundView.backgroundColor = [TPTheme themeColor];
        cell.selectedBackgroundView.backgroundColor = [TPTheme themeColor];
        textLabel.text = @"立即支付";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消行程" style:UIBarButtonItemStylePlain target:self action:@selector(cancelTrip)];
    }
    if ([self.tripDetailModel.status intValue] == kOrderReadyBegin) {
        cell.backgroundView.backgroundColor = [UIColor colorWithRed:216 / 255.0f green:216 / 255.0f blue:216 / 255.0f alpha:1.0f];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:216 / 255.0f green:216 / 255.0f blue:216 / 255.0f alpha:1.0f];
        textLabel.text = @"旅程待开始";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消行程" style:UIBarButtonItemStylePlain target:self action:@selector(cancelTrip)];
    }
    if ([self.tripDetailModel.status intValue] == kOrderReadyComment) {
        cell.backgroundView.backgroundColor = [TPTheme themeColor];
        cell.selectedBackgroundView.backgroundColor = [TPTheme themeColor];
        textLabel.text = @"评价";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"联系脆饼" style:UIBarButtonItemStylePlain target:self action:@selector(callTripping)];
    }
    if ([self.tripDetailModel.status intValue] == kOrderFinished) {
        cell.backgroundView.backgroundColor = [UIColor colorWithRed:216 / 255.0f green:216 / 255.0f blue:216 / 255.0f alpha:1.0f];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:216 / 255.0f green:216 / 255.0f blue:216 / 255.0f alpha:1.0f];
        textLabel.text = @"旅程已完成";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"联系脆饼" style:UIBarButtonItemStylePlain target:self action:@selector(callTripping)];
    }
    if ([self.tripDetailModel.status intValue] == kOrderInvalid) {
        cell.backgroundView.backgroundColor = [UIColor colorWithRed:216 / 255.0f green:216 / 255.0f blue:216 / 255.0f alpha:1.0f];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:216 / 255.0f green:216 / 255.0f blue:216 / 255.0f alpha:1.0f];
        textLabel.text = @"旅程已失效";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"联系脆饼" style:UIBarButtonItemStylePlain target:self action:@selector(callTripping)];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods

- (void)showLoading:(VZModel *)model
{
    [super showLoading:model];
    
    SHOW_SPINNER(self);
}


- (void)showError:(NSError *)error withModel:(VZModel *)model
{
    [super showError:error withModel:model];
    
    HIDE_SPINNER(self);
    
    TOAST_ERROR(self, error);
}

- (void)showModel:(VZModel *)model
{
    self.tripDetailModel = (TPTripDetailModel *)model;
    HIDE_SPINNER(self);
    //todo:
    [super showModel:model];
    [self setupTableView];
    [self initSubViews];
}

////////////////////////////////////////////////////////////
#pragma mark - tableview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.tripDetailModel.status intValue] == kOrderInTrip) {
        return 0;
    }
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"tripDetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row != 3) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.row == 0)
    {
        cell.textLabel.text = @"预约日期";
        cell.detailTextLabel.text = [TPUtils changeDateFormatString:self.tripDetailModel.serviceDate FromOldFmt:@"yyyy-MM-dd HH:mm:ss" ToNew:@"yyyy年M月d日"];
    }
    else if (indexPath.row == 1)
    {
        cell.textLabel.text = @"约定人数";
        cell.detailTextLabel.text = self.tripDetailModel.buyerNum;
    }
    else if (indexPath.row == 2)
    {
        cell.textLabel.text = @"服务费用";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", self.tripDetailModel.orderPrice, self.tripDetailModel.moneyType];
    }
    else if (indexPath.row == 3)
    {
        cell.backgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        [self cellWithStatus:cell];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 3) {
        return;
    }
    [self actionWithStatus];
}


////////////////////////////////

#pragma mark - button action

- (void)callTripping
{
    [self.navigationController pushViewController:[TPTrippingContactInfoViewController new] animated:true];
}

- (void)cancelTrip
{
    TPCancelTripViewController *vc = [TPCancelTripViewController new];
    vc.tripDetailModel = self.tripDetailModel;
    [self.navigationController pushViewController:vc animated:true];
}

- (void)actionWithStatus
{
    
    if ([self.tripDetailModel.status intValue] != kOrderReadyConfirm && [self.tripDetailModel.status intValue] != kOrderReadyPay && [self.tripDetailModel.status intValue] != kOrderReadyComment) {
        return;
    }
    if ([self.tripDetailModel.status intValue] == kOrderReadyConfirm) {
        //去修改
        TPReserveViewController* v = [[UIStoryboard storyboardWithName:@"TPReserveViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"tpreservedetail"];
        v.type = kModifyOrder;
        v.sid = self.tripDetailModel.sid;
        v.maxNum = 6;
        v.oid = self.tripDetailModel.oid;
        v.insiderId = self.tripDetailModel.insiderId;
        v.servicePrice = self.tripDetailModel.orderPrice;
        v.serviceName = self.tripDetailModel.serviceName;
        v.moneyType = self.tripDetailModel.moneyType;
        [self.navigationController pushViewController:v animated:true];
    }
    
    if ([self.tripDetailModel.status intValue] == kOrderReadyPay) {
        
    }
    
    if ([self.tripDetailModel.status intValue] == kOrderReadyComment) {
        TPPublishCommentViewController *vc = [TPPublishCommentViewController new];
        vc.tripDetailModel = self.tripDetailModel;
        [self.navigationController pushViewController:vc animated:true];
    }
    
}


////////////////////////////////

#pragma mark - private callback method

- (void)onLoginSuccess
{
    
    [TPLoginManager hideLoginViewController];
    [TPUIKit removeExceptionView:self.view];
    
    //setupUI
    [self setupTableView];
    [self load];
}





@end

