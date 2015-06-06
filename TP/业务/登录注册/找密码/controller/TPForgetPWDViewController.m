  
//
//  TPForgetPWDViewController.m
//  TP
//
//  Created by moxin on 2015-06-06 17:11:51 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPForgetPWDViewController.h"
 
#import "TPForgetPWDModel.h" 

@interface TPForgetPWDViewController()

 
@property(nonatomic,strong)TPForgetPWDModel *forgetPWDModel; 

@end

@implementation TPForgetPWDViewController


//////////////////////////////////////////////////////////// 
#pragma mark - setters 



//////////////////////////////////////////////////////////// 
#pragma mark - getters 

   
- (TPForgetPWDModel *)forgetPWDModel
{
    if (!_forgetPWDModel) {
        _forgetPWDModel = [TPForgetPWDModel new];
        _forgetPWDModel.key = @"__TPForgetPWDModel__";
    }
    return _forgetPWDModel;
}



////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods

- (void)loadView
{
    [super loadView];
    //todo..
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //todo..
    [self setTitle:@"找回密码"];
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
 
