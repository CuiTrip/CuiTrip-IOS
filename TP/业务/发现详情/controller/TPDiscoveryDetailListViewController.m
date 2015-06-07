  
//
//  TPDiscoveryDetailListViewController.m
//  TP
//
//  Created by moxin on 2015-06-02 22:32:08 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPDiscoveryDetailListViewController.h"
#import "TPCommentListViewController.h"
#import "TPDiscoveryDetailListModel.h"
#import "TPDiscoveryDetailListViewDataSource.h"
#import "TPDiscoveryDetailListViewDelegate.h"
#import "TPDiscoveryDetailContentViewController.h"
#import "TPDatePickerViewController.h"
#import "TPProfilePageListViewController.h"

@interface TPDiscoveryDetailListViewHeaderView:UIView

@property(nonatomic,strong) UIImageView* imageView;
@property(nonatomic,strong) UILabel* moneyLabel;

@end

@implementation TPDiscoveryDetailListViewHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        
//        self.imageView = [TPUIKit imageView];
//        self.imageView.vzWidth = frame.size.width;
//        self.imageView.vzHeight = frame.size.height;
//        self.imageView.image = __image(@"mazu.png");
//        [self addSubview:self.imageView];
//        
//        
        self.moneyLabel = [TPUIKit label:[UIColor whiteColor] Font:[UIFont systemFontOfSize:18.0f]];
        self.moneyLabel.vzOrigin = (CGPoint){0,230};
        self.moneyLabel.vzWidth = 124;
        self.moneyLabel.vzHeight= 35;
        self.moneyLabel.text = @"   RMB 8888";
        self.moneyLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        [self addSubview:self.moneyLabel];
    }
    return self;
}

@end

@interface TPDiscoveryDetailListViewController()

@property(nonatomic,strong)UIImageView* parallexView;
@property(nonatomic,strong)TPDiscoveryDetailListModel *discoveryDetailListModel; 
@property(nonatomic,strong)TPDiscoveryDetailListViewDataSource *ds;
@property(nonatomic,strong)TPDiscoveryDetailListViewDelegate *dl;

@end

@implementation TPDiscoveryDetailListViewController

//////////////////////////////////////////////////////////// 
#pragma mark - setters 



//////////////////////////////////////////////////////////// 
#pragma mark - getters 

   
- (TPDiscoveryDetailListModel *)discoveryDetailListModel
{
    if (!_discoveryDetailListModel) {
        _discoveryDetailListModel = [TPDiscoveryDetailListModel new];
        _discoveryDetailListModel.key = @"__TPDiscoveryDetailListModel__";
    }
    return _discoveryDetailListModel;
}


- (TPDiscoveryDetailListViewDataSource *)ds{

  if (!_ds) {
      _ds = [TPDiscoveryDetailListViewDataSource new];
   }
   return _ds;
}

 
- (TPDiscoveryDetailListViewDelegate *)dl{

  if (!_dl) {
      _dl = [TPDiscoveryDetailListViewDelegate new];
   }
   return _dl;
}


////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods

- (void)loadView
{
    [super loadView];
    
//    
    UIImageView* imageView = [TPUIKit imageView];
    imageView.vzWidth = self.view.frame.size.width;
    imageView.vzHeight = 400;
    imageView.image = __image(@"mazu.png");
    [self.view addSubview:imageView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //1,config your tableview
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.separatorStyle = NO;
    
    //2,set some properties:下拉刷新，自动翻页
    self.needLoadMore = NO;
    self.needPullRefresh = NO;

    
    //3，bind your delegate and datasource to tableview
    self.dataSource = self.ds;
    self.delegate = self.dl;
    

    //4,@REQUIRED:YOU MUST SET A KEY MODEL!
    //self.keyModel = self.model;
    
    //5,REQUIRED:register model to parent view controller
    //[self registerModel:self.keyModel];

    //6,Load Data
    //[self load];
    
    
    //header view
    TPDiscoveryDetailListViewHeaderView* headerView = [[TPDiscoveryDetailListViewHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.vzWidth, 270)];
    headerView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = headerView;
    
    
    //footer view
    UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.tableView.vzWidth, 44)];
    btn.backgroundColor = [TPTheme themeColor];
    [btn setTitle:@"联系预定" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       
        [TPLoginManager showLoginViewControllerWithCompletion:^(NSError *error) {
           
            [TPLoginManager hideLoginViewController];
            
            if (!error) {
                
                //跳转到预约
                UIViewController* v = [[UIStoryboard storyboardWithName:@"TPReserveViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"tpreservedetail"];
                [self.navigationController pushViewController:v animated:true];
                
            }
            else
            {
                TOAST(self, @"登录失败");
            }
            
        }];
        
    }];
    self.tableView.tableFooterView = btn;
    
    
    UIButton* backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
    [backBtn setBackgroundImage:__image(@"trip_left_w.png") forState:UIControlStateNormal];
    [[backBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         [self.navigationController popViewControllerAnimated:true];
     }];
    [self.view addSubview:backBtn];
    
    UIButton* shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.vzWidth-44, 20, 44 , 44)];
    [shareBtn setBackgroundImage:__image(@"trip_share_w.png") forState:UIControlStateNormal];
    [[shareBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
       
        //分享//
    }];
    [self.view addSubview:shareBtn];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //todo..
    self.navigationController.navigationBarHidden = true;
    self.tabBarController.tabBar.hidden = true;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //todo..
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = false;
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
#pragma mark - @override methods - VZViewController


////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods - VZListViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  //todo...
  
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath component:(NSDictionary *)bundle{

  //todo:...
    NSString* type = bundle[@"type"];
    
    //服务详情
    if ([type isEqualToString:@"gotoServiceDetail"]) {
        
        TPDiscoveryDetailContentViewController* vc = [TPDiscoveryDetailContentViewController new];
        vc.title = @"旅程描述";
        vc.titleString = @"台湾妈祖神庙参观";
        vc.content = @"通常使用 NSURLConnection 时，你会传入一个 Delegate，当调用了 [connection start] 后，这个 Delegate 就会不停收到事件回调。实际上，start 这个函数的内部会会获取 CurrentRunLoop，然后在其中的 DefaultMode 添加了4个 Source0 (即需要手动触发的Source)。CFMultiplexerSource 是负责各种 Delegate 回调的，CFHTTPCookieStorage 是处理各种 Cookie 的\n\n当开始网络传输时，我们可以看到 NSURLConnection 创建了两个新线程：com.apple.NSURLConnectionLoader 和 com.apple.CFSocket.private。其中 CFSocket 线程是处理底层 socket 连接的。NSURLConnectionLoader 这个线程内部会使用 RunLoop 来接收底层 socket 的事件，并通过之前添加的 Source0 通知到上层的 Delegate。";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([type isEqualToString:@"gotoComment"])
    {
        TPCommentListViewController* vc = [TPCommentListViewController new];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if([type isEqualToString:@"gotoDatePicker"])
    {
        TPDatePickerViewController* vc = [TPDatePickerViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([type isEqualToString:@"gotoFee"])
    {
        TPDiscoveryDetailContentViewController* vc = [TPDiscoveryDetailContentViewController new];
        vc.title = @"台湾妈祖神庙参观";
        vc.titleString = @"费用说明";
        vc.content = @"通常使用 NSURLConnection 时，你会传入一个 Delegate，当调用了 [connection start] 后，这个 Delegate 就会不停收到事件回调。实际上，start 这个函数的内部会会获取 CurrentRunLoop，然后在其中的 DefaultMode 添加了4个 Source0 (即需要手动触发的Source)。CFMultiplexerSource 是负责各种 Delegate 回调的，CFHTTPCookieStorage 是处理各种 Cookie 的\n\n当开始网络传输时，我们可以看到 NSURLConnection 创建了两个新线程：com.apple.NSURLConnectionLoader 和 com.apple.CFSocket.private。其中 CFSocket 线程是处理底层 socket 连接的。NSURLConnectionLoader 这个线程内部会使用 RunLoop 来接收底层 socket 的事件，并通过之前添加的 Source0 通知到上层的 Delegate。";
        [self.navigationController pushViewController:vc animated:YES];
 
    }
    else if ([type isEqualToString:@"gotoLicence"])
    {
        TPDiscoveryDetailContentViewController* vc = [TPDiscoveryDetailContentViewController new];
        vc.title = @"脆饼旅行";
        vc.titleString = @"脆饼公约";
        vc.content = @"通常使用 NSURLConnection 时，你会传入一个 Delegate，当调用了 [connection start] 后，这个 Delegate 就会不停收到事件回调。实际上，start 这个函数的内部会会获取 CurrentRunLoop，然后在其中的 DefaultMode 添加了4个 Source0 (即需要手动触发的Source)。CFMultiplexerSource 是负责各种 Delegate 回调的，CFHTTPCookieStorage 是处理各种 Cookie 的\n\n当开始网络传输时，我们可以看到 NSURLConnection 创建了两个新线程：com.apple.NSURLConnectionLoader 和 com.apple.CFSocket.private。其中 CFSocket 线程是处理底层 socket 连接的。NSURLConnectionLoader 这个线程内部会使用 RunLoop 来接收底层 socket 的事件，并通过之前添加的 Source0 通知到上层的 Delegate。";
        [self.navigationController pushViewController:vc animated:YES];

    }

}

//////////////////////////////////////////////////////////// 
#pragma mark - public method 



//////////////////////////////////////////////////////////// 
#pragma mark - private callback method 



@end
 
