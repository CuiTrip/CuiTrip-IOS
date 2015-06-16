  
//
//  TPPubilshServiceViewController.m
//  TP
//
//  Created by moxin on 2015-06-11 23:01:53 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPPubilshServiceViewController.h"
#import "TPPubilshServiceModel.h" 
#import "TPPSLocationViewController.h"
#import "TPPSDescriptionViewController.h"
#import "TPPSPicsViewController.h"
#import "TPPSDescriptionViewController.h"
#import "TPPSMoreViewController.h"
#import "TPPSFeeViewController.h"
#import "TPPSTitleViewController.h"
#import "TPPSComfirmViewController.h"


@interface TPPubilshServiceViewController()

@property(nonatomic,strong)TPPubilshServiceModel *pubilshServiceModel; 

@property(nonatomic,strong) NSString* location;
@property(nonatomic,strong) NSString* desc;
@property(nonatomic,strong) NSArray* pics;
@property(nonatomic,strong) NSString* titleStr;
@property(nonatomic,strong) NSString* date;
@property(nonatomic,strong) NSString* duration;
@property(nonatomic,strong) NSString* num;
@property(nonatomic,strong) NSString* meetWay;
@property(nonatomic,strong) NSString* fee;



@end

@implementation TPPubilshServiceViewController


//////////////////////////////////////////////////////////// 
#pragma mark - setters 



//////////////////////////////////////////////////////////// 
#pragma mark - getters 

   
- (TPPubilshServiceModel *)pubilshServiceModel
{
    if (!_pubilshServiceModel) {
        _pubilshServiceModel = [TPPubilshServiceModel new];
        _pubilshServiceModel.key = @"__TPPubilshServiceModel__";
    }
    return _pubilshServiceModel;
}



////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods

- (id)init
{
    self = [super init];
    
    if (self) {
        
        //todo..
        TPPSLocationViewController* loc = __story(@"TPPSLocationViewController",@"tppslocation");
        loc.callback = ^(NSString* location,...){self.location = location;};
        
        TPPSDescriptionViewController* detail = __story(@"TPPSDescriptionViewController", @"tppsdescription");
        detail.callback = ^(NSString* desc,...){ self.desc = desc;};
        
        TPPSPicsViewController* pics = __story(@"TPPSPicsViewController", @"tppspics");
        pics.callback = ^(NSArray* pics,...){self.pics = pics;};
        
        TPPSTitleViewController* title = __story(@"TPPSTitleViewController", @"tppstitle");
        title.callback = ^(NSString* title,...){self.titleStr =title;};
        
        
        // self.callback(self.date,self.duration,self.number,self.meet,nil);
        TPPSMoreViewController* more = __story(@"TPPSMoreViewController", @"tppsmore");
        more.callback = ^(NSString* date,...){
            
            va_list ap;
            va_start(ap, date);
            
            id arg = date;
            self.date = date;
            int argIndex = 1;
            do
            {
                arg = va_arg(ap, id);
                
                NSLog(@"%@",arg);
                
                if (argIndex == 1) {
                    self.duration = arg;
                }
                
                if (argIndex == 2) {
                    self.num = arg;
                }
                
                if (argIndex == 3) {
                    self.meetWay = arg;
                }

                argIndex ++;
                
                
            }
            while (arg != nil);
        
        };
        
        TPPSFeeViewController* fee = __story(@"TPPSFeeViewController", @"tppsfee");
        TPPSComfirmViewController* confirm = __story(@"TPPSConfirmViewController", @"tppsconfirm");
        confirm.complete = ^{
        
            [self onComplete];
        
        };
        
        self.viewControllers = @[loc,detail,pics,title,more,fee,confirm];
        self.selectedIndex = 0;
    }
    return self;
}


- (void)loadView
{
    [super loadView];
    //todo..
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:0 target:self action:@selector(onNext)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(onBack)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self setTitle:@"添加发现"];
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


- (void)onNext
{
    NSUInteger oldIndex = self.selectedIndex;
    
    TPPSViewController* v = (TPPSViewController* )self.selectedViewController;
    [v onNext];
    
    if (++oldIndex < self.viewControllers.count )
        [self setSelectedIndex:oldIndex animated:YES];
}

- (void)onBack
{
    NSUInteger oldIndex = self.selectedIndex;
    
    TPPSViewController* v = (TPPSViewController* )self.selectedViewController;
    [v onBack];
    
    if (oldIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
        [self setSelectedIndex:--oldIndex animated:YES];
}


/**
 	uid(String): 发现者id
 	token(String):  登录凭证
 	name(String) : 服务名称
 	address(String) : 服务者所在地
 	desc(String) : 服务描述
 	pic(String) : 服务图片
 	price(String) : 服务费用
 	maxbuyerNum(String) : 最多接待人数
 	serviceTme(String) : 服务时长
 	bestTime(String) : 最佳时间段
 	meetingWay(String) : 见面方式
 */

- (void)onComplete
{
    SHOW_SPINNER(self);
    
    self.pubilshServiceModel.name = self.titleStr;
    self.pubilshServiceModel.address = self.location;
    self.pubilshServiceModel.desc = self.desc;
    //self.pubilshServiceModel.pic = self.pics;
    self.pubilshServiceModel.price = self.fee;
    self.pubilshServiceModel.maxbuyerNum = self.num;
    self.pubilshServiceModel.serviceTme = self.date;
    self.pubilshServiceModel.bestTime = self.duration;
    self.pubilshServiceModel.meetingWay = self.meetWay;
    
    __weak typeof(self) weakSelf = self;
    [self.pubilshServiceModel loadWithCompletion:^(VZModel *model, NSError *error) {
       
        HIDE_SPINNER(weakSelf);
        if (!error) {
            TOAST(weakSelf, @"发布成功!");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf.navigationController popViewControllerAnimated:true];
                
            });
        }
        else
            TOAST_ERROR(weakSelf, error);

    }];
}

- (void)selectedIndexDidChange
{
//    NSString* title = @"";
//    switch (self.selectedIndex) {
//        case 0:
//            title = @"选择地点";
//            break;
//        case 1:
//            title = @"填写描述";
//            break;
//        case 2:
//            title =@"";
//            break;
//        case 3:
//            title = @"";
//            break;
//        case 4:
//            title = @"";
//            break;
//        case 5:
//            title = @"";
//            break;
//        default:
//            break;
//    }
//    
//    self.title =title;
    
    if (self.selectedIndex == [self.viewControllers count] - 2) {
        //self.navigationItem.rightBarButtonItem = nil;
         self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:0 target:self action:@selector(onNext)];
    }
    else if (self.selectedIndex == [self.viewControllers count] -1)
    {
         self.navigationItem.rightBarButtonItem = nil;
    }
    else
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:0 target:self action:@selector(onNext)];
    }
}

- (void)transitionAnimationBegin
{
    CGRect rect = self.contentContainerView.bounds;
    if (self.oldSelectedIndex < self.selectedIndex)
        rect.origin.x = rect.size.width;
    else
        rect.origin.x = -rect.size.width;
    
    self.toViewController.view.frame = rect;
}
- (void)transitionAnimationProceeding
{
    CGRect rect = self.fromViewController.view.frame;
    if (self.oldSelectedIndex < self.selectedIndex)
        rect.origin.x = -rect.size.width;
    else
        rect.origin.x = rect.size.width;
    
    self.fromViewController.view.frame = rect;
    self.toViewController.view.frame = self.contentContainerView.bounds;
}
- (void)transitionAnimationEnd
{
    
}

@end
 
