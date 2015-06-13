  
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
        TPPSDescriptionViewController* detail = __story(@"TPPSDescriptionViewController", @"tppsdescription");
        TPPSPicsViewController* pics = __story(@"TPPSPicsViewController", @"tppspics");
        TPPSTitleViewController* title = __story(@"TPPSTitleViewController", @"tppstitle");
        TPPSMoreViewController* more = __story(@"TPPSMoreViewController", @"tppsmore");
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
    
    if (++oldIndex < self.viewControllers.count )
        [self setSelectedIndex:oldIndex animated:YES];
}

- (void)onBack
{
    NSUInteger oldIndex = self.selectedIndex;
    
    if (oldIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
        [self setSelectedIndex:--oldIndex animated:YES];
}

- (void)onComplete
{
    [self.navigationController popViewControllerAnimated:true];
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
 
