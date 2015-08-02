  
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
#import "TPDDInfoItem.h"

@interface TPTripArrangementViewController()

@property(nonatomic,strong) BXImageScrollView* bannerView;
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
    self.bannerView.placeHolderImage = __image(@"default_details.jpg");
    self.bannerView.urls = self.pic?@[self.pic]:@[];
    [self.scrollView addSubview:self.bannerView];
    
    TPDDInfoItem* infoItem = [TPDDInfoItem new];
    infoItem.name = self.tripTitle;
    infoItem.desc = self.tripContent;
    infoItem.pics = self.pic?@[self.pic]:nil;
    infoItem.address = self.tripAddress;
    infoItem.score = [NSString stringWithFormat:@"%.1f",self.tripScore];
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TPDDInfoCell" owner:self options:nil];
    self.infoView = (TPDDInfoCellContainerView *)[nib objectAtIndex:0];
    self.infoView.vzOrigin = CGPointMake(0, 270);
    self.infoView.vzSize = CGSizeMake(self.view.vzWidth, 200);
    [self.infoView setItem:infoItem];
    
    __weak typeof(self)weakSelf = self;
    self.infoView.callback = ^(NSString* str,id item){
    
        TPDiscoveryDetailContentViewController* vc = [TPDiscoveryDetailContentViewController new];
        vc.title = @"旅程描述";
        vc.titleString = weakSelf.tripTitle;
        vc.content = weakSelf.tripContent;
        [weakSelf.navigationController pushViewController:vc animated:YES];

    };
    [self.scrollView addSubview:self.infoView];

    
    //footer view
    UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.vzHeight - 44-64, self.view.vzWidth, 44)];
    btn.backgroundColor = [TPTheme themeColor];
    [btn setTitle:@"安排日程" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        TPDatePickerViewController* vc = [TPDatePickerViewController new];
        vc.type = kSelection;
        vc.callback = ^(NSArray* list) {
            
            NSMutableArray* dates = [NSMutableArray new];
            for (NSDate* date in list) {
                
                long long t = [date timeIntervalSince1970]*1000;
                NSString* s = [NSString stringWithFormat:@"%lld",t];
                [dates addObject:s];
                
            }
            weakSelf.tripArrangementModel.availableDates = [dates copy];
            weakSelf.tripArrangementModel.sid = weakSelf.sid;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                SHOW_SPINNER(weakSelf);
                [weakSelf.tripArrangementModel loadWithCompletion:^(VZModel *model, NSError *error) {
                    
                    HIDE_SPINNER(weakSelf);
                    if (!error) {
                        
                        TOAST(weakSelf, @"安排成功!");
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [weakSelf.navigationController popToRootViewControllerAnimated:true];
                        });
                    }
                    else
                    {
                        TOAST_ERROR(weakSelf, error);
                    }
                    
                }];
            });
        
            
        };
        [self.navigationController pushViewController:vc animated:true];
        
    }];
    [self.view addSubview:btn];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.vzWidth, self.bannerView.vzHeight+self.infoView.vzHeight+150);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //todo..
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = true;
    [MobClick beginLogPageView:@"tripArrangement"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //todo..
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"tripArrangement"];
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
 
