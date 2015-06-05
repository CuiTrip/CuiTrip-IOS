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

}TagInfo;

@implementation TBCityCalendarMonthView
{
    NSInteger _selectedDate;
    
    //用来判断点击
    NSMutableArray* _list;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization cod
        _list = [NSMutableArray new];
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

    //draw title
    CGSize size = [self.title sizeWithFont:[UIFont systemFontOfSize:16.0f]];
    [HEXCOLOR(0x3D4245) set];
    [self.title drawInRect:CGRectMake((rect.size.width-size.width)/2, 12, size.width, size.height) withFont:[UIFont systemFontOfSize:16.0f] lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentCenter];
    
    //draw week days
    [HEXCOLOR(0x666666)set];
    NSString* weekStr = @"";
    CGRect weekRect = CGRectZero;
    for (int i=0; i<7; i++) {
        
        weekRect = CGRectMake(i*kTPScreenWidth/7, 12+size.height, kTPScreenWidth/7, 55);
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
    drawSingleLine(context,(CGPoint){0,55},(CGPoint){rect.size.width,55} ,HEXCOLOR(0xFA383A), 0.5f);
    
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
    [HEXCOLOR(0xDDDDDD) set];
    int k=0;
    float origin_x = (self.firstWeekDay-1)*kTPScreenWidth/7;
    float origin_y = 55;
    NSString* str = @"";
    CGRect smallRect = CGRectZero;
    for (int i=1; i<=self.numberOfDays; i++) {
        
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
        
        NSLog(@"%d",i);
 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //预订日
        bool bCanReserve = false;
        if ( [self.reservedDates containsObject:@(i)]) {
            bCanReserve = true;
            //draw a circle
//            drawSolidRoundCornerForRect(context, CGRectInset(smallRect, 0, 5), 22.5, HEXCOLOR(0xFA383A), nil);
            

        }
        else
        {
  
            if (i == self.currentDate) {
             
                bCanReserve = YES;
                //红字
                [HEXCOLOR(0xFA383A) set];
                str = @"今天";
                [str drawInRect:CGRectInset(smallRect, 5, 15) withFont:[UIFont systemFontOfSize:16.0f] lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentCenter];
            }
//            else if(i == self.tomorrowDate)
//            {
//                //红字
//                [HEXCOLOR(0xFA383A) set];
//                str = @"明天";
//                [str drawInRect:CGRectInset(smallRect, 5, 15) withFont:[UIFont systemFontOfSize:16.0f] lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentCenter];
//
//            }
//            else if (i == self.afterTomorrowDate)
//            {
//                //红字
//                [HEXCOLOR(0xFA383A) set];
//                str = @"后天";
//                [str drawInRect:CGRectInset(smallRect, 5, 15) withFont:[UIFont systemFontOfSize:16.0f] lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentCenter];
//
//            }
            else
            {
                //在预订范围内
                if ( i >= self.highlightRange.location && i<self.highlightRange.location+self.highlightRange.length) {
                    [HEXCOLOR(0x666666) set];
                    bCanReserve = true;
                }
                else
                {
                    [HEXCOLOR(0xDDDDDD) set];
                    bCanReserve = false;
                }
                
                [str drawInRect:CGRectInset(smallRect, 10, 15) withFont:[UIFont systemFontOfSize:16.0f] lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentCenter];
            }
        }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        //set tag info
        TagInfo t = {bCanReserve,i,kTPScreenWidth/7,55,smallRect.origin.x,smallRect.origin.y};
        NSValue* value = [[NSValue alloc]initWithBytes:&t objCType:@encode(struct Tag)];
        [_list addObject:value];
        
        k++;
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    UITouch* touch = [[event allTouches] anyObject];
    
    CGPoint locationPt = [touch locationInView:self];
   // float  touchPtX = locationPt.x;
    float  touchPtY = locationPt.y;
    
    if (touchPtY <= 55) {
        
        NSLog(@"1");
        return;
        
    }
    else
    {
        CGRect rect;
        for (int i=0; i<_list.count; i++) {
            
            NSValue* val = _list[i];
            
            TagInfo t ;
            [val getValue:&t];
            rect = (CGRect){t.ori_x,t.ori_y,t.w,t.h};
            if (CGRectContainsPoint(rect,locationPt) )
            {
                if (t.b) {
                    _selectedDate = t.date;
                }
                else
                {
                    //不再预订范围
                    _selectedDate = -1;
              
                }
               
                break;
            }
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
    else
    {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:@"该时间段不能预订" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }

}


@end
