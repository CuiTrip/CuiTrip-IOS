//
//  O2OCommentImageItem.h
//  O2O
//
//  Created by Yulin Ding on 5/22/15.
//  Copyright (c) 2015 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface O2OCommentImageItem : NSObject

/**
 *  图片地址
 */
@property (nonatomic, strong) NSString *imageURL;
/**
 *  图片
 */
@property (nonatomic, strong) UIImage *image;
/**
 *  尺寸
 */
@property (nonatomic, assign) CGSize size;
/**
 *  是否需要自动上传
 */
@property (nonatomic, assign) BOOL needAutoUpload;
/**
 *  默认占位图
 */
@property (nonatomic, strong) UIImage *placeholderImage;
/**
 *  是否正在上传
 */
@property (nonatomic, assign) BOOL isUploading;
/**
 *  是否上传失败
 */
@property (nonatomic, assign) BOOL isUploadError;
/**
 *  上传百分比
 */
@property (nonatomic, assign) CGFloat uploadPercent;
/**
 *  最大上传次数
 */
@property (nonatomic, assign) NSUInteger maxRetryUpload;
/**
 *  识别符
 */
@property (nonatomic, strong) NSString *identifier;
/**
 *  marginTop
 */
@property (nonatomic, assign) CGFloat marginTop;
/**
 *  marginBottom
 */
@property (nonatomic, assign) CGFloat marginBottom;
/**
 *  marginLeft
 */
@property (nonatomic, assign) CGFloat marginLeft;
/**
 *  marginRight
 */
@property (nonatomic, assign) CGFloat marginRight;
/**
 *  x
 */
@property (nonatomic, assign) CGFloat x;
/**
 *  y
 */
@property (nonatomic, assign) CGFloat y;

@property(nonatomic,strong) NSString* base64String;

@end
