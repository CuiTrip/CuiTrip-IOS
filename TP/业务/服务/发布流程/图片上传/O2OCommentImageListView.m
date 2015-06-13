//
//  O2OCommentImageListView.m
//  O2O
//
//  Created by Yulin Ding on 5/22/15.
//  Copyright (c) 2015 Alipay. All rights reserved.
//

#import "O2OCommentImageListView.h"
#import "O2OCommentImageItem.h"
#import "O2OCommentImageView.h"

@interface O2OCommentImageListView() <O2OCommentImageViewDelegate>

@property (nonatomic, strong) NSArray *imageViews;
@property (nonatomic, strong) O2OCommentImageItem *addImageItem;
@property (nonatomic, strong) O2OCommentImageView *addImageView;
@property (nonatomic, assign) BOOL isAddIconShown;

@end

@implementation O2OCommentImageListView

- (void)dealloc {
    _delegate = nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _maxCount = 9;
        self.clipsToBounds = YES;
    }
    return self;
}
- (void)setImageItems:(NSArray *)imageItems {
    _imageItems = imageItems;
    
    NSMutableArray *imageViews = _imageViews ? [_imageViews mutableCopy] : [@[] mutableCopy];
    [imageViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        O2OCommentImageView *imageView = (O2OCommentImageView *)obj;
        [imageView removeFromSuperview];
    }];
    [imageViews removeAllObjects];
    
    [imageItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        O2OCommentImageView *imageView = [[O2OCommentImageView alloc] initWithFrame:CGRectZero];
        imageView.item = (O2OCommentImageItem *)obj;
        imageView.delegate = self;
        [imageViews addObject:imageView];
        [self addSubview:imageView];
    }];
    
    _imageViews = [imageViews copy];
//    [self layout];
    self.enableAddImage = self.enableAddImage; //触发显示隐藏添加图片设置
}

- (void)layout {
    CGFloat height = [self.class computedHeight:_imageItems maxWidth:self.vzWidth attachments:nil];
    [_imageViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        O2OCommentImageView *imageView = (O2OCommentImageView *)obj;
        imageView.vzOrigin = CGPointMake(imageView.item.x, imageView.item.y);
    }];
    self.vzHeight = height;
}

- (O2OCommentImageItem *)addImageItem {
    if (!_addImageItem) {
        _addImageItem = [[O2OCommentImageItem alloc] init];
        _addImageItem.image = [UIImage imageNamed:@"add_comment_image.png"];
        _addImageItem.size = CGSizeMake(100, 100);
        _addImageItem.identifier = kO2OCommentImageAdd;
    }
    
    return _addImageItem;
}

- (O2OCommentImageView *)addImageView {
    if (!_addImageView) {
        _addImageView = [[O2OCommentImageView alloc] initWithFrame:CGRectZero];
        _addImageView.item = self.addImageItem;
        _addImageView.delegate = self;
    }
    
    return _addImageView;
}

- (void)appendImage:(O2OCommentImageItem *)imageItem {
    if (!imageItem) {
        return;
    }
    
    [self appendImages:@[imageItem]];
}

- (void)appendImages:(NSArray *)imageItems {
    if ([imageItems count] == 0) {
        return;
    }
    
    if (!_imageItems) {
        _imageItems = @[];
    }
    
    if (!_imageViews) {
        _imageViews = @[];
    }
    
    NSMutableArray *imageList = [_imageItems mutableCopy];
    NSMutableArray *imageViews = [_imageViews mutableCopy];
    NSUInteger maxCount = self.maxCount;
    
    if (_enableAddImage) {
        maxCount += 1;
    }
    
    [imageItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([_imageItems count] >= maxCount) {
            *stop = YES;
            return;
        }
        
        O2OCommentImageView *imageView = [[O2OCommentImageView alloc] initWithFrame:CGRectZero];
        imageView.item = (O2OCommentImageItem *)obj;
        imageView.delegate = self;
        
        if (_enableAddImage) {
            if ([imageList count] >= 1) {
                [imageList insertObject:obj atIndex:[imageList count]-1];
                [imageViews insertObject:imageView atIndex:[imageViews count]-1];
            } else {
                [imageList addObject:obj];
                [imageViews addObject:imageView];
            }
        } else {
            [imageList addObject:obj];
            [imageViews addObject:imageView];
        }
        
        [self addSubview:imageView];
    }];
    
    _imageViews = [imageViews copy];
    _imageItems = [imageList copy];
    
    self.enableAddImage = self.enableAddImage;
}

- (void)removeImage:(O2OCommentImageItem *)imageItem {
    if (!_imageItems) {
        _imageItems = @[];
    }
    
    if (!_imageViews) {
        _imageViews = @[];
    }
    
    NSMutableArray *imageItems = [_imageItems mutableCopy];
    NSMutableArray *imageViews = [_imageViews mutableCopy];
    
    NSUInteger index = [imageItems indexOfObject:imageItem];
    if (index != NSNotFound) {
        [imageItems removeObject:imageItem];
        O2OCommentImageView *imageView = [imageViews objectAtIndex:index];
        [imageViews removeObject:imageView];
        [imageView removeFromSuperview];
    }
    
    _imageViews = [imageViews copy];
    _imageItems = [imageItems copy];
    
    self.enableAddImage = self.enableAddImage;
}

- (void)removeImageAtIndex:(NSUInteger)index {
    if (index >= [_imageItems count]) {
        return;
    }
    
    O2OCommentImageItem *imageItem = [_imageItems objectAtIndex:index];
    [self removeImage:imageItem];
}

- (void)onImageClick:(O2OCommentImageView *)imageView {
    [self.delegate onImageClick:imageView];
}

- (void)setEnableAddImage:(BOOL)enableAddImage {
    _enableAddImage = enableAddImage;
    
    if (!_imageItems) {
        _imageItems = @[];
    }
    
    if (!_imageViews) {
        _imageViews = @[];
    }
    
    NSMutableArray *imageItems = [_imageItems mutableCopy];
    NSMutableArray *imageViews = [_imageViews mutableCopy];
    if (_enableAddImage) {
        if ([imageItems indexOfObject:self.addImageItem] == NSNotFound) {
            if ([imageItems count] < self.maxCount) {
                [imageItems addObject:self.addImageItem];
                [imageViews addObject:self.addImageView];
                _imageViews = [imageViews copy];
                _imageItems = [imageItems copy];
                [self addSubview:self.addImageView];
                _isAddIconShown = YES;
            }
        } else if ([imageItems count] >= self.maxCount + 1) {
            [imageItems removeObject:self.addImageItem];
            [imageViews removeObject:self.addImageView];
            [self.addImageView removeFromSuperview];
            _isAddIconShown = NO;
        }
        
    } else if ([imageItems indexOfObject:self.addImageItem] != NSNotFound) {
        [imageItems removeObject:self.addImageItem];
        [imageViews removeObject:self.addImageView];
        [self.addImageView removeFromSuperview];
        _isAddIconShown = NO;
    }
    
    _imageViews = [imageViews copy];
    _imageItems = [imageItems copy];
    
    [self layout];
}

+ (CGFloat)computedHeight:(NSArray *)array
                 maxWidth:(CGFloat)maxWidth
              attachments:(NSArray *)attachment {
    CGFloat containerWidth = maxWidth;
    __block CGFloat remainWidth = maxWidth;
    __block CGFloat maxY = 0;
    __block CGFloat x = 0;
    __block CGFloat y = 0;
    
    NSMutableArray *imageItems = [array mutableCopy];
    
    if ([attachment count] > 0) {
        [imageItems addObjectsFromArray:attachment];
    }
    
    [imageItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        O2OCommentImageItem *imageItem = (O2OCommentImageItem *)obj;
        
        if (imageItem.size.width <= remainWidth) {
            x += imageItem.marginLeft;
            maxY = MAX(imageItem.size.height + imageItem.marginTop + imageItem.marginBottom, maxY);
        } else {
            x = imageItem.marginLeft;
            y = maxY;
            
            maxY += imageItem.size.height + imageItem.marginTop +imageItem.marginBottom;
            remainWidth = containerWidth;
        }
        
        imageItem.x = x;
        imageItem.y = y;
        
        x += imageItem.size.width + imageItem.marginRight;
        remainWidth = remainWidth - imageItem.size.width - imageItem.marginLeft - imageItem.marginRight;
        
    }];
    
    return maxY;
}

- (void)loadImages {
    //TODO
}

- (BOOL)canAddImage {
    BOOL ret = YES;
    
    if (_enableAddImage) {
        ret = _isAddIconShown;
    } else {
        ret = [_imageItems count] < self.maxCount;
    }
    return ret;
}

- (void)empty {
    _imageItems = nil;
    [_imageViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        O2OCommentImageView *imageView = (O2OCommentImageView *)obj;
        [imageView removeFromSuperview];
    }];
    _imageViews = nil;
}

@end
