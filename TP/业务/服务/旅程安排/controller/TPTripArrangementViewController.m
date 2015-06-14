  
//
//  TPTripArrangementViewController.m
//  TP
//
//  Created by moxin on 2015-06-14 15:23:45 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPTripArrangementViewController.h"
#import "BXImageScrollView.h"
#import "TPTripArrangementModel.h"
#import "TPDDInfoCellContainerView.h"
#import "TPDatePickerViewController.h"
#import "TPDiscoveryDetailContentViewController.h"
@interface TPTripArrangementViewController()

@property(nonatomic,strong)BXImageScrollView* bannerView;
@property(nonatomic,strong) UIScrollView* scrollView;
@property(nonatomic,strong) TPDDInfoCellContainerView* infoView;
@property(nonatomic,strong) TPTripArrangementModel *tripArrangementModel; 

@end

@implementation TPTripArrangementViewController


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



////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods

- (void)loadView
{
    [super loadView];
    //todo..
    [self setTitle:@"安排日程"];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.vzWidth, self.view.vzHeight)];
    [self.view addSubview:self.scrollView];
    
    
    self.bannerView = [[BXImageScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.vzWidth,270)];
    self.bannerView.placeHolderImage = __image(@"mazu.png");
    [self.scrollView addSubview:self.bannerView];
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TPDDInfoCell" owner:self options:nil];
    self.infoView = (TPDDInfoCellContainerView *)[nib objectAtIndex:0];
    self.infoView.vzOrigin = CGPointMake(0, 270);
    self.infoView.vzSize = CGSizeMake(self.view.vzWidth, self.view.vzWidth*0.75);
    
    __weak typeof(self)weakSelf = self;
    self.infoView.callback = ^(NSString* str,id item){
    
        TPDiscoveryDetailContentViewController* vc = [TPDiscoveryDetailContentViewController new];
        vc.title = @"旅程描述";
        vc.titleString = @"台湾妈祖神庙参观";
        vc.content = @"通常使用 NSURLConnection 时，你会传入一个 Delegate，当调用了 [connection start] 后，这个 Delegate 就会不停收到事件回调。实际上，start 这个函数的内部会会获取 CurrentRunLoop，然后在其中的 DefaultMode 添加了4个 Source0 (即需要手动触发的Source)。CFMultiplexerSource 是负责各种 Delegate 回调的，CFHTTPCookieStorage 是处理各种 Cookie 的\n\n当开始网络传输时，我们可以看到 NSURLConnection 创建了两个新线程：com.apple.NSURLConnectionLoader 和 com.apple.CFSocket.private。其中 CFSocket 线程是处理底层 socket 连接的。NSURLConnectionLoader 这个线程内部会使用 RunLoop 来接收底层 socket 的事件，并通过之前添加的 Source0 通知到上层的 Delegate。";
        [weakSelf.navigationController pushViewController:vc animated:YES];

    };
    [self.scrollView addSubview:self.infoView];

    
    //footer view
    UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(0, self.infoView.vzBottom, self.view.vzWidth, 44)];
    btn.backgroundColor = [TPTheme themeColor];
    [btn setTitle:@"安排日程" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        TPDatePickerViewController* vc = [TPDatePickerViewController new];
        [self.navigationController pushViewController:vc animated:true];
        
    }];
    [self.scrollView addSubview:btn];
    
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.vzWidth, self.bannerView.vzHeight+self.infoView.vzHeight+44+64);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //todo..
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods

- (void)showModel:(VZModel *)model
{
    //todo:
    [super showModel:model];
}

- (void)showEmpty:(VZModel *)model
{
    //todo:
    [super showEmpty:model];
}


- (void)showLoading:(VZModel*)model
{
    //todo:
    [super showLoading:model];
}

- (void)showError:(NSError *)error withModel:(VZModel*)model
{
    //todo:
    [super showError:error withModel:model];
}

@end
 
