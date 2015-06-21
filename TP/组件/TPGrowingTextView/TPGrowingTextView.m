//
//  TPGrowingTextView.m
//  TP
//
//  Created by moxin on 15/6/15.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPGrowingTextView.h"

@interface TPGrowingTextView()<UITextViewDelegate>

@property(nonatomic,strong)UITextView* textView;
@property(nonatomic,assign)BOOL isShowingTextField;
@property(nonatomic,weak) id<TPGrowingTextView> delegate;

@end


@implementation TPGrowingTextView
{
    CGPoint _oriPt;
    CGSize  _oriSize;
}

+ (void)showInView:(UIView *)view delegate:(id<TPGrowingTextView>)delegate
{
    if (![view viewWithTag:176]) {
        
        TPGrowingTextView* inputView = [[TPGrowingTextView alloc]initWithFrame:CGRectMake(0, view.vzHeight-44, kTPScreenWidth, 44)];
        inputView.backgroundColor = [TPTheme themeColor];
        inputView.delegate = delegate;
        inputView.tag = 176;
        [view addSubview:inputView];
    }
    else
    {
        TPGrowingTextView* inputView = (TPGrowingTextView* )[view viewWithTag:176];
        [inputView.textView becomeFirstResponder];
    }

}
+ (void)hideFromView:(UIView *)view
{
    TPGrowingTextView* inputView = (TPGrowingTextView* )[view viewWithTag:176];
    if (inputView.isShowingTextField) {
        [inputView.textView resignFirstResponder];
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        CGRect bounds = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.textView = [[UITextView alloc]initWithFrame:CGRectInset(bounds, 16, 8)];
        self.textView.backgroundColor = [UIColor whiteColor];
        self.textView.layer.cornerRadius = 14.0f;
        self.textView.layer.masksToBounds= true;
        self.textView.textColor = [TPTheme blackColor];
        self.textView.delegate = self;
        self.textView.returnKeyType = UIReturnKeySend;
        self.textView.font = ft(14.0f);
        [self addSubview:self.textView];
        [self.textView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:NULL];
        [self registerNotifications];
        
    }
    return self;
}

- (void)dealloc
{
    [self.textView removeObserver:self forKeyPath:@"contentSize"];
    [self unregisterNotifications];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (self.textView.text.length == 0) {
        return;
    }
    
    CGSize sz = [change[NSKeyValueChangeNewKey] CGSizeValue];

    int delta = sz.height - 30;
    self.vzTop      = _oriPt.y - delta;
    self.vzHeight   = _oriSize.height + delta;
    self.textView.vzHeight = (_oriSize.height - 16) + delta;

}

- (void)registerNotifications
{
    // all keyboard events
    NSLog(@"Register keyboard notifications.");

    // register: post: UIKeyboardWillShowNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // register: UIKeyboardWillHideNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}



- (void)keyboardWillShow:(NSNotification*)notification
{
    CGRect keyboardRectEnd = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRectEnd = [self.superview convertRect:keyboardRectEnd fromView:[UIApplication sharedApplication].keyWindow];
    CGFloat animDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:animDuration animations:^{

        self.frame = CGRectMake(0, keyboardRectEnd.origin.y - self.vzHeight, self.vzWidth, self.vzHeight);
//        self.superview.frame  = CGRectMake(0, self.superview.vzTop-CGRectGetHeight(keyboardRectEnd), self.superview.vzWidth, self.superview.vzHeight);
    }completion:^(BOOL finished) {

        self.isShowingTextField = true;
        _oriPt = self.vzOrigin;
        _oriSize = self.vzSize;
    }];
}


- (void)keyboardWillHide:(NSNotification*)notification
{
    CGRect keyboardRectEnd = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRectEnd = [self.superview convertRect:keyboardRectEnd fromView:[UIApplication sharedApplication].keyWindow];
    CGFloat animationDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:animationDuration animations:^{

        //self.frame = CGRectMake(0, self.vzOrigin.y+keyboardRectEnd.size.height, self.vzWidth, self.vzHeight);
        self.frame = CGRectMake(0, self.superview.vzHeight-44, kTPScreenWidth, 44);
//        self.superview.frame  = CGRectMake(0,self.superview.vzTop+CGRectGetHeight(keyboardRectEnd), self.superview.vzWidth, self.superview.vzHeight);
    }completion:^(BOOL finished) {
        self.isShowingTextField = false;
        _oriPt = self.vzOrigin;
        _oriSize = self.vzSize;
    }];
}






- (void)unregisterNotifications
{
    NSLog(@"Unregister keyboard notifications.");
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
        if ([self.delegate respondsToSelector:@selector(textView:DidSendText:)]) {
            [self.delegate textView:textView DidSendText:textView.text];
        }
        textView.text = @"";
        return NO;
    }
    
    return YES;
}


@end
