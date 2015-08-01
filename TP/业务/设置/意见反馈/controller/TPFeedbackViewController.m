  
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

@property(nonatomic,strong) UITextView *textView;
@property(nonatomic,strong)TPFeedbackModel *feedbackModel;

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
    
    self.view.backgroundColor = [TPTheme fillColor];
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(15.0f, 15.0f, self.view.vzWidth - 30.0f, 180.0f)];
    self.textView.font = [UIFont systemFontOfSize:13.0f];
    self.textView.layer.cornerRadius = 6;
    self.textView.text = @"您有什么建议和想法，请告诉我们哦~";
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.borderColor = [TPTheme borderColor].CGColor;
    self.textView.layer.borderWidth = 0.8;
    self.textView.returnKeyType = UIReturnKeyDefault;
    self.textView.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:self.textView];
    
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,40,30)];
    //    [rightButton setImage:[UIImage imageNamed:@"search.png"]forState:UIControlStateNormal];
    [rightButton setTitle:@"提交" forState:UIControlStateNormal];//设置button的title
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16];//title字体大小
    rightButton.titleLabel.textAlignment = NSTextAlignmentCenter;//设置title的字体居中
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//设置title在一般情况下为白色字体
    [rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];//设置title在button被选中情况下为灰色字体
    [rightButton addTarget:self action:@selector(submitFeedback:) forControlEvents:UIControlEventValueChanged];
    
    //    [rightButton addTarget:self action:@selector(searchprogram)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    //todo..
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"TPFeedbackView"];
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
    [MobClick endLogPageView:@"TPFeedbackView"];

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

- (void) viewDidLayoutSubviews {
    CGRect viewBounds = self.view.bounds;
    CGFloat topBarOffset = self.topLayoutGuide.length;
    viewBounds.origin.y = topBarOffset * -1;
    self.view.bounds = viewBounds;
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

- (void)submitFeedback
{
    TOAST(self, @"提交成功");
}

@end
 
