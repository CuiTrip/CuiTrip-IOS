  
//
//  TPReserveDateViewController.m
//  TP
//
//  Created by moxin on 2015-06-06 22:33:27 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPReserveDateViewController.h"
 
#import "TPReserveDateModel.h" 

@interface TPReserveDateViewController()

 
@property(nonatomic,strong)TPReserveDateModel *reserveDateModel; 

@end

@implementation TPReserveDateViewController


//////////////////////////////////////////////////////////// 
#pragma mark - setters 



//////////////////////////////////////////////////////////// 
#pragma mark - getters 

   
- (TPReserveDateModel *)reserveDateModel
{
    if (!_reserveDateModel) {
        _reserveDateModel = [TPReserveDateModel new];
        _reserveDateModel.key = @"__TPReserveDateModel__";
    }
    return _reserveDateModel;
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
 
