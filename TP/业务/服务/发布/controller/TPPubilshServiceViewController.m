  
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

@interface TPPubilshServiceViewController()

 
@property(nonatomic,strong)TPPubilshServiceModel *pubilshServiceModel; 

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
        self.viewControllers = @[loc,detail];
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
    
    if (oldIndex < self.viewControllers.count )
        [self setSelectedIndex:++oldIndex animated:YES];
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

- (void)selectedIndexDidChange
{
    NSString* title = @"";
    switch (self.selectedIndex) {
        case 0:
            title = @"选择地点";
            break;
        case 1:
            title = @"填写描述";
            break;
        default:
            break;
    }
    
    self.title =title;
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
 
