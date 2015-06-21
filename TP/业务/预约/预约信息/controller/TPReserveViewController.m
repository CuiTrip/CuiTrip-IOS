  
//
//  TPReserveViewController.m
//  TP
//
//  Created by moxin on 2015-06-06 22:33:12 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPReserveViewController.h"
#import "TBCityHUDPicker.h"
#import "TPReserveModel.h"
#import "TPReserveSubView.h"
#import "TPGetServiceEnableDateModel.h"

@interface TPReserveViewController()<TBCityHUDPickerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UIButton *numBtn;
@property (weak, nonatomic) IBOutlet UIButton *dateBtn;
@property (weak, nonatomic) IBOutlet UILabel *feeLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (nonatomic,strong) TPReserveSubView* confirmView;
@property(nonatomic,strong)NSArray* availableDatesString;
@property(nonatomic,strong)TPReserveModel *reserveModel; 
@property(nonatomic,strong)TPGetServiceEnableDateModel* availabeDateModel;
@property(nonatomic,strong)NSString* selectedServiceDate;
@property(nonatomic,strong)NSString* selectedMaxNum;

@end

@implementation TPReserveViewController
{
}


//////////////////////////////////////////////////////////// 
#pragma mark - setters 



//////////////////////////////////////////////////////////// 
#pragma mark - getters 

   
- (TPReserveModel *)reserveModel
{
    if (!_reserveModel) {
        _reserveModel = [TPReserveModel new];
        _reserveModel.key = @"__TPReserveModel__";
    }
    return _reserveModel;
}

- (TPGetServiceEnableDateModel* )availabeDateModel
{
    if (!_availabeDateModel) {
        _availabeDateModel = [TPGetServiceEnableDateModel new];
    }
    return _availabeDateModel;
}


////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods

- (void)loadView
{
    [super loadView];
    //todo..
    [self setTitle:@"预约信息"];
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //todo..
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TPReserveSubView" owner:self options:nil];
    self.confirmView = (TPReserveSubView *)[nib objectAtIndex:0];
    self.confirmView.vzWidth = 300;
    self.confirmView.vzHeight = 320;
    self.confirmView.vzOrigin = CGPointMake((CGRectGetWidth(self.view.bounds)-300)/2, (CGRectGetHeight(self.view.bounds) - 320)/2);

    
    __weak typeof(self)weakSelf = self;
    self.confirmView.onConfirmCallback = ^{
        
        [[[[UIApplication sharedApplication].delegate window] viewWithTag:996]removeFromSuperview];
        [weakSelf.tabBarController setSelectedIndex:1];
        [weakSelf.navigationController popToRootViewControllerAnimated:true];

    };
    
    self.feeLabel.text = [TPUtils money:self.fee WithType:@""];
    

    SHOW_SPINNER(self);
    self.availabeDateModel.sid = self.sid;
    [self.availabeDateModel loadWithCompletion:^(VZModel *model, NSError *error) {
        
        
        HIDE_SPINNER(weakSelf);
      
        if (!error) {
            
            TPGetServiceEnableDateModel* availableModel = (TPGetServiceEnableDateModel* )model;
            
            NSMutableArray* list = [NSMutableArray new];
            for (NSDate* date in availableModel.availableDates) {
                NSString* s = [TPUtils fullDateFormatString:date];
                [list addObject:s];
            }
            weakSelf.availableDatesString = [list copy];;
        }
        else
        {
            TOAST_ERROR(weakSelf, error);
        }
        
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
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

- (IBAction)onConfirm:(id)sender {

    if (self.selectedServiceDate.length == 0 || self.selectedMaxNum.length == 0) {
        
        TOAST(self, @"请选择日期或人数");
        
        return;
    }
    
    //下单
    self.reserveModel.sid = self.sid;
    self.reserveModel.insiderId = self.insiderId;
    self.reserveModel.serviceName = self.serviceName;
    self.reserveModel.serviceDate = self.selectedServiceDate;
    self.reserveModel.buyerNum = self.selectedMaxNum;
    self.reserveModel.servicePrice = self.servicePrice;
    self.reserveModel.moneyType = @"CNY";
    
    SHOW_SPINNER(self);
    __weak typeof(self) weakSelf = self;
    [self.reserveModel loadWithCompletion:^(VZModel *model, NSError *error) {
        
        HIDE_SPINNER(weakSelf);
        
        if (!error) {
            UIView* v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kTPScreenWidth, kTPScreenHeight)];
            v.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
            v.tag = 996;
            [[[UIApplication sharedApplication].delegate window] addSubview:v];
            self.confirmView.titleLabel.text = self.serviceName;
            [self.confirmView.imageView sd_setImageWithURL:__url(self.pic) placeholderImage:__image(@"default_details.jpg")];
            [v addSubview:self.confirmView];
        }
        else
        {
            TOAST_ERROR(weakSelf, error);
        }
    }];
    

   
}

- (IBAction)onDate:(id)sender {
    [TBCityHUDPicker showPicker:self.availableDatesString Title:@"请选择预订时间" Tag:@"1" Delegate:self];
}
- (IBAction)onNum:(id)sender {
    
    NSMutableArray* list = [NSMutableArray new];
    for (int i=0; i<self.maxNum; i++) {
        
        NSString* num = [[NSString alloc]initWithFormat:@"%d人",i+1];
        [list addObject:num];
    }    
    [TBCityHUDPicker showPicker:list Title:@"请选择人数" Tag:@"2" Delegate:self];
}

- (void)onHUDPickerDidSelectedObject:(NSString*)str withIndex:(NSInteger)index
{
    if ([[TBCityHUDPicker sharedInstance].tag isEqualToString:@"1"])  {
        
        if (index < self.availabeDateModel.availableDates.count) {
            NSDate* date  = self.availabeDateModel.availableDates[index];
            long long t = [date timeIntervalSince1970]*1;
            t *= 1000;
            self.selectedServiceDate = [NSString stringWithFormat:@"%lld",t];
        }
        
        [self.dateBtn setTitle:str forState:UIControlStateNormal];
    }
    
    if ([[TBCityHUDPicker sharedInstance].tag isEqualToString:@"2"]) {
        
        self.selectedMaxNum = [str substringToIndex:str.length-1];
        [self.numBtn setTitle:str forState:UIControlStateNormal];
    }
    
}
- (void)onHUDPickerDidCancel
{

}
@end
 
