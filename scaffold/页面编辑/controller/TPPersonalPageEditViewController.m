  
//
//  TPPersonalPageEditViewController.m
//  TP
//
//  Created by wifigo on 2015-07-28 18:16:49 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPPersonalPageEditViewController.h"
 
#import "TPPersonalPageEditModel.h" 

@interface TPPersonalPageEditViewController()

 
@property(nonatomic,strong)TPPersonalPageEditModel *personalPageEditModel; 

@end

@implementation TPPersonalPageEditViewController


//////////////////////////////////////////////////////////// 
#pragma mark - setters 



//////////////////////////////////////////////////////////// 
#pragma mark - getters 

   
- (TPPersonalPageEditModel *)personalPageEditModel
{
    if (!_personalPageEditModel) {
        _personalPageEditModel = [TPPersonalPageEditModel new];
        _personalPageEditModel.key = @"__TPPersonalPageEditModel__";
    }
    return _personalPageEditModel;
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
 
