  
//
//  TPPublishCommentViewController.m
//  TP
//
//  Created by moxin on 2015-06-11 19:56:48 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPPublishCommentViewController.h"
#import "O2OStarView.h"
#import "TPPublishCommentModel.h"

@interface TPPublishCommentViewController()<O2OStarViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarIcon;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (nonatomic,strong) O2OStarView* starView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property(nonatomic,strong)TPPublishCommentModel *publishCommentModel; 

@end

@implementation TPPublishCommentViewController


//////////////////////////////////////////////////////////// 
#pragma mark - setters 



//////////////////////////////////////////////////////////// 
#pragma mark - getters 

   
- (TPPublishCommentModel *)publishCommentModel
{
    if (!_publishCommentModel) {
        _publishCommentModel = [TPPublishCommentModel new];
        _publishCommentModel.key = @"__TPPublishCommentModel__";
    }
    return _publishCommentModel;
}



////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods

- (void)loadView
{
    [super loadView];
    //todo..
    self.starView = [[O2OStarView alloc]initWithFrame:CGRectMake((self.view.vzWidth-190)/2, self.descLabel.vzBottom+10, 190, 32) viewType:ENUM_Big];
    self.starView.delegate = self;
    self.starView.backgroundColor = [UIColor clearColor];
    self.starView.scorePercent = 10.0f;
    [self.view addSubview:self.starView];
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
- (IBAction)publishCommnet:(id)sender {
}
- (void)starRateView:(O2OStarView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent
{

}

@end
 
