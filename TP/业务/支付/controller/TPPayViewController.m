  
//
//  TPPayViewController.m
//  TP
//
//  Created by moxin on 2015-06-15 17:32:26 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPPayViewController.h"
 
#import "TPPayModel.h" 

@interface TPPayViewController()

 
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property(nonatomic,strong)TPPayModel *payModel; 
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@end

@implementation TPPayViewController


//////////////////////////////////////////////////////////// 
#pragma mark - setters 



//////////////////////////////////////////////////////////// 
#pragma mark - getters 

   
- (TPPayModel *)payModel
{
    if (!_payModel) {
        _payModel = [TPPayModel new];
        _payModel.key = @"__TPPayModel__";
    }
    return _payModel;
}



////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods

- (void)loadView
{
    [super loadView];
    //todo..
    [self setTitle:@"预约旅程"];
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
- (IBAction)onAction:(id)sender {
}

@end
 
