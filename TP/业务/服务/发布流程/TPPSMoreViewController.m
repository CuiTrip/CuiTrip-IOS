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
#import "TPPSFeeExplanView.h"




@interface TPPSMoreViewController ()<TBCityHUDPickerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *allview;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UIButton *durationBtn;
@property (weak, nonatomic) IBOutlet UIButton *numberBtn;
@property (weak, nonatomic) IBOutlet UITextField *price;
@property (weak, nonatomic) IBOutlet UIButton *moneyTypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *priceTypeBtn;

@property (weak, nonatomic) IBOutlet UIImageView *avatarIcon;

@property(nonatomic,strong) NSString* duration;
@property(nonatomic,strong) NSString* number;
@property(nonatomic,strong) NSString* priceType;
@property(nonatomic,strong) NSString* moneyType;

@end
#define ios7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)


@implementation TPPSMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat origin_y;
    if(ios7){
        origin_y = 64.0;
    }else{
        origin_y=0;
    }
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    CGSize containerSize = self.scrollView.frame.size;
    CGSize contentSize = [self.allview sizeThatFits:containerSize];
    CGRect frame = self.allview.frame;
    frame.size.height = MAX(contentSize.height, containerSize.height);
    self.allview.frame = frame;
    self.scrollView.contentSize = frame.size;
    [self.scrollView scrollRectToVisible:self.allview.frame animated:YES];
    self.scrollView.scrollEnabled = YES;
    
    

    self.avatarIcon.userInteractionEnabled = YES;

    //单个手指双击屏幕事件注册
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(infoPicClicked)];
    // Set required taps and number of touches
    [singleTap setNumberOfTapsRequired:1];
    [singleTap setNumberOfTouchesRequired:1];
    
    // Add the gesture to the view
    [self.avatarIcon addGestureRecognizer:singleTap];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}

- (void) viewDidLayoutSubviews {
    CGRect viewBounds = self.view.bounds;
    CGFloat topBarOffset = self.topLayoutGuide.length;
    viewBounds.origin.y = topBarOffset * -1;
    self.view.bounds = viewBounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)keyboardWillShow:(NSNotification *)notification
{
    self.scrollView.scrollEnabled = NO;
    
    CGRect keyboardBounds;
    [notification.userInfo[UIKeyboardFrameEndUserInfoKey] getValue:&keyboardBounds];
    
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
    CGRect containerFrame = self.scrollView.frame;
    containerFrame.size.height = CGRectGetHeight(self.view.bounds) - CGRectGetHeight(keyboardBounds)-20;
    
    self.scrollView.frame = containerFrame;
    
    self.scrollView.scrollEnabled = YES;
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.scrollView.scrollEnabled = NO;
    
    CGRect keyboardBounds;
    [notification.userInfo[UIKeyboardFrameEndUserInfoKey] getValue:&keyboardBounds];
    
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
    CGRect containerFrame = self.scrollView.frame;
    containerFrame.size.height = CGRectGetHeight(self.view.bounds);
    
    self.scrollView.frame = containerFrame;
    
    self.scrollView.scrollEnabled = YES;
    
}

- (void)closeKeyboard
{
    [self.address resignFirstResponder];
    [self.price resignFirstResponder];
}


- (void) infoPicClicked {
    TPPSFeeExplanView *view = [[TPPSFeeExplanView alloc] initWithFrame:CGRectMake(0.0f, self.view.frame.origin.y - 64.0f, kTPScreenWidth, kTPScreenHeight)];
    [self.view addSubview:view];
}

- (IBAction)onAction:(UIButton* )sender {
    [self closeKeyboard];
    [self.address resignFirstResponder];
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
        NSArray* list = @[@"新台币",@"人民币"];
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
        [self.durationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }

    if ([[TBCityHUDPicker sharedInstance].tag isEqualToString:@"b"]) {
        self.number = [str substringToIndex:str.length-1];
        [self.numberBtn setTitle:str forState:UIControlStateNormal];
        [self.numberBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    }
    
    if ([[TBCityHUDPicker sharedInstance].tag isEqualToString:@"c"]) {
        if (index == 0) {
            self.priceType = @"0";
            self.price.enabled = YES;
            [self.moneyTypeBtn setTitle:@"新台币" forState:UIControlStateNormal];
        }
        else if(index == 1){
            self.priceType = @"1";
            self.price.enabled = YES;
            [self.moneyTypeBtn setTitle:[@"新台币" stringByAppendingString:@"/人"] forState:UIControlStateNormal];
        }
        else
        {
            self.priceType = @"2";
            self.price.text = @"0";
            self.price.enabled = NO;
            [self.moneyTypeBtn setTitle:@"新台币" forState:UIControlStateNormal];
        }
        
        [self.priceTypeBtn setTitle:str forState:UIControlStateNormal];
        [self.priceTypeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.moneyTypeBtn setTitleColor:[TPTheme bgColor] forState:UIControlStateNormal];
    }
    
    if ([[TBCityHUDPicker sharedInstance].tag isEqualToString:@"d"]) {
        if (index == 0) {
            self.moneyType = @"TWD";
        }
        else
            self.moneyType = @"CNY";

        [self.moneyTypeBtn setTitle:str forState:UIControlStateNormal];
        if ([self.priceType isEqualToString:@"1"]) {
            [self.moneyTypeBtn setTitle:[str stringByAppendingString:@"/人"] forState:UIControlStateNormal];
        }

        [self.moneyTypeBtn setTitleColor:[TPTheme bgColor] forState:UIControlStateNormal];
    }
    
}

@end
