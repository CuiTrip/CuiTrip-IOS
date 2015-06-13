//
//  O2OStarView.m
//  O2O
//
//  Created by 任飞 on 15/4/15.
//  Copyright (c) 2015年 Alipay. All rights reserved.
//

#import "O2OStarView.h"

#define STAR_SPACE 8
#define STAR_WIDTH 50
#define STAR_HEIGHT 50

#define kStarViewTag 1000

#define FOREGROUND_STAR_IMAGE_NAME @"o2o_yellow_star.png"
#define BACKGROUND_STAR_IMAGE_NAME @"o2o_gray_star.png"
#define DEFALUT_STAR_NUMBER 5
#define ANIMATION_TIME_INTERVAL 0.2

@interface O2OStarView ()
@property(nonatomic,assign)O2OStarViewType starType;
//@property(nonatomic,assign)CGFloat starValue;
@property (nonatomic, strong) UIView *foregroundStarView;
@property (nonatomic, strong) UIView *backgroundStarView;

@property (nonatomic, assign) NSInteger numberOfStars;

@end

// 642 236  320,168

@implementation O2OStarView

- (instancetype)initWithFrame:(CGRect)frame viewType:(O2OStarViewType)type
{
    if (self = [super initWithFrame:frame])
    {
        self.starType = type;
        self.backgroundColor = [UIColor whiteColor];
        _numberOfStars = DEFALUT_STAR_NUMBER;
        [self buildDataAndUI];
    }
    return self;
}

#pragma mark - Private Methods

- (void)buildDataAndUI
{
    self.foregroundStarView = [self createStarViewWithImage:FOREGROUND_STAR_IMAGE_NAME];
    self.backgroundStarView = [self createStarViewWithImage:BACKGROUND_STAR_IMAGE_NAME];
    
    [self addSubview:self.backgroundStarView];
    [self addSubview:self.foregroundStarView];
    if (ENUM_Big == self.starType) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapRateView:)];
        tapGesture.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tapGesture];
    }
}

- (void)userTapRateView:(UITapGestureRecognizer *)gesture {
    CGPoint tapPoint = [gesture locationInView:self];
    
    NSInteger index = 0;
    for (UIView *img in [self.backgroundStarView subviews]) {
        index++;
        if(CGRectContainsPoint(img.frame, tapPoint))
            break;
    }
    
    if (index>0) {
        self.scorePercent = index;
    }
}

- (UIView *)createStarViewWithImage:(NSString *)imageName {
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    for (NSInteger i = 0; i < self.numberOfStars; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * self.bounds.size.width / self.numberOfStars, 0, self.bounds.size.width / self.numberOfStars, self.bounds.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageView];
    }
    return view;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    __weak O2OStarView *weakSelf = self;
    CGFloat animationTimeInterval = self.hasAnimation ? ANIMATION_TIME_INTERVAL : 0;
    CGFloat formattedScore = [self formatScore:weakSelf.scorePercent];
    [UIView animateWithDuration:animationTimeInterval animations:^{
        weakSelf.foregroundStarView.frame = CGRectMake(0, 0, weakSelf.bounds.size.width * formattedScore/5, weakSelf.bounds.size.height);
    }];
}

- (CGFloat)formatScore:(CGFloat)originalScore {
    NSInteger decimalScore = (NSInteger)(originalScore*10);
    CGFloat ret = originalScore;
    
    NSInteger mainScore = decimalScore/10;
    NSInteger subScore = decimalScore%10;
    
    if (subScore >= 0 && subScore <=2) {
        ret = mainScore*1.0;
    } else if (subScore > 2 && subScore <= 7) {
        ret = (mainScore*10+5)/10.0;
    } else {
        ret = (mainScore+1)*1.0;
    }
    
    return ret;
}

#pragma mark - Get and Set Methods

- (void)setScorePercent:(CGFloat)scroePercent {
    if (_scorePercent == scroePercent) {
        return;
    }
    
    if (scroePercent < 0) {
        _scorePercent = 0;
    } else if (scroePercent > 5) {
        _scorePercent = 5;
    } else {
        _scorePercent = scroePercent;
    }
    
    if ([self.delegate respondsToSelector:@selector(starRateView:scroePercentDidChange:)]) {
        [self.delegate starRateView:self scroePercentDidChange:scroePercent];
    }
    
    [self setNeedsLayout];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
