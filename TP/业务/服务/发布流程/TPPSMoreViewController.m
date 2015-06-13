//
//  TPPSMoreViewController.m
//  TP
//
//  Created by moxin on 15/6/11.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPPSMoreViewController.h"
#import "TBCityHUDPicker.h"

@interface TPPSMoreViewController ()<TBCityHUDPickerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *durationBtn;
@property (weak, nonatomic) IBOutlet UIButton *dateBtn;

@property (weak, nonatomic) IBOutlet UIButton *numberBtn;
@property (weak, nonatomic) IBOutlet UIButton *meetBtn;

@property(nonatomic,strong) NSString* date;
@property(nonatomic,strong) NSString* duration;
@property(nonatomic,strong) NSString* number;
@property(nonatomic,strong) NSString* meet;

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
        
        NSArray* list = @[@"1",@"2",@"3"];
        [TBCityHUDPicker showPicker:list Title:@"请选择游玩时长" Tag:@"a" Delegate:self];
        
    }
    else if (sender.tag == 2)
    {
        NSArray* list = @[@"1",@"2",@"3"];
        [TBCityHUDPicker showPicker:list Title:@"请选择游玩时段" Tag:@"b" Delegate:self];
    }
    else if (sender.tag == 3)
    {
        NSArray* list = @[@"1",@"2",@"3"];
        [TBCityHUDPicker showPicker:list Title:@"请选择游玩人数" Tag:@"c" Delegate:self];
    }
    else if (sender.tag == 4)
    {
        NSArray* list = @[@"1",@"2",@"3"];
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
    }
    
    if ([[TBCityHUDPicker sharedInstance].tag isEqualToString:@"b"]) {
        //[self.numBtn setTitle:str forState:UIControlStateNormal];
        self.date = str;
    }
    
    if ([[TBCityHUDPicker sharedInstance].tag isEqualToString:@"c"]) {
        //[self.numBtn setTitle:str forState:UIControlStateNormal];
        self.number = str;
    }
    
    if ([[TBCityHUDPicker sharedInstance].tag isEqualToString:@"d"]) {
        //[self.numBtn setTitle:str forState:UIControlStateNormal];
        self.meet = str;
    }
    
}

@end
