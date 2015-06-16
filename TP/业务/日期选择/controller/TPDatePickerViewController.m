
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

@property(nonatomic,strong) TPDatePickerSelectionView* selectionView;
@property(nonatomic,strong) UIScrollView* scrollView;

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
    
    
    [self.view setBackgroundColor:[TPTheme yellowColor]];
    
    self.selectionView = [[TPDatePickerSelectionView alloc]initWithFrame:CGRectMake(0, 20, self.view.vzWidth, 40)];
    self.selectionView.dateLabel.text = @"2015年6月30日";
    self.selectionView.backgroundColor = [TPTheme themeColor];
    [self.view addSubview:self.selectionView];
    
    __weak typeof(self) weakSelf = self;
    self.selectionView.rightCallback = ^{
    
        NSInteger w = weakSelf.scrollView.vzWidth;
        NSInteger h = weakSelf.scrollView.vzHeight;
        
        if (weakSelf.scrollView.contentOffset.x >= w) {
            //noop
        }
        else
            [weakSelf.scrollView scrollRectToVisible:CGRectMake(weakSelf.scrollView.contentOffset.x+w, 0, w, h) animated:true];
    
    };
    self.selectionView.leftCallback = ^{
        
        NSInteger w = weakSelf.scrollView.vzWidth;
        NSInteger h = weakSelf.scrollView.vzHeight;
        
        if (weakSelf.scrollView.contentOffset.x == 0) {
            //noop
        }
        else
            [weakSelf.scrollView scrollRectToVisible:CGRectMake(weakSelf.scrollView.contentOffset.x-w, 0, w, h) animated:true];
    
    };
    
    
    
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 60, self.view.vzWidth, 380)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = true;
    self.scrollView.bounces = true;
    self.scrollView.showsHorizontalScrollIndicator = false;
    self.scrollView.contentSize = CGSizeMake(self.view.vzWidth*2, 380);
    [self.view addSubview:self.scrollView];
    

    self.date = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    calendar.firstWeekday = 1;
    calendar.minimumDaysInFirstWeek = 7;
    NSDateComponents* currentM = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSCalendarCalendarUnit fromDate:self.date];
    
    NSUInteger firstDay = currentM.day;
    currentM.day = 1;
    currentM = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSCalendarCalendarUnit fromDate:currentM.date];


    TBCityCalendarMonthView* calendarView1 = [[TBCityCalendarMonthView alloc]initWithFrame:CGRectMake(0, 0, self.view.vzWidth, 380)];
    
    calendarView1.canEdit = self.type == kSelection?true:false;
    calendarView1.tag = 0;
    calendarView1.delegate = self;
    calendarView1.firstWeekDay = currentM.weekday;
    calendarView1.currentDate = firstDay;
    calendarView1.numberOfDays = [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit
                                                                        inUnit:NSMonthCalendarUnit
                                                                       forDate:currentM.date].length;
    calendarView1.availableDates = @[@(12),@(13),@(20),@(25)];
    calendarView1.reservedDates = @[@(1),@(5),@(6),@(10),@(11),@(22)];
    [self.scrollView addSubview:calendarView1];



    TBCityCalendarMonthView* calendarView2 = [[TBCityCalendarMonthView alloc]initWithFrame:CGRectMake(self.scrollView.vzWidth, 0, self.view.vzWidth, 380)];
    
    calendarView2.canEdit = self.type==kSelection?true:false;
    calendarView2.tag = 1;
    calendarView2.delegate = self;
    calendarView2.firstWeekDay = currentM.weekday;
    calendarView2.currentDate = firstDay;
    calendarView2.numberOfDays = [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit
                                                                    inUnit:NSMonthCalendarUnit
                                                                   forDate:currentM.date].length;
    calendarView2.availableDates = @[@(24),@(19),@(2),@(4),@(8)];
    [self.scrollView addSubview:calendarView2];
    
    
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TPDatePickerCalenderFooterView" owner:self options:nil];
    UIView* v =(UIView *)[nib objectAtIndex:0];
    v.backgroundColor = [UIColor clearColor];
    v.vzOrigin = CGPointMake(0, self.scrollView.vzBottom);
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

- (void)onMonthView:(UIView*)v DateSelected:(NSInteger)date
{

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

@end
 
