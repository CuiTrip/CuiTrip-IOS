//
//  O2OCommentImageListView.h
//  O2O
//
//  Created by Yulin Ding on 5/22/15.
//  Copyright (c) 2015 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kO2OCommentImageAdd @"kO2OCommentImageAdd"

@class O2OCommentImageItem;
@class O2OCommentImageView;

@protocol O2OCommentImageListViewDelegate <NSObject>

@optional
- (void)onImageClick:(O2OCommentImageView *)imageView;

@end

@interface O2OCommentImageListView : UIView

@property (nonatomic, strong) NSArray *imageItems;
@property (nonatomic, strong, readonly) NSArray *imageViews;
@property (nonatomic, assign) BOOL enableAddImage;
@property (nonatomic, strong, readonly) O2OCommentImageView *addImageView;
@property (nonatomic, weak) id<O2OCommentImageListViewDelegate> delegate;
@property (nonatomic, assign) BOOL lazyLoad;
@property (nonatomic, assign) NSUInteger maxCount;
@property (nonatomic, assign) BOOL canAddImage;

- (void)appendImage:(O2OCommentImageItem *)imageItem;
- (void)removeImage:(O2OCommentImageItem *)imageItem;
- (void)removeImageAtIndex:(NSUInteger)index;
- (void)appendImages:(NSArray *)imageItems;
- (void)loadImages;
- (void)empty;

+ (CGFloat)computedHeight:(NSArray *)array maxWidth:(CGFloat)maxWidth attachments:(NSArray *)attachments;

@end
