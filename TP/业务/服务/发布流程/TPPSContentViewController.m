//
//  TPPSContentViewController.m
//  TP
//
//  Created by zhou li on 15/7/30.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPPSContentViewController.h"
#import "TPPSAccessoryView.h"

@interface TPPSContentViewController()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) SETextView *textView;
@property (nonatomic, strong) TPPSAccessoryView *inputAccessoryView;

@end

@implementation TPPSContentViewController

////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods

- (void)loadView
{
    [super loadView];
    [self setTitle:@"旅程"];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.vzWidth, self.view.vzHeight)];
    [self.view addSubview:self.scrollView];
    
    self.inputAccessoryView = [[TPPSAccessoryView alloc] initWithFrame : CGRectMake(0.0f, 0.0f, self.view.vzWidth, 44.0f)];
    self.inputAccessoryView.keyDownBtn.target = self;
    self.inputAccessoryView.keyDownBtn.action = @selector(hideKeyboard);
    self.inputAccessoryView.addImageBtn.target = self;
    self.inputAccessoryView.addImageBtn.action = @selector(showImagePicker);
    
    self.textView = [[SETextView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.vzWidth, self.view.vzHeight)];
    self.textView.inputAccessoryView = self.inputAccessoryView;
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.editable = YES;
    self.textView.lineSpacing = 8.0f;
    NSString *initialText = @"关于您自己的介绍，可以包含您的个人生活照。这是您的主页，所以要很认真的编写哦！";
    self.textView.text = initialText;
    self.textView.font = [UIFont systemFontOfSize:15.0f];
    [self.scrollView addSubview:self.textView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = true;
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


///////////////////////
#pragma mark - btn action 

- (void)hideKeyboard
{
    [self.textView resignFirstResponder];
}

- (void)showImagePicker
{
    
}


//////////////////////
#pragma mark - notify

- (void)keyboardWillShow:(NSNotification *)notification
{
    self.scrollView.scrollEnabled = NO;
    
    CGRect keyboardBounds;
    [notification.userInfo[UIKeyboardFrameEndUserInfoKey] getValue:&keyboardBounds];
    
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
    CGRect containerFrame = self.scrollView.frame;
    containerFrame.size.height = CGRectGetHeight(self.view.bounds) - CGRectGetHeight(keyboardBounds);
    
    self.scrollView.frame = containerFrame;
    
    self.scrollView.scrollEnabled = YES;
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.scrollView.scrollEnabled = NO;
    
    CGRect keyboardBounds;
    [notification.userInfo[UIKeyboardFrameEndUserInfoKey] getValue:&keyboardBounds];
    
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
    CGRect containerFrame = self.scrollView.frame;
    containerFrame.size.height = CGRectGetHeight(self.view.bounds);
    
    self.scrollView.frame = containerFrame;
    
    self.scrollView.scrollEnabled = YES;
}

- (void)updateLayout
{
    CGSize containerSize = self.scrollView.frame.size;
    CGSize contentSize = [self.textView sizeThatFits:containerSize];
    
    CGRect frame = self.textView.frame;
    frame.size.height = MAX(contentSize.height, containerSize.height);
    
    self.textView.frame = frame;
    self.scrollView.contentSize = frame.size;
    
    [self.scrollView scrollRectToVisible:self.textView.caretRect animated:YES];
}





@end

