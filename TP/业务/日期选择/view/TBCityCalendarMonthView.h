//
//  TBCityCalendarMonthView.h
//  iCoupon
//
//  Created by moxin.xt on 13-12-20.
//  Copyright (c) 2013年 Taobao.com. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol TBCityCalendarMonthViewDelegate <NSObject>

@optional
- (void)onMonthView:(UIView*)v DateSelected:(NSInteger)date;

@end
/**
 绘制某个月份的日历
 */
@interface TBCityCalendarMonthView : UIView
//delegate
@property(nonatomic,weak) id<TBCityCalendarMonthViewDelegate> delegate;

/**
 当前月份：
 formatt:xxx年xxx月
 */
@property(nonatomic,strong) NSString* title;
/**
 天数
 */
@property(nonatomic,assign) NSInteger numberOfDays;
/**
 第一天是星期几
 */
@property(nonatomic,assign) NSInteger firstWeekDay;
/**
 今天的日期
 */
@property(nonatomic,assign) NSInteger currentDate;
/**
 明天的日期
 */
@property(nonatomic,assign) NSInteger tomorrowDate;
/**
 后天
 */
@property(nonatomic,assign) NSInteger afterTomorrowDate;
/**
 预订日期
 */
@property(nonatomic,strong) NSArray* reservedDates;
@property(nonatomic,strong) NSArray* availableDate;
/**
 高亮范围
 */
@property(nonatomic,assign) NSRange highlightRange;

@end
