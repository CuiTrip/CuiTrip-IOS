//
//  TPPSMoreViewController.m
//  TP
//
//  Created by moxin on 15/6/11.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPPSMoreViewController.h"
#import "TBCityHUDPicker.h"
#import "TPDatePickerViewController.h"





@interface TPPSMoreViewController ()<TBCityHUDPickerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UIButton *durationBtn;
@property (weak, nonatomic) IBOutlet UIButton *numberBtn;
@property (weak, nonatomic) IBOutlet UITextField *price;
@property (weak, nonatomic) IBOutlet UIButton *moneyTypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *priceTypeBtn;

@property(nonatomic,strong) NSString* duration;
@property(nonatomic,strong) NSString* number;
@property(nonatomic,strong) NSString* priceType;
@property(nonatomic,strong) NSString* moneyType;

@end

@implementation TPPSMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onAction:(UIButton* )sender {

    if (sender.tag == 1) {
        NSArray* list = @[@"1小时",@"2小时",@"3小时",@"4小时",@"5小时",@"6小时",@"7小时",@"8小时",@"9小时",@"10小时",@"11小时",@"12小时"];
        [TBCityHUDPicker showPicker:list Title:@"请选择游玩时长" Tag:@"a" Delegate:self];
        
    }
    else if (sender.tag == 2)
    {
        NSArray* list = @[@"1人",@"2人",@"3人",@"4人",@"5人",@"6人"];
        [TBCityHUDPicker showPicker:list Title:@"请选择游玩人数" Tag:@"b" Delegate:self];
    }
    else if (sender.tag == 3)
    {
        NSArray* list = @[@"一口价",@"按人数计费",@"免费"];
        [TBCityHUDPicker showPicker:list Title:@"请选择支付方式" Tag:@"c" Delegate:self];
    }
    else if (sender.tag == 4)
    {
        NSArray* list = @[@"人民币",@"新台币"];
        [TBCityHUDPicker showPicker:list Title:@"请选择货币类型" Tag:@"d" Delegate:self];
    }
}

- (BOOL)onNext
{
    if (self.address.text.length ==0 ||
        self.duration.length == 0 ||
        self.number.length == 0 ||
        self.price.text.length == 0 ||
        self.priceType.length == 0 ||
        self.moneyType.length == 0
        )
    {
        TOAST(self, @"请输完善所有信息");
        return NO;
    }
    
    else
    {
        if (self.callback) {
            self.callback(self.address.text,self.duration,self.number,self.price.text,self.priceType,self.moneyType,nil);
        }
        return YES;
        
    }
}
- (void)onBack
{
    
}

- (void)onHUDPickerDidSelectedObject:(NSString*)str withIndex:(NSInteger)index
{
    if ([[TBCityHUDPicker sharedInstance].tag isEqualToString:@"a"])  {
        self.duration = [str substringToIndex:str.length-2];
        [self.durationBtn setTitle:str forState:UIControlStateNormal];
    }

    if ([[TBCityHUDPicker sharedInstance].tag isEqualToString:@"b"]) {
        self.number = [str substringToIndex:str.length-1];
        [self.numberBtn setTitle:str forState:UIControlStateNormal];
    }
    
    if ([[TBCityHUDPicker sharedInstance].tag isEqualToString:@"c"]) {
        if (index == 0) {
            self.priceType = @"0";
        }
        else if(index == 0){
            self.priceType = @"1";
        }
        else
            self.priceType = @"2";
        
        [self.priceTypeBtn setTitle:str forState:UIControlStateNormal];
    }
    
    if ([[TBCityHUDPicker sharedInstance].tag isEqualToString:@"d"]) {
        if (index == 0) {
            self.moneyType = @"TWD";
        }
        else
            self.moneyType = @"CNY";

        [self.moneyTypeBtn setTitle:str forState:UIControlStateNormal];
    }
    
}

@end
