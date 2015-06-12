  
//
//  TPTripDetailViewController.m
//  TP
//
//  Created by moxin on 2015-06-07 21:28:19 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPTripDetailViewController.h"
#import "TPPublishCommentViewController.h"
#import "TPTripDetailModel.h" 

@interface TPTripDetailViewController()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tripDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tripNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *tripFeeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tripStatusLabel;
@property (weak, nonatomic) IBOutlet UIButton *actionBtn;
@property(nonatomic,strong)TPTripDetailModel *tripDetailModel; 

@end

@implementation TPTripDetailViewController


//////////////////////////////////////////////////////////// 
#pragma mark - setters 



//////////////////////////////////////////////////////////// 
#pragma mark - getters 

   
- (TPTripDetailModel *)tripDetailModel
{
    if (!_tripDetailModel) {
        _tripDetailModel = [TPTripDetailModel new];
        _tripDetailModel.key = @"__TPTripDetailModel__";
    }
    return _tripDetailModel;
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
- (IBAction)onAction:(id)sender {
    
    TPPublishCommentViewController* vc = [[UIStoryboard storyboardWithName:@"TPPublishCommentViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"tppublishcomment"];
    [self.navigationController pushViewController:vc animated:true];
    
}

@end
 
