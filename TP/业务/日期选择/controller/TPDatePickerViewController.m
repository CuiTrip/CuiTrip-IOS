  
//
//  TPDatePickerViewController.m
//  TP
//
//  Created by moxin on 2015-06-03 23:56:44 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPDatePickerViewController.h"
#import "TPDatePickerModel.h" 
//#import <FSCalendar/FSCalendar.h>
#import "TBCityCalendarMonthView.h"


@interface TPDatePickerViewController()

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
    self.date = [NSDate date];
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    calendar.firstWeekday = 1;
    calendar.minimumDaysInFirstWeek = 7;
    NSDateComponents* currentM = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSCalendarCalendarUnit fromDate:self.date];
    
    NSUInteger firstDay = currentM.day;
    currentM.day = 1;
    currentM = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSCalendarCalendarUnit fromDate:currentM.date];

    self.calendarView = [[TBCityCalendarMonthView alloc]initWithFrame:CGRectMake(0, 0, self.view.vzWidth, 380)];
    self.calendarView.firstWeekDay = currentM.weekday;
    self.calendarView.currentDate = firstDay;
    self.calendarView.numberOfDays = [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit
                                                                        inUnit:NSMonthCalendarUnit
                                                                       forDate:currentM.date].length;


    [self.view addSubview:self.calendarView];
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

@end
 
