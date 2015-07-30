//
//  TPPSImageView.m
//  TP
//
//  Created by zhou li on 15/7/30.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPPSImageView.h"

@interface TPPSImageView()

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UIActivityIndicatorView *indicatorView;

@end


@implementation TPPSImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, 1.0f, 1.0f)];
        self.imageView.backgroundColor = [UIColor clearColor];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.imageView];
        
        self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.indicatorView.hidesWhenStopped = YES;
        self.indicatorView.center = self.center;
        [self addSubview:self.indicatorView];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [[UIColor colorWithWhite:1.0f alpha:0.9f] setStroke];
    UIRectFrame(rect);
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    [self.indicatorView startAnimating];
    
    double delayInSeconds = 1.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        self.imageView.image = image;
        [self.indicatorView stopAnimating];
    });
}


@end
