  
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


@interface TPReserveViewController()<TBCityHUDPickerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UIButton *numBtn;
@property (weak, nonatomic) IBOutlet UIButton *dateBtn;
@property (weak, nonatomic) IBOutlet UILabel *feeLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (nonatomic,strong) TPReserveSubView* confirmView;
 
@property(nonatomic,strong)TPReserveModel *reserveModel; 

@end

@implementation TPReserveViewController
{
    NSMutableArray* _dateToDisplay;
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
        
        [weakSelf.tabBarController setSelectedIndex:1];
        [weakSelf.navigationController popToRootViewControllerAnimated:true];

    };
    
//    if (self.availableDates.count > 0) {
//        
//        for (NSString* date; <#condition#>; <#increment#>) {
//            <#statements#>
//        }
//    }
    
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


- (IBAction)onConfirm:(id)sender {
    

    UIView* v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kTPScreenWidth, kTPScreenHeight)];
    v.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:v];
    
    [v addSubview:self.confirmView];
   
}

- (IBAction)onDate:(id)sender {
    
    NSArray* list = @[@"2015年6月20日",@"2015年6月22日",@"2015年6月25日",@"2015年6月28日"];
    [TBCityHUDPicker showPicker:list Title:@"请选择预订时间" Tag:@"1" Delegate:self];
}
- (IBAction)onNum:(id)sender {
    
    NSArray* list = @[@"3人",@"4人",@"5人",@"6人"];
    [TBCityHUDPicker showPicker:list Title:@"请选择人数" Tag:@"2" Delegate:self];
}

- (void)onHUDPickerDidSelectedObject:(NSString*)str withIndex:(NSInteger)index
{
    if ([[TBCityHUDPicker sharedInstance].tag isEqualToString:@"1"])  {
        [self.dateBtn setTitle:str forState:UIControlStateNormal];
    }
    
    if ([[TBCityHUDPicker sharedInstance].tag isEqualToString:@"2"]) {
        [self.numBtn setTitle:str forState:UIControlStateNormal];
    }
    
}
- (void)onHUDPickerDidCancel
{

}
@end
 
