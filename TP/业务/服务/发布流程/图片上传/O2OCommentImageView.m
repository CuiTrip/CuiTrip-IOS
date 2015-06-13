//
//  O2OCommentImageCellView.m
//  O2O
//
//  Created by Yulin Ding on 5/22/15.
//  Copyright (c) 2015 Alipay. All rights reserved.
//

#import "O2OCommentImageView.h"
#import "O2OCommentImageItem.h"

@interface O2OCommentImageView()

@property (nonatomic, strong) UIView *uploadProgressView;
@property (nonatomic, strong) UIView* uploadErrorView;
@property (nonatomic, assign) NSUInteger retryCount;

@end

@implementation O2OCommentImageView

- (void)dealloc {
    _delegate = nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onImageClick)];
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        _retryCount = 0;
        [self addGestureRecognizer:tapRecognizer];
    }
    
    return self;
}

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (void)setItem:(O2OCommentImageItem *)item {
    _item = item;
    
    self.vzOrigin = CGPointMake(item.x, item.y);
    self.vzSize = item.size;
    
    if (item.image) {
        self.image = item.image;
    } else {
        //if ([item.imageURL hasPrefix:@"http"]) {
            NSURL *imgURL = [NSURL URLWithString:item.imageURL];
            [self sd_setImageWithURL:imgURL placeholderImage:item.placeholderImage];
//        } else {
//            [self setImageCloudId:item.imageURL
//                 placeholderImage:item.placeholderImage
//                         progress:^(double percentage, long long partialBytes, long long totalBytes) {
//                             //NOTHING
//                         }
//                       completion:^(UIImage *image, NSError *error) {
//                           //NOTHING
//                       }];
//        }
    }
    
    if (item.image && item.needAutoUpload) {
        [self upload];
    }
}

- (UIView *)uploadProgressView {
    if (!_uploadProgressView) {
        _uploadProgressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.vzWidth, self.vzHeight)];;
        _uploadProgressView.backgroundColor = [UIColor blackColor];
        _uploadProgressView.alpha = 0.5;
        _uploadProgressView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:_uploadProgressView];
    }
    
    return _uploadProgressView;
}
- (UIView *)uploadErrorView {
    
    if (!_uploadErrorView)
    {
        _uploadErrorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.vzWidth, self.vzHeight)];;
        _uploadErrorView.backgroundColor = [UIColor blackColor];
        _uploadErrorView.userInteractionEnabled = true;
        _uploadErrorView.alpha = 0.5;
        _uploadErrorView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
        
        UIImageView* icon = [[UIImageView alloc]initWithFrame:CGRectMake((self.vzWidth-30)/2, (self.vzHeight-30)/2,30 ,30 )];
        icon.userInteractionEnabled = true;
        icon.image = [UIImage imageNamed:@"upload_image_failed.png"];
        [_uploadErrorView addSubview:icon];
    //[self addSubview:_uploadErrorView];
    }
    
    return _uploadErrorView;
}


- (void)uploadImage {
    if (!self.item.image || self.item.imageURL.length > 0) {
        self.item.uploadPercent = 1.0;
        self.item.isUploading = NO;
        self.item.isUploadError = NO;
    }
    
    __weak typeof(self) weakSelf = self;
    self.item.uploadPercent = 0;
    self.item.isUploading = YES;
    self.item.isUploadError = NO;
    self.uploadProgressView.vzTop = 0;
    self.uploadProgressView.vzHeight = self.vzHeight;
    
    [self.uploadErrorView removeFromSuperview];
//    [[APImageManager manager] uploadWithImage:self.image
//                                     compress:ImageCompressQualityMid
//                                     progress:^(double percentage, long long partialBytes, long long totalBytes) {
//                                         weakSelf.item.uploadPercent = percentage;
//                                         weakSelf.uploadProgressView.height = weakSelf.height * (1.0 - percentage/100);
//                                         weakSelf.uploadProgressView.top = weakSelf.height - weakSelf.uploadProgressView.height;
//                                     } completion:^(NSString *identifier, NSError *error) {
//                                         weakSelf.item.isUploading = NO;
//                                         if (!error) {
//                                             weakSelf.item.imageURL = identifier;
//                                             weakSelf.item.isUploadError = NO;
//                                             weakSelf.item.uploadPercent = 100.0;
//                                             weakSelf.uploadProgressView.height = 0;
//                                         } else {
////
////                                             weakSelf.uploadProgressView.top = 0;
////                                             weakSelf.uploadProgressView.height = weakSelf.height;
////                                             weakSelf.item.isUploadError = YES;
//                                             
//                                             //不重试,展示一个错误遮罩
//                                             [weakSelf.uploadErrorView removeFromSuperview];
//                                             [weakSelf addSubview:weakSelf.uploadErrorView];
//                                             weakSelf.uploadProgressView.height = 0;
//                                             weakSelf.item.isUploadError = true;
////                                             if (weakSelf.retryCount < weakSelf.item.maxRetryUpload) {
////                                                 weakSelf.retryCount++;
////                                                 [weakSelf uploadImage];
////                                             } else {
////                                                 weakSelf.item.isUploadError = YES;
////                                             }
//                                         }
//                                     }];
}

- (void)upload {
    if (self.item.isUploading) {
        return;
    }
    
    _retryCount = 0;
    [self uploadImage];
}

- (void)onImageClick {
    [self.delegate onImageClick:self];
}

@end
