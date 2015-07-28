
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

@property(nonatomic,strong) UILabel* titleLabel;
@property(nonatomic,strong) UIImageView* addressIcon;
@property(nonatomic,strong) UILabel* addressLabel;
@property(nonatomic,strong) UIImageView* providerIcon;
@property(nonatomic,strong) UILabel* providerNameLabel;
@property(nonatomic,strong) UIButton* commentBtn;
@property(nonatomic,strong) O2OStarView* starView;
@property(nonatomic,strong) UITextView *textView;
@property(nonatomic,strong) TPPublishCommentModel *publishCommentModel;
@property(nonatomic,assign) CGFloat score;
@property(nonatomic,strong) NSString* content;
@property(nonatomic,assign) float m_curKeyboardHeight;

@end

@implementation TPPublishCommentViewController


////////////////////////////////////////////////////////////
#pragma mark - setters

- (void)setTripDetailModel:(TPTripDetailModel *)tripDetailModel
{
    _tripDetailModel = tripDetailModel;
}


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
    [self setTitle:@"评价"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.titleLabel = [TPUIKit label:[UIColor colorWithRed:74 / 255.0f green:74 / 255.0f blue:74 / 255.0f alpha:1.0f] Font:[UIFont systemFontOfSize:19.0f]];
    self.titleLabel.text = self.tripDetailModel.serviceName;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.frame = CGRectMake(0.0f, 50.0f, self.view.vzWidth, 20.0f);
    [self.view addSubview:self.titleLabel];
    
    self.addressIcon = [TPUIKit imageView];
    [self.addressIcon setImage:__image(@"trip_position.png")];
    self.addressIcon.frame = CGRectMake((self.view.vzWidth - 44.0f) / 2, self.titleLabel.vzBottom + 10.0f, 14.0f, 14.0f);
    [self.view addSubview:self.addressIcon];
    
    self.addressLabel = [TPUIKit label:[UIColor colorWithRed:124 / 255.0f green:124 / 255.0f blue:124 / 255.0f alpha:1.0f] Font:[UIFont systemFontOfSize:13.0f]];
    self.addressLabel.text = self.tripDetailModel.serviceAdress;
    self.addressLabel.textAlignment = NSTextAlignmentCenter;
    self.addressLabel.frame = CGRectMake(self.addressIcon.vzRight + 5, self.addressIcon.vzTop + 2, 30.0f, 10.0f);
    [self.view addSubview:self.addressLabel];
    
    self.providerIcon = [TPUIKit roundImageView:CGSizeMake(65.0f, 65.0f) Border:[UIColor whiteColor]];
    [self.providerIcon sd_setImageWithURL:__url(self.tripDetailModel.insiderHeadPic) placeholderImage:__image(@"girl.jpg")];
    self.providerIcon.frame = CGRectMake((self.view.vzWidth - 65.0f) / 2, self.addressIcon.vzBottom + 20.0f, 65.0f, 65.0f);
    [self.view addSubview:self.providerIcon];
    
    self.providerNameLabel = [TPUIKit label:[UIColor colorWithRed:124 / 255.0f green:124 / 255.0f blue:124 / 255.0f alpha:1.0f] Font:[UIFont systemFontOfSize:15.0f]];
    self.providerNameLabel.text = self.tripDetailModel.insiderNickName;
    self.providerNameLabel.textAlignment = NSTextAlignmentCenter;
    self.providerNameLabel.frame = CGRectMake(0.0f, self.providerIcon.vzBottom + 10.0f, self.view.vzWidth, 18.0f);
    [self.view addSubview:self.providerNameLabel];
    
    
    self.starView = [[O2OStarView alloc]initWithFrame:CGRectMake((self.view.vzWidth - 190) / 2, self.providerNameLabel.vzBottom + 20.0f, 190, 32) viewType:ENUM_Big];
    self.starView.delegate = self;
    self.starView.backgroundColor = [UIColor clearColor];
    self.starView.scorePercent = 10.0f;
    [self.view addSubview:self.starView];
    
    
    UILabel *label = [TPUIKit label:[UIColor colorWithRed:124 / 255.0f green:124 / 255.0f blue:124 / 255.0f alpha:1.0f] Font:[UIFont systemFontOfSize:17.0f]];
    label.text = @"为发现者写段评价吧！";
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0.0f, self.starView.vzBottom + 30.0f, self.view.vzWidth, 20.0f);
    [self.view addSubview:label];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(20.0f, label.vzBottom + 10.0f, self.view.vzWidth - 40.0f, 120.0f)];
    self.textView.font = [UIFont systemFontOfSize:13.0f];
    self.textView.layer.cornerRadius = 6;
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.borderColor = [UIColor colorWithRed:124 / 255.0f green:124 / 255.0f blue:124 / 255.0f alpha:1.0f].CGColor;
    self.textView.layer.borderWidth = 0.8;
    self.textView.returnKeyType = UIReturnKeyDefault;
    self.textView.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:self.textView];
    
    
    self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commentBtn.backgroundColor = [UIColor colorWithRed:0 / 255.0f green:204 / 255.0f blue:221 / 255.0f alpha:1.0f];
    self.commentBtn.frame = CGRectMake(20.0f, self.textView.vzBottom + 10.0f, self.view.vzWidth - 40.0f, 44.0f);
    [self.commentBtn addTarget:self action:@selector(publishCommnet) forControlEvents:UIControlEventTouchUpInside];
    [self.commentBtn setTitle:@"提交评价" forState:UIControlStateNormal];
    [self.commentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.commentBtn];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //todo..
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    tapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGesture];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //todo..
    [self registerNotifications];
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
    [self unregisterNotifications];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    //todo..
}

- (void) viewDidLayoutSubviews {
    CGRect viewBounds = self.view.bounds;
    CGFloat topBarOffset = self.topLayoutGuide.length;
    viewBounds.origin.y = topBarOffset * -1;
    self.view.bounds = viewBounds;
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


- (void)starRateView:(O2OStarView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent
{
    self.score = newScorePercent;
}


////////////////////////////////
#pragma mark - button action

- (void)publishCommnet{
    [self.view endEditing:true];
    self.publishCommentModel.oid = self.tripDetailModel.oid;
    self.publishCommentModel.content = self.textView.text;
    self.publishCommentModel.score = [NSString stringWithFormat:@"%.1f",self.score];
    
    SHOW_SPINNER(self);
    __weak typeof(self) weakSelf = self;
    [self.publishCommentModel loadWithCompletion:^(VZModel *model, NSError *error) {
        
        HIDE_SPINNER(weakSelf);
        
        if (!error) {
            
            TOAST(weakSelf, @"发表成功!");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.navigationController popToRootViewControllerAnimated:true];
            });
        }
        else
        {
            TOAST_ERROR(weakSelf, error);
        }
    }];
}

- (void)viewTapped
{
    [self.textView resignFirstResponder];
}

////////////////////////////////////

#pragma mark - Notifications

- (void)registerNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)unregisterNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification*)notification
{
    if ([self.textView isFirstResponder] == NO) {
        return;
    }
    
    NSTimeInterval time = [[notification userInfo][UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:time delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         CGRect keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
                         self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - (keyboardRect.size.height - self.m_curKeyboardHeight), self.view.frame.size.width, self.view.frame.size.height);
                         self.m_curKeyboardHeight = keyboardRect.size.height;
                     }
                     completion:nil];
}


- (void)keyboardWillHide:(NSNotification*)notification
{
    NSLog(@"%s: %@", __FUNCTION__, notification.userInfo);
    
    //    CGRect keyboardRectEnd = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //    CGFloat animationDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    //    [UIView animateWithDuration:animationDuration animations:^{
    //
    //        //self.frame = rect;
    //        self.view.frame  = CGRectMake(0,self.view.vzTop+CGRectGetHeight(keyboardRectEnd)/2-50, self.view.vzWidth, self.view.vzHeight);
    //    }];
    
    NSTimeInterval time = [[notification userInfo][UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:time delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + self.m_curKeyboardHeight, self.view.frame.size.width, self.view.frame.size.height);
                         self.m_curKeyboardHeight = 0.0f;
                     }
                     completion:nil];
    
    
}



@end

