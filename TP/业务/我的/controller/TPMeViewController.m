  
//
//  TPMeViewController.m
//  TP
//
//  Created by moxin on 2015-06-01 19:41:46 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPMeViewController.h"
 
#import "TPMeModel.h" 

@interface TPMeViewController()

 
@property(nonatomic,strong)TPMeModel *meModel; 

@end

@implementation TPMeViewController


//////////////////////////////////////////////////////////// 
#pragma mark - setters 



//////////////////////////////////////////////////////////// 
#pragma mark - getters 

   
- (TPMeModel *)meModel
{
    if (!_meModel) {
        _meModel = [TPMeModel new];
        _meModel.key = @"__TPMeModel__";
    }
    return _meModel;
}



////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods

- (void)loadView
{
    [super loadView];
    //todo..
    [self setTitle:@"我的"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //todo..
    
    void(^loadModel)(void) = ^{
        
    
    
    
    };
    
    if (![TPUser isLogined]) {
        
        [TPLoginManager showLoginViewControllerWithCompletion:^{
           
            loadModel();
            
        }];
    }
    
    loadModel();
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
 
