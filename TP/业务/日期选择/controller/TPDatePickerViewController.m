
//
//  TPDatePickerViewController.m
//  TP
//
//  Created by moxin on 2015-06-03 23:56:44 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPDatePickerViewController.h"
#import "TPDatePickerModel.h"
#import "TBCityCalendarMonthView.h"

@interface TPDatePickerSelectionView : UIView
@property (strong, nonatomic)  UILabel *dateLabel;
@property (strong, nonatomic)  UIButton *rightBtn;
@property (strong, nonatomic)  UIButton *leftBtn;

@property(nonatomic,copy) void(^leftCallback)(void);
@property(nonatomic,copy) void(^rightCallback)(void);

@end

@implementation TPDatePickerSelectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.dateLabel = [TPUIKit label:[UIColor whiteColor] Font:ft(16)];
        self.dateLabel.vzOrigin = CGPointMake((frame.size.width-140)/2, (frame.size.height-16)/2);
        self.dateLabel.vzSize = CGSizeMake(140, 16);
        self.dateLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.dateLabel];
        
        self.leftBtn = [[UIButton alloc]initWithFrame:CGRectMake((frame.size.width-140)/2-50, (frame.size.height-30)/2, 30, 30)];
        [self.leftBtn setImage:__image(@"trip_left3.png") forState:UIControlStateNormal];
        [self.leftBtn addTarget:self action:@selector(onLeft:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.leftBtn];
        
        
        self.rightBtn = [[UIButton alloc]initWithFrame:CGRectMake((frame.size.width-140)/2+140+20, (frame.size.height-30)/2, 30, 30)];
        [self.rightBtn setImage:__image(@"trip_right3.png") forState:UIControlStateNormal];
        [self.rightBtn addTarget:self action:@selector(onRight:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.rightBtn];
        
    }
    return self;
}

- (IBAction)onLeft:(id)sender {
    
    if(self.leftCallback)
        self.leftCallback();

}

- (IBAction)onRight:(id)sender {

    if (self.rightCallback) {
        self.rightCallback();
    }

}

@end

@interface TPDatePickerViewController()<TBCityCalendarMonthViewDelegate,UIScrollViewDelegate>

@property(nonatomic,strong) NSDateComponents* currentComponent;
@property(nonatomic,strong) TPDatePickerSelectionView* selectionView;
@property(nonatomic,strong) TBCityCalendarMonthView* calendarView;
@property(nonatomic,strong) TPDatePickerModel *datePickerModel;


@end

@implementation TPDatePickerViewController


//////////////////////////////////////////////////////////// 
#pragma mark - setters 



//////////////////////////////////////////////////////////// 
#pragma mark - getters 

   
- (TPDatePickerModel *)datePickerModel
{
    if (!_datePickerModel) {
        _datePickerModel = [TPDatePickerModel new];
        _datePickerModel.key = @"__TPDatePickerModel__";
    }
    return _datePickerModel;
}



////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods

- (void)loadView
{
    [super loadView];
    
    //todo..
    self.navigationController.navigationBarHidden = NO;
    
    [self setTitle:@"选择时间"];
    
    if (!self.date) {
        self.date = [NSDate date];
    }
    
    [self.view setBackgroundColor:[TPTheme yellowColor]];
    
    self.selectionView = [[TPDatePickerSelectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.vzWidth, 40)];
    self.selectionView.dateLabel.text = [TPUtils dateFormatString:self.date];
    self.selectionView.backgroundColor = [TPTheme themeColor];
    [self.view addSubview:self.selectionView];
    
    __weak typeof(self) weakSelf = self;
    self.selectionView.rightCallback = ^{
    
        [weakSelf onNextView];
    
    };
    self.selectionView.leftCallback = ^{
        
        [weakSelf onPreviousView];
    
    };

    [self layoutCalender];

    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TPDatePickerCalenderFooterView" owner:self options:nil];
    UIView* v =(UIView *)[nib objectAtIndex:0];
    v.backgroundColor = [UIColor clearColor];
    v.vzOrigin = CGPointMake(0, self.calendarView.vzBottom);
    v.vzSize = CGSizeMake(self.view.vzWidth, 20);
    [self.view addSubview:v];
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    //todo..
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //todo..
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //todo..
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //todo..
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    //todo..
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

-(void)dealloc {
    
    //todo..
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods

- (void)showModel:(VZModel *)model
{
    //todo:
    [super showModel:model];
}

- (void)showEmpty:(VZModel *)model
{
    //todo:
    [super showEmpty:model];
}


- (void)showLoading:(VZModel*)model
{
    //todo:
    [super showLoading:model];
}

- (void)showError:(NSError *)error withModel:(VZModel*)model
{
    //todo:
    [super showError:error withModel:model];
}


////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - callback methods

- (void)onNextView
{
    if (self.currentComponent.month == 12) {
        return;
    }
    else
    {
        NSCalendar* calendar = [NSCalendar currentCalendar];
        NSDateComponents* oldComponent = self.currentComponent;
        NSUInteger firstDay = oldComponent.day;
        oldComponent.day = 1;
        oldComponent.month ++;
        NSDateComponents* newCurrentM = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSCalendarCalendarUnit fromDate:oldComponent.date];
   
        self.currentComponent = newCurrentM;
        
        TBCityCalendarMonthView* calendarView = [[TBCityCalendarMonthView alloc]initWithFrame:CGRectMake(0, self.selectionView.vzBottom, self.view.vzWidth, 380)];
        
        calendarView.canEdit = self.type == kSelection?true:false;
        calendarView.tag = 0;
        calendarView.delegate = self;
        calendarView.firstWeekDay = newCurrentM.weekday;
        calendarView.numberOfDays = [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit
                                                                       inUnit:NSMonthCalendarUnit
                                                                      forDate:newCurrentM.date].length;
        [self.calendarView removeFromSuperview];
        self.calendarView = nil;
        self.calendarView = calendarView;
        [self.view addSubview:self.calendarView];
        
        self.selectionView.dateLabel.text = [NSString stringWithFormat:@"%ld年%ld月%ld日",newCurrentM.year,newCurrentM.month,newCurrentM.day];
    }
}

- (void)onPreviousView
{

    if (self.currentComponent.month == 1) {
        return;
    }
    else
    {
        NSCalendar* calendar = [NSCalendar currentCalendar];
        NSDateComponents* oldComponent = self.currentComponent;
        oldComponent.day = 1;
        oldComponent.month --;
        NSDateComponents* newCurrentM = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSCalendarCalendarUnit fromDate:oldComponent.date];
        
        self.currentComponent = oldComponent;
        
        TBCityCalendarMonthView* calendarView = [[TBCityCalendarMonthView alloc]initWithFrame:CGRectMake(0, self.selectionView.vzBottom, self.view.vzWidth, 380)];
        
        calendarView.canEdit = self.type == kSelection?true:false;
        calendarView.tag = 0;
        calendarView.delegate = self;
        calendarView.firstWeekDay = newCurrentM.weekday;
        calendarView.numberOfDays = [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit
                                                                       inUnit:NSMonthCalendarUnit
                                                                      forDate:newCurrentM.date].length;
        [self.calendarView removeFromSuperview];
        self.calendarView = nil;
        self.calendarView = calendarView;
        [self.view addSubview:self.calendarView];
        
        self.selectionView.dateLabel.text = [NSString stringWithFormat:@"%ld年%ld月%ld日",newCurrentM.year,newCurrentM.month,newCurrentM.day];
    }
}

- (void)onMonthView:(UIView*)v DateSelected:(NSInteger)date
{
    
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override private methods


- (void)layoutCalender
{
    self.date = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    calendar.firstWeekday = 1;
    calendar.minimumDaysInFirstWeek = 7;
    NSDateComponents* oldComponent = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSCalendarCalendarUnit fromDate:self.date];
  
    oldComponent.day = 1;
    NSDateComponents* newCurrentM = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSCalendarCalendarUnit fromDate:oldComponent.date];
    self.currentComponent = newCurrentM;
    
    TBCityCalendarMonthView* calendarView = [[TBCityCalendarMonthView alloc]initWithFrame:CGRectMake(0, self.selectionView.vzBottom, self.view.vzWidth, 380)];
    
    calendarView.canEdit = self.type == kSelection?true:false;
    calendarView.tag = 0;
    calendarView.delegate = self;
    calendarView.firstWeekDay = newCurrentM.weekday;
    calendarView.numberOfDays = [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit
                                                                    inUnit:NSMonthCalendarUnit
                                                                   forDate:newCurrentM.date].length;

    calendarView.availableDates =self.availableDates;
    calendarView.reservedDates = self.reservedDates;
    self.calendarView = calendarView;
    [self.view addSubview:calendarView];
}





@end
 
