  
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

@property (nonatomic,strong) O2OStarView* starView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property(nonatomic,strong)TPPublishCommentModel *publishCommentModel;
@property(nonatomic,assign) CGFloat score;
@property(nonatomic,strong) NSString* content;

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
    
//    self.titleLabel.superview.layer.borderWidth = 0.5;
//    self.titleLabel.superview.layer.borderColor = [TPTheme grayColor].CGColor;
//    
    self.starView = [[O2OStarView alloc]initWithFrame:CGRectMake((self.view.vzWidth-190)/2, 20, 190, 32) viewType:ENUM_Big];
    self.starView.delegate = self;
    self.starView.backgroundColor = [UIColor clearColor];
    self.starView.scorePercent = 10.0f;
    [self.view addSubview:self.starView];
    
    [self setTitle:@"评价"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //todo..
    [self registerNotifications];
}

- (void)dealloc
{
    [self unregisterNotifications];
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
    
    [self.view endEditing:true];
    self.publishCommentModel.oid = self.oid;
    self.publishCommentModel.content = self.textView.text;
    self.publishCommentModel.score = [NSString stringWithFormat:@"%.1f",self.score];
    
    SHOW_SPINNER(self);
    __weak typeof(self) weakSelf = self;
    [self.publishCommentModel loadWithCompletion:^(VZModel *model, NSError *error) {
       
        HIDE_SPINNER(weakSelf);
        
        if (!error) {
            
            TOAST(weakSelf, @"发表成功!");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.navigationController popViewControllerAnimated:true];
            });
        }
        else
        {
            TOAST_ERROR(weakSelf, error);
        }
    }];
    
    
    
}
- (void)starRateView:(O2OStarView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent
{
    self.score = newScorePercent;
}


- (void)registerNotifications
{
    // all keyboard events
    NSLog(@"Register keyboard notifications.");
    
    // register: post: UIKeyboardWillShowNotification
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // register: UIKeyboardWillHideNotification
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification*)notification
{
    NSLog(@"%s: %@", __FUNCTION__, notification.userInfo);
    
    CGRect keyboardRectEnd = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat animDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:animDuration animations:^{
        
        self.view.frame  = CGRectMake(0, self.view.vzTop-CGRectGetHeight(keyboardRectEnd)/2-50, self.view.vzWidth, self.view.vzHeight);
    }];
}


- (void)keyboardWillHide:(NSNotification*)notification
{
    NSLog(@"%s: %@", __FUNCTION__, notification.userInfo);
    
    CGRect keyboardRectEnd = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat animationDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:animationDuration animations:^{
        
        //self.frame = rect;
        self.view.frame  = CGRectMake(0,self.view.vzTop+CGRectGetHeight(keyboardRectEnd)/2-50, self.view.vzWidth, self.view.vzHeight);
    }];
    
    
}

- (void)unregisterNotifications
{
    NSLog(@"Unregister keyboard notifications.");
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
 
