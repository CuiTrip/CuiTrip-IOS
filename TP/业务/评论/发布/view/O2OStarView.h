//
//  O2OStarView.h
//  O2O
//
//  Created by 任飞 on 15/4/15.
//  Copyright (c) 2015年 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ENUM_Big,
    ENUM_Small,
    ENUM_Head
} O2OStarViewType;

@class O2OStarView;

@protocol O2OStarViewDelegate <NSObject>
@optional
- (void)starRateView:(O2OStarView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent;
@end


@interface O2OStarView : UIView

- (instancetype)initWithFrame:(CGRect)frame viewType:(O2OStarViewType)type;

@property (nonatomic, assign) CGFloat scorePercent;//得分值，范围为0--5，默认为0
@property (nonatomic, assign) BOOL hasAnimation;//是否允许动画，默认为NO
@property (nonatomic, assign) BOOL allowIncompleteStar;//评分时是否允许不是整星，默认为NO
@property (nonatomic, weak) id<O2OStarViewDelegate>delegate;

@end
