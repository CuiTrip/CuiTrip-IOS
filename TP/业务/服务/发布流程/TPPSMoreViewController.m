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
@property (weak, nonatomic) IBOutlet UIButton *durationBtn;
@property (weak, nonatomic) IBOutlet UIButton *dateBtn;
@property (weak, nonatomic) IBOutlet UIButton *calendarBtn;

@property (weak, nonatomic) IBOutlet UIButton *numberBtn;
@property (weak, nonatomic) IBOutlet UIButton *meetBtn;

@property(nonatomic,strong) NSString* date;
@property(nonatomic,strong) NSString* duration;
@property(nonatomic,strong) NSString* number;
@property(nonatomic,strong) NSString* meet;
@property(nonatomic,strong) NSArray* dates;

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
    
//    if (sender.tag == 0) {
//        
//        TPDatePickerViewController* vc = [TPDatePickerViewController new];
//        vc.type = kSelection;
//        vc.date = [NSDate date];
//        vc.callback = ^(NSArray* list){
//            self.dates = list;
//            if (list.count > 0) {
//                [self.calendarBtn setTitle:[TPUtils fullDateFormatString:list[0]] forState:UIControlStateNormal];
//            }
//        };
//
//        [self.navigationController pushViewController:vc animated:true];
//    }

    if (sender.tag == 1) {
        
        NSArray* list = @[@"1小时",@"2小时",@"3小时",@"4小时",@"5小时",@"6小时",@"7小时",@"8小时",@"9小时",@"10小时",@"11小时",@"12小时"];
        [TBCityHUDPicker showPicker:list Title:@"请选择游玩时长" Tag:@"a" Delegate:self];
        
    }
    else if (sender.tag == 2)
    {
        NSArray* list = @[@"0点",@"1点",@"2点",@"3点",@"4点",@"5点",@"6点",@"7点",@"8点",@"9点",@"10点",@"11点",@"12点",@"13点",@"14点",@"15点",@"16点",@"17点",@"18点",@"19点",@"20点",@"21点",@"22点",@"23点"];
        
        [TBCityHUDPicker showPicker:list Title:@"请选择游玩时段" Tag:@"b" Delegate:self];
    }
    else if (sender.tag == 3)
    {
        NSArray* list = @[@"1人",@"2人",@"3人"];
        [TBCityHUDPicker showPicker:list Title:@"请选择游玩人数" Tag:@"c" Delegate:self];
    }
    else if (sender.tag == 4)
    {
        NSArray* list = @[@"约定点见面",@"开车接送"];
        [TBCityHUDPicker showPicker:list Title:@"请选择见面方式" Tag:@"d" Delegate:self];
    }
}

- (void)onNext
{
    if (self.callback) {
        self.callback(self.date,self.duration,self.number,self.meet,nil);
    }

}
- (void)onBack
{
    
}

- (void)onHUDPickerDidSelectedObject:(NSString*)str withIndex:(NSInteger)index
{
    if ([[TBCityHUDPicker sharedInstance].tag isEqualToString:@"a"])  {
        //[self.dateBtn setTitle:str forState:UIControlStateNormal];
        self.duration = str;
        [self.durationBtn setTitle:str forState:UIControlStateNormal];
    }
    
    if ([[TBCityHUDPicker sharedInstance].tag isEqualToString:@"b"]) {
        //[self.numBtn setTitle:str forState:UIControlStateNormal];
        self.date = str;
        [self.dateBtn setTitle:str forState:UIControlStateNormal];
    }
    
    if ([[TBCityHUDPicker sharedInstance].tag isEqualToString:@"c"]) {
        //[self.numBtn setTitle:str forState:UIControlStateNormal];
        self.number = str;
        [self.numberBtn setTitle:str forState:UIControlStateNormal];
    }
    
    if ([[TBCityHUDPicker sharedInstance].tag isEqualToString:@"d"]) {
        //[self.numBtn setTitle:str forState:UIControlStateNormal];
        self.meet = str;
        [self.meetBtn setTitle:str forState:UIControlStateNormal];
    }
    
}

@end
