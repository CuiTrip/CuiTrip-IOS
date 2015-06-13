//
//  BXImageScrollView.m
//  BX
//
//  Created by moxin on 15/4/18.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "BXImageScrollView.h"

@interface BXImageScrollView()<UIScrollViewDelegate>

@property(nonatomic,strong) UIScrollView* scrollView;
@property(nonatomic,strong) UIPageControl* pageControl;

@end

@implementation BXImageScrollView

- (void)setUrls:(NSArray *)urls
{
    _urls = urls;
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds)*urls.count,CGRectGetHeight(self.bounds));
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    int w = CGRectGetWidth(self.bounds);
    int h = w;
    int oriy = ( CGRectGetHeight(self.bounds) - h ) / 2;
    for (int i=0; i<urls.count; i++) {
        
        UIImageView* imgv = [[UIImageView alloc]initWithFrame:CGRectMake(i*w, oriy, w, h)];
        imgv.contentMode = UIViewContentModeScaleAspectFill;
        
        __block UIActivityIndicatorView *activityIndicator;
        [imgv sd_setImageWithURL:[NSURL URLWithString:urls[i]] placeholderImage:nil options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            if (!activityIndicator)
            {
                [imgv addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
                activityIndicator.center = imgv.center;
                [activityIndicator startAnimating];
            }
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            [activityIndicator removeFromSuperview];
            activityIndicator = nil;
        }];
    
        
        [self.scrollView addSubview:imgv];
    }
    
    self.pageControl.numberOfPages = urls.count;
    if (self.selectedIndex) {
        
        [self.scrollView scrollRectToVisible:CGRectMake(self.selectedIndex*w, 0, w, CGRectGetHeight(self.bounds)) animated:NO];
        self.pageControl.currentPage = self.selectedIndex;
    }
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        self.scrollView.delegate = self;
        self.scrollView.backgroundColor = [UIColor blackColor];
        self.scrollView.pagingEnabled = true;
        self.scrollView.bounces = true;
        [self addSubview:self.scrollView];
    
        self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, frame.size.height - 80, frame.size.width, 30)];
        self.pageControl.numberOfPages = 1;
        self.pageControl.backgroundColor = [UIColor clearColor];
        [self addSubview:self.pageControl];
    
        
    
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSelfTapped:)]];
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    self.pageControl.currentPage = index;
    
}

- (void)onSelfTapped:(id)sender
{
    [self removeFromSuperview];
}

@end
