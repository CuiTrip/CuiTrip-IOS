  
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
#import "TPReserveViewController.h"
#import "BXImageScrollView.h"
#import "TPDDTripItem.h"
#import "TPDDInfoItem.h"
#import "TPDDProfileItem.h"
#import "TPLicenceViewController.h"
#import "TPTripArrangementModel.h"
#import "TPPSContentEditViewController.h"
#import "TPPersonalPageViewController.h"
#import "TPPersonalPageDetailViewController.h"

@interface TPDiscoveryDetailListViewHeaderView:UIView

@property(nonatomic,strong) BXImageScrollView* bannerView;
@property(nonatomic,strong) UILabel* moneyLabel;

@end

@implementation TPDiscoveryDetailListViewHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        
        self.bannerView = [[BXImageScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.bannerView.placeHolderImage = __image(@"default_details.jpg");
        [self addSubview:self.bannerView];
//
//        
        self.moneyLabel = [TPUIKit label:[UIColor whiteColor] Font:[UIFont systemFontOfSize:16.0f]];
        self.moneyLabel.vzOrigin = (CGPoint){0, 230};
        self.moneyLabel.vzWidth = 124;
        self.moneyLabel.vzHeight= 35;
        self.moneyLabel.text = @"";
        self.moneyLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        
        CAShapeLayer* layer = [CAShapeLayer new];
        layer.path = [UIBezierPath bezierPathWithRoundedRect:self.moneyLabel.bounds byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomRight) cornerRadii:CGSizeMake(17,17)].CGPath;
        self.moneyLabel.layer.mask = layer;
        
        [self addSubview:self.moneyLabel];
    }
    return self;
}

@end

@interface TPDiscoveryDetailListViewController()<UMSocialUIDelegate>

@property(nonatomic,strong) UIView* headerNavView;

@property(nonatomic,strong)TPTripArrangementModel *tripArrangementModel;
@property(nonatomic,strong)TPDiscoveryDetailListModel *discoveryDetailListModel; 
@property(nonatomic,strong)TPDiscoveryDetailListViewDataSource *ds;
@property(nonatomic,strong)TPDiscoveryDetailListViewDelegate *dl;

@end

@implementation TPDiscoveryDetailListViewController

//////////////////////////////////////////////////////////// 
#pragma mark - setters 



//////////////////////////////////////////////////////////// 
#pragma mark - getters 


- (TPTripArrangementModel *)tripArrangementModel
{
    if (!_tripArrangementModel) {
        _tripArrangementModel = [TPTripArrangementModel new];
        _tripArrangementModel.key = @"__TPTripArrangementModel__";
    }
    return _tripArrangementModel;
}
   
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
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    //self.extendedLayoutIncludesOpaqueBars = true;
    
    //1,config your tableview
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44);
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.separatorStyle = NO;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    //2,set some properties:下拉刷新，自动翻页
    self.needLoadMore = NO;
    self.needPullRefresh = NO;

    
    //3，bind your delegate and datasource to tableview
    self.dataSource = self.ds;
    self.delegate = self.dl;
    

    //4,@REQUIRED:YOU MUST SET A KEY MODEL!
    self.discoveryDetailListModel.sid = self.sid;
    self.keyModel = self.discoveryDetailListModel;
    
    //5,REQUIRED:register model to parent view controller
    [self registerModel:self.keyModel];

    //6,Load Data
    [self load];
    
    
    //header view
    TPDiscoveryDetailListViewHeaderView* headerView = [[TPDiscoveryDetailListViewHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.vzWidth, 270)];
    headerView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = headerView;

    
    
    //footer view
    if (self.type == kDetail) {
        
        UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.vzHeight-44, self.tableView.vzWidth, 44)];
        btn.tag = 101;
        btn.hidden = true;
        btn.backgroundColor = [TPTheme themeColor];
        [btn setTitle:@"联系预定" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            void(^lamda)() = ^{//跳转到预约
                TPReserveViewController* v = [[UIStoryboard storyboardWithName:@"TPReserveViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"tpreservedetail"];
                v.maxNum = [self.discoveryDetailListModel.tripDetailItem.tripPeopleNum integerValue];
                v.servicePrice = self.discoveryDetailListModel.tripDetailItem.tripFee;
                v.sid = self.sid;
                v.insiderId = self.discoveryDetailListModel.tripInfoItem.insiderId;
                v.serviceName = self.discoveryDetailListModel.tripInfoItem.name;
                v.servicePrice = self.discoveryDetailListModel.tripDetailItem.tripFee;
                v.pic = self.discoveryDetailListModel.tripInfoItem.pics[0];
                v.payCurrency = self.discoveryDetailListModel.tripInfoItem.moneyType;
                //v.insiderId = self.discoveryDetailListModel.tripf
                [self.navigationController pushViewController:v animated:true];
            };
            
            if ([TPUser isLogined]) {
                lamda();
            }
            else
            {
                [TPLoginManager showLoginViewControllerWithCompletion:^(void) {
                    lamda();
                }];
            }
            
        }];
        
        [self.view addSubview:btn];
        
        UIButton* backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
        [backBtn setBackgroundImage:__image(@"trip_left_w.png") forState:UIControlStateNormal];
        [[backBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
         subscribeNext:^(id x) {
             [self.navigationController popViewControllerAnimated:true];
         }];
        //    [self.view addSubview:backBtn];
        
        UIButton* shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.vzWidth-44, 20, 44 , 44)];
        [shareBtn setBackgroundImage:__image(@"trip_share_w.png") forState:UIControlStateNormal];
        [[shareBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
         subscribeNext:^(id x) {
             
             //分享//
             [UMSocialSnsService presentSnsIconSheetView:self
                                                  appKey:um_appKey
                                               shareText:self.discoveryDetailListModel.tripInfoItem.desc
                                              shareImage:__image(@"icon.png")
                                         shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,nil]
                                                delegate:self];
         }];
        _headerNavView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, self.view.vzWidth, 64)];
        [_headerNavView addSubview:backBtn];
        [_headerNavView addSubview:shareBtn];

    }
    else
    {
        //footer view
        UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.vzHeight - 108, self.tableView.vzWidth, 44)];
        btn.backgroundColor = [TPTheme themeColor];
        [btn setTitle:@"安排日程" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            TPDatePickerViewController* vc = [TPDatePickerViewController new];
            vc.sid = self.sid;
            vc.type = kSelection;
            vc.callback = ^(NSArray* list) {
                
              
                    NSMutableArray* dates = [NSMutableArray new];
                    for (NSDate* date in list) {
                        
                        long long t = [date timeIntervalSince1970]*1000;
                        NSString* s = [NSString stringWithFormat:@"%lld",t];
                        [dates addObject:s];
                        
                    }
   
                self.tripArrangementModel.availableDates = dates.count>0?[dates copy]:nil;
                    self.tripArrangementModel.sid = self.sid;
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        SHOW_SPINNER(self);
                        [self.tripArrangementModel loadWithCompletion:^(VZModel *model, NSError *error) {
                            
                            HIDE_SPINNER(self);
                            if (!error) {
                                
                                TOAST(self, @"安排成功!");

                            }
                            else
                            {
                                TOAST_ERROR(self, error);
                            }
                            
                        }];
                    });
                
   
                
                
            };
            [self.navigationController pushViewController:vc animated:true];
            
        }];
        [self.view addSubview:btn];
    }


    UIView* footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds), 44)];
    footer.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = footer;
    [self.view addSubview:self.headerNavView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"TPDiscoveryDetailListView"];
    if (self.type == kArrangeMent) {
        self.navigationItem.title = @"发现";
        if (self.checkStatus == 2) {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editService)];
        }
    }
    else{
        self.navigationController.navigationBarHidden = true;
    }
   
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = true;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"TPDiscoveryDetailListView"];
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


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"offset---scroll:%f",self.tableView.contentOffset.y);

    UIColor *color=[[UIColor blackColor] colorWithAlphaComponent:0.7];
    CGFloat offset=scrollView.contentOffset.y;
    if (offset<0) {
        self.headerNavView.backgroundColor = [color colorWithAlphaComponent:0];
    }else {
        CGFloat alpha=1-((320-offset)/320);
        CGFloat truealpha=alpha>0.7?0.7:alpha;
        self.headerNavView.backgroundColor=[color colorWithAlphaComponent:truealpha];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods - VZViewController

- (void)showModel:(TPDiscoveryDetailListModel *)model
{
    [super showModel:model];
    TPDiscoveryDetailListViewHeaderView* headerView = (TPDiscoveryDetailListViewHeaderView* )self.tableView.tableHeaderView;
    headerView.bannerView.urls = model.tripInfoItem.pics;
    headerView.moneyLabel.text = [@" " stringByAppendingString:[TPUtils money:model.tripDetailItem.tripFee WithType:model.tripInfoItem.moneyType]];
    [self.view viewWithTag:101].hidden = false;

}

- (void)showError:(NSError *)error withModel:(VZModel *)model
{
    [super showError:error withModel:model];
    
    self.tableView.tableFooterView = nil;
    
}
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
        vc.titleString = self.discoveryDetailListModel.tripInfoItem.name;
        vc.content = self.discoveryDetailListModel.tripInfoItem.desc;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([type isEqualToString:@"gotoUserIntroduce"])
    {
        [self gotoUserPage];
    }
    else if ([type isEqualToString:@"gotoComment"])
    {
        TPCommentListViewController* vc = [TPCommentListViewController new];
        vc.sid = self.sid;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if([type isEqualToString:@"gotoDatePicker"])
    {
        TPDatePickerViewController* vc = [TPDatePickerViewController new];
        vc.type = kCheckOnly;
        vc.sid = self.sid;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([type isEqualToString:@"gotoFee"])
    {
        TPDiscoveryDetailContentViewController* vc = [TPDiscoveryDetailContentViewController new];
        vc.title = @"费用说明";
        vc.titleString = @"费用说明";
        vc.content = @"1. 本费⽤为发现者的基本服务费⽤，不包含双⽅任何⻔门票、餐饮、公共交通费⽤。\n\n2. 发现者在旅程中产⽣的门票、餐饮、私家车费⽤，均由旅⾏者承担。\n\n3. 其他可能产生的费用，双方自行沟通协调。";
        [self.navigationController pushViewController:vc animated:YES];
 
    }
    else if ([type isEqualToString:@"gotoLicence"])
    {
        TPLicenceViewController* vc = [TPLicenceViewController new];
        [self.navigationController pushViewController:vc animated:YES];

    }

}

//////////////////////////////////////////////////////////// 
#pragma mark - public method 


////////////////////////////////////////////////////////////
#pragma mark - private method

- (void)editService{
    TPPSContentEditViewController *vc = [TPPSContentEditViewController new];
    vc.tripArrangementModel = _tripArrangementModel;
    vc.discoveryDetailListModel = _discoveryDetailListModel;
    [self.navigationController pushViewController:vc animated:YES];
}



-(void)gotoUserPage{
    if (self.type == kDetail) {
        // 旅行者模式，跳转到发现者详情页
        if ([self.discoveryDetailListModel.insiderProfileItem.introduceAuditStatus isEqualToString:@"1"])
        {
            TPPersonalPageDetailViewController* vc = __story(@"TPPersonalPageDetailViewController",@"tppersonaldetail");
            vc.content = self.discoveryDetailListModel.insiderProfileItem.introduce;
            [self.navigationController pushViewController:vc animated:true];
        }
        else{
            TOAST(self, @"发现者自我介绍页审核中，敬请期待~");
        }
    } else{
        // 发现者模式，跳转到个人主页
        if ([TPUser introduce]==nil)
        {
            TPPersonalPageViewController* vc = __story(@"TPPersonalPageViewController",@"tppersonal");
            vc.content = @"";
            [self.navigationController pushViewController:vc animated:true];
            
        }
        else if ([[TPUser introduceAuditStatus] isEqualToString:@"2"])
        {
            TOAST(self, @"自我介绍页审核未通过");
            TPPersonalPageDetailViewController* vc = __story(@"TPPersonalPageViewController",@"tppersonal");
            vc.content = [TPUser introduce];
            [self.navigationController pushViewController:vc animated:true];
        }
        else if ([[TPUser introduceAuditStatus] isEqualToString:@"1"])
        {
            TPPersonalPageDetailViewController* vc = __story(@"TPPersonalPageDetailViewController",@"tppersonaldetail");
            vc.content = [TPUser introduce];
            [self.navigationController pushViewController:vc animated:true];
        }
        else{
            TOAST(self, @"自我介绍页正在审核中");
        }
        
    }
    
}


/**
 * 分享到微信设置
 *
 */
////////////////////////////////////////////////////////////
#pragma mark - private callback method

-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData
{
    if (platformName == UMShareToWechatSession) {
        
        [UMSocialData defaultData].extConfig.wechatSessionData.title = self.discoveryDetailListModel.tripInfoItem.name;
        [UMSocialData defaultData].extConfig.wechatSessionData.url = [NSString stringWithFormat:@"http://www.cuitrip.com/mobile/serviceDetail.html?sid=%@",self.sid];
   
        
    }
    if (platformName == UMShareToWechatTimeline) {
        
        [UMSocialData defaultData].extConfig.wechatTimelineData.title = self.discoveryDetailListModel.tripInfoItem.name;
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = [NSString stringWithFormat:@"http://www.cuitrip.com/mobile/serviceDetail.html?sid=%@",self.sid];
    }
}


@end
 
