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

@property(nonatomic,assign) BOOL canEdit;
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
 可预订日期, nil => all
 */
@property(nonatomic,strong) NSArray* availableDates;

@end
