//
//  BXImageScrollView.m
//  BX
//
//  Created by moxin on 15/4/18.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "BXImageScrollView.h"

@interface BXImageScrollView()<UIScrollViewDelegate>

@property(nonatomic,strong) UIImageView* placeHolderImageView;
@property(nonatomic,strong) UIScrollView* scrollView;
@property(nonatomic,strong) UILabel* pageNumber;

@end

@implementation BXImageScrollView

- (void)setUrls:(NSArray *)urls
{
    _urls = urls;
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds)*urls.count,CGRectGetHeight(self.bounds));
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    int w = CGRectGetWidth(self.bounds);
    int h = CGRectGetHeight(self.bounds);
    int oriy = 0;
    for (int i=0; i<urls.count; i++) {
        
        UIImageView* imgv = [[UIImageView alloc]initWithFrame:CGRectMake(i*w, oriy, w, h)];
        imgv.contentMode = UIViewContentModeScaleAspectFill;
        imgv.clipsToBounds = true;
        [self.scrollView addSubview:imgv];
        [imgv sd_setImageWithURL:__url(urls[i]) placeholderImage:nil];

    }

    
    if (urls.count > 1) {
        self.pageNumber.hidden = NO;
        self.pageNumber.text = [NSString stringWithFormat:@"1/%lu",urls.count];
        self.scrollView.hidden = NO;
        self.placeHolderImageView.hidden = true;
    }
    else
    {
        self.pageNumber.hidden = true;
        self.scrollView.hidden = true;
        self.placeHolderImageView.hidden = NO;
    }
}

- (void)setPlaceHolderImage:(UIImage *)placeHolderImage
{
    _placeHolderImage = placeHolderImage;
    self.placeHolderImageView.image = placeHolderImage;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        self.scrollView.delegate = self;
        self.scrollView.backgroundColor = [UIColor clearColor];
        self.scrollView.pagingEnabled = true;
        self.scrollView.bounces = true;
        self.scrollView.hidden = true;
        [self addSubview:self.scrollView];
    

        self.placeHolderImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        self.placeHolderImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.placeHolderImageView.clipsToBounds = true;
        [self addSubview:self.placeHolderImageView];
        
        self.pageNumber = [TPUIKit label:[UIColor whiteColor] Font:bft(18)];
        self.pageNumber.frame = CGRectMake(frame.size.width-100, frame.size.height-30, 80, 18);
        self.pageNumber.textAlignment = NSTextAlignmentRight;
        self.pageNumber.hidden = true;
        [self addSubview:self.pageNumber];
        
        
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    
    NSString* txt = [NSString stringWithFormat:@"%d/%lu",index+1,(unsigned long)self.urls.count];
    self.pageNumber.text = txt;
    
}


@end
