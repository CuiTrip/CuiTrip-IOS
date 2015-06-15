//
//  TPGrowingTextView.m
//  TP
//
//  Created by moxin on 15/6/15.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPGrowingTextView.h"

@interface TPGrowingTextView()

@property(nonatomic,strong)UITextView* textView;

@end


@implementation TPGrowingTextView
{
    CGPoint _oriPt;
    CGSize  _oriSize;
}

+ (void)showInView:(UIView* )view
{
    if (![view viewWithTag:176]) {
        
        TPGrowingTextView* inputView = [[TPGrowingTextView alloc]initWithFrame:CGRectMake(0, view.vzHeight-108, kTPScreenWidth, 44)];
        inputView.backgroundColor = [TPTheme themeColor];
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
    [inputView.textView resignFirstResponder];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _oriPt = frame.origin;
        _oriSize = frame.size;
        
        CGRect bounds = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.textView = [[UITextView alloc]initWithFrame:CGRectInset(bounds, 16, 8)];
        self.textView.backgroundColor = [UIColor whiteColor];
        self.textView.layer.cornerRadius = 14.0f;
        self.textView.layer.masksToBounds= true;
        self.textView.textColor = [TPTheme blackColor];
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
    NSLog(@"%@",change);
    
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
    NSLog(@"%s: %@", __FUNCTION__, notification.userInfo);
    
    CGRect keyboardRectEnd = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSLog(@"keyboardRectEnd: %@", NSStringFromCGRect(keyboardRectEnd));
    keyboardRectEnd = [self.superview convertRect:keyboardRectEnd fromView:[UIApplication sharedApplication].keyWindow];
    NSLog(@"keyboardRectEnd: %@", NSStringFromCGRect(keyboardRectEnd));
    CGFloat animDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:animDuration animations:^{
        
        //CGRect rect = CGRectMake(0, keyboardRectEnd.origin.y - self.vzHeight, self.vzWidth ,self.vzHeight );
        //self.frame = rect;
        self.superview.frame  = CGRectMake(0, self.superview.vzTop-CGRectGetHeight(keyboardRectEnd), self.superview.vzWidth, self.superview.vzHeight);
    }];
}


- (void)keyboardWillHide:(NSNotification*)notification
{
    NSLog(@"%s: %@", __FUNCTION__, notification.userInfo);
    
    CGRect keyboardRectEnd = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSLog(@"keyboardRectEnd: %@", NSStringFromCGRect(keyboardRectEnd));
    keyboardRectEnd = [self.superview convertRect:keyboardRectEnd fromView:[UIApplication sharedApplication].keyWindow];
    CGFloat animationDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:animationDuration animations:^{
        
        //self.frame = rect;
        self.superview.frame  = CGRectMake(0,self.superview.vzTop+CGRectGetHeight(keyboardRectEnd), self.superview.vzWidth, self.superview.vzHeight);
    }];
    
    
}

- (void)unregisterNotifications
{
    NSLog(@"Unregister keyboard notifications.");
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
