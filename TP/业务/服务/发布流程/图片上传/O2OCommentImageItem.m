//
//  O2OCommentImageItem.m
//  O2O
//
//  Created by Yulin Ding on 5/22/15.
//  Copyright (c) 2015 Alipay. All rights reserved.
//

#import "O2OCommentImageItem.h"

@implementation O2OCommentImageItem

- (instancetype)init {
    if (self = [super init]) {
        _needAutoUpload = NO;
        _size = CGSizeMake(100, 100);
        _placeholderImage = [UIImage imageNamed:@"imgdefault"];
        _marginTop = 0;
        _marginBottom = 10;
        _marginLeft = 0;
        _marginRight = 10;
        _maxRetryUpload = 3;
    }
    
    return self;
}

@end
