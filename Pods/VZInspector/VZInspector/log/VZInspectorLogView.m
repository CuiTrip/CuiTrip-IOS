//
//  VZInspectorLogView.m
//  VZInspector
//
//  Created by moxin.xt on 14-11-26.
//  Copyright (c) 2014年 VizLab. All rights reserved.
//

#include <QuartzCore/QuartzCore.h>
#import "VZInspectorLogView.h"
#import "VZLogInspector.h"


@interface VZInspectorLogView()

@property(nonatomic,strong)UITextView* textView;
@property(nonatomic,strong)UIButton* refreshBtn;
@property(nonatomic,strong)UIActivityIndicatorView* indicator;
@end

@implementation VZInspectorLogView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 10, CGRectGetWidth(frame)-20, CGRectGetHeight(frame)-20)];
        _textView.font = [UIFont fontWithName:@"Courier-Bold" size:12];
        _textView.textColor = [UIColor orangeColor];
        _textView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
        _textView.indicatorStyle = 0;
        _textView.editable = NO;
        _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _textView.layer.borderColor = [UIColor colorWithWhite:0.5f alpha:1.0f].CGColor;
        _textView.layer.borderWidth = 2.0f;
        [self addSubview:_textView];
        
        
        _refreshBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(_textView.bounds) - 54, CGRectGetHeight(_textView.bounds)-54, 44, 44)];
        _refreshBtn.layer.cornerRadius = 22;
        _refreshBtn.layer.masksToBounds = true;
        _refreshBtn.layer.borderColor = [UIColor grayColor].CGColor;
        _refreshBtn.layer.borderWidth = 2.0f;
        [_refreshBtn setTitle:@"R" forState:UIControlStateNormal];
        [_refreshBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_refreshBtn addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_refreshBtn];
        
        
        _indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _indicator.color = [UIColor grayColor];
        _indicator.frame = CGRectMake((_textView.frame.size.width-20)/2, (_textView.frame.size.height - 20)/2, 20, 20);
        _indicator.hidesWhenStopped=true;
        [self addSubview:_indicator];
        
        [self onRefresh];
        

    }
    return self;
}


- (void)onRefresh
{
    [self.indicator startAnimating];
   // self.textView.text = @"";
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSAttributedString* str = [VZLogInspector logsString];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.textView.attributedText = str;
            [self.indicator stopAnimating];
        });
    });
    
}




@end
