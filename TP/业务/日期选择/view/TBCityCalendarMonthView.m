//
//  TBCityCalendarMonthView.m
//  iCoupon
//
//  Created by moxin.xt on 13-12-20.
//  Copyright (c) 2013年 Taobao.com. All rights reserved.
//

#import "TBCityCalendarMonthView.h"
#import "TBCityGraphic.h"

//点击判断
typedef struct Tag
{
    bool b;
    int date;
    float w;
    float h;
    float ori_x;
    float ori_y;
    bool hasBeenSelected;

}TagInfo;

@implementation TBCityCalendarMonthView
{
    NSInteger _selectedDate;
    NSInteger _cancelSelectedDate;
    BOOL _hasBeenLayout;
    //用来判断点击
    NSMutableArray* _list;
    //记录点击的日期
    NSMutableDictionary* _touchedTags;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization cod
        _list = [NSMutableArray new];
        _touchedTags = [NSMutableDictionary new];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)dealloc
{
    [_list removeAllObjects];
    _list     = nil;
    _delegate = nil;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();

    //draw week days
    [HEXCOLOR(0x666666)set];
    NSString* weekStr = @"";
    CGRect weekRect = CGRectZero;
    for (int i=0; i<7; i++) {
        
        weekRect = CGRectMake(i*kTPScreenWidth/7, 12, kTPScreenWidth/7, 55);
        if (i == 0) {
            weekStr  = @"日";
        }
        if (i == 1) {
            weekStr = @"一";
        }
        if (i == 2) {
            weekStr = @"二";
        }
        if (i == 3) {
            weekStr = @"三";
        }
        if (i == 4) {
            weekStr = @"四";
        }
        if (i == 5) {
            weekStr = @"五";
        }
        if (i == 6) {
            weekStr = @"六";
        }
        [weekStr drawInRect:CGRectInset(weekRect, 15, 5) withFont:[UIFont systemFontOfSize:12.0f] lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentCenter];
    }
    
    //draw red seperater line
    drawSingleLine(context,(CGPoint){0,55},(CGPoint){rect.size.width,55} ,[TPTheme themeColor], 0.5f);
    
    //draw gray seperater lines
    for (int i = 0; i<8; i++) {
        
        if (i != 1 && i != 7) {
            drawSingleLine(context, (CGPoint){0,i*55}, (CGPoint){rect.size.width,i*55}, HEXCOLOR(0xDDDDDD), 0.5f);
        }
        
        if (i == 7) {
             drawSingleLine(context, (CGPoint){0,i*55+2}, (CGPoint){rect.size.width,i*55+2}, HEXCOLOR(0xDDDDDD), 0.5f);
        }
    }
    
    //绘制日期
    int k=0;
    float origin_x = (self.firstWeekDay-1)*kTPScreenWidth/7;
    float origin_y = 55;
    NSString* str = @"";
    CGRect smallRect = CGRectZero;
    for (int i=1; i<=self.numberOfDays; i++)
    {
        
        //第一行
        if (k/7 == 0 && i<= 7-self.firstWeekDay+1) {
            smallRect = CGRectMake(origin_x+(k%7)*kTPScreenWidth/7, origin_y+(k/7)*55, kTPScreenWidth/7, 55);
            
            //换行
            if(i == 7-self.firstWeekDay+1)
                k = 6;
        }
        else
            smallRect = CGRectMake((k%7)*kTPScreenWidth/7, origin_y+(k/7)*55, kTPScreenWidth/7, 55);
        
        str = [NSString stringWithFormat:@"%d",i];
        
        //预订日
        bool bCanReserve = false;
        
        if (i == self.currentDate)
        {
        
            //红字
            [[TPTheme themeColor]set];
            str = @"今天";
            [str drawInRect:CGRectInset(smallRect, 5, 15) withFont:[UIFont systemFontOfSize:16.0f] lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentCenter];
            
        }
        
        if ( [self.availableDates containsObject:@(i)])
        {
           
            bCanReserve = true;
            
            if (_hasBeenLayout) {
                
                if ([[_touchedTags allKeys] containsObject:@(i)]) {
                    
                    NSValue* val = _touchedTags[@(i)];
                    TagInfo t ;
                    [val getValue:&t];
                    if (t.hasBeenSelected) {
                        //画背景
                        [HEXCOLOR(0xdddddd) set];
                        
                    }
                    else
                    {
                        [self.backgroundColor set];
                    }
                    UIRectFill(CGRectMake(t.ori_x+0.5, t.ori_y+0.5, t.w-1, t.h-1));
                    
                }
            }
            [[TPTheme themeColor]set];
            [str drawInRect:CGRectInset(smallRect, 5, 15) withFont:[UIFont systemFontOfSize:16.0f] lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentCenter];

        }
        else
        {
            bCanReserve = false;
            
//            //改天已被预定
//            if ([self.reservedDates containsObject:@(i)]) {
//                
//                //画背景
//                [HEXCOLOR(0xdddddd) set];
//                UIRectFill(CGRectInset(smallRect, 5, 5));
//                
//                [[UIColor whiteColor] set];
//                [str drawInRect:CGRectInset(smallRect, 5, 15) withFont:[UIFont systemFontOfSize:16.0f] lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentCenter];
//            }
//            else
//            {
                [HEXCOLOR(0xdddddd) set];
                [str drawInRect:CGRectInset(smallRect, 5, 15) withFont:[UIFont systemFontOfSize:16.0f] lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentCenter];
//            }
        }
        


        TagInfo t = {bCanReserve,i,kTPScreenWidth/7,55,smallRect.origin.x,smallRect.origin.y,0};
        NSValue* value = [[NSValue alloc]initWithBytes:&t objCType:@encode(struct Tag)];
        if (!_hasBeenLayout) {
            [_list addObject:value];
        }

        
        k++;
    }
    
    _hasBeenLayout = true;
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if (!self.canEdit) {
     
        return;
    }    
    UITouch* touch = [[event allTouches] anyObject];
    
    CGPoint locationPt = [touch locationInView:self];
   // float  touchPtX = locationPt.x;
    float  touchPtY = locationPt.y;
    
    if (touchPtY <= 55) {
        return;
    }
    else
    {
        CGRect rect;
        int mutableIndex = 0;
        NSValue* mutableValue = nil;
        for (int i=0; i<_list.count; i++) {
            
            TagInfo t;
            NSValue* val = _list[i];
            [val getValue:&t];
            rect = (CGRect){t.ori_x,t.ori_y,t.w,t.h};
            if (CGRectContainsPoint(rect,locationPt) )
            {
                if (t.b) {
                 
                    t.hasBeenSelected = !t.hasBeenSelected;
                    
                    if (t.hasBeenSelected) {
                        _selectedDate = t.date;
                        _cancelSelectedDate = -1;
                    }
                    else
                    {
                        _cancelSelectedDate = t.date;
                        _selectedDate = -1;
                    }
                    mutableIndex = i;
                    mutableValue = [[NSValue alloc]initWithBytes:&t objCType:@encode(struct Tag)];
                    _touchedTags[@(t.date)] = mutableValue;
                    [self setNeedsDisplay];
                }
                else
                {
                    //不再预订范围
                    _selectedDate = -1;
                    _cancelSelectedDate = -1;
                    
                }
                break;
            }
        }
        
        if (mutableValue) {
            [_list replaceObjectAtIndex:mutableIndex withObject:mutableValue];
        }
        
        
    }

}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    if (_selectedDate != -1) {
        
        if ([self.delegate respondsToSelector:@selector(onMonthView:DateSelected:)]) {
            [self.delegate onMonthView:self DateSelected:_selectedDate];
        }
    }
    
    if (_cancelSelectedDate != -1) {
        
        if ([self.delegate respondsToSelector:@selector(onMonthView:DateCancelSelected:)]) {
            [self.delegate onMonthView:self DateCancelSelected:_cancelSelectedDate];
        }
        
    }



}


@end
