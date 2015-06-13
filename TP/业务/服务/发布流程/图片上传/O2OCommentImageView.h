//
//  O2OCommentImageCellView.h
//  O2O
//
//  Created by Yulin Ding on 5/22/15.
//  Copyright (c) 2015 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class O2OCommentImageItem;
@class O2OCommentImageView;

@protocol O2OCommentImageViewDelegate <NSObject>

- (void)onImageClick:(O2OCommentImageView *)imageView;

@optional
- (void)onLongpress:(O2OCommentImageView *)imageView;

@end

@interface O2OCommentImageView : UIImageView

@property (nonatomic, strong) O2OCommentImageItem *item;
@property (nonatomic, weak) id<O2OCommentImageViewDelegate> delegate;

- (void)upload;

@end
