//
//  TPGrowingTextView.h
//  TP
//
//  Created by moxin on 15/6/15.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TPGrowingTextView <NSObject>

- (void)textView:(UITextView* )view DidSendText:(NSString* )text;
- (void)textViewDidShow;
- (void)textViewDidHid;
@end

@interface TPGrowingTextView : UIView

+ (void)showInView:(UIView* )view delegate:(id<TPGrowingTextView>)delegate;
+ (void)hideFromView:(UIView* )view;

@end
