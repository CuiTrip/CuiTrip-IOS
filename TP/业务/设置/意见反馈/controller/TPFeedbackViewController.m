  
//
//  TPFeedbackViewController.m
//  TP
//
//  Created by moxin on 2015-06-07 10:02:38 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPFeedbackViewController.h"
 
#import "TPFeedbackModel.h" 

@interface TPFeedbackViewController()

 
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property(nonatomic,strong)TPFeedbackModel *feedbackModel; 
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;

@end

@implementation TPFeedbackViewController


//////////////////////////////////////////////////////////// 
#pragma mark - setters 



//////////////////////////////////////////////////////////// 
#pragma mark - getters 

   
- (TPFeedbackModel *)feedbackModel
{
    if (!_feedbackModel) {
        _feedbackModel = [TPFeedbackModel new];
        _feedbackModel.key = @"__TPFeedbackModel__";
    }
    return _feedbackModel;
}



////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods

- (void)loadView
{
    [super loadView];
    //todo..
    [self setTitle:@"意见反馈"];
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
    [self.textView resignFirstResponder];
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

- (IBAction)onSend:(id)sender {
}
@end
 
