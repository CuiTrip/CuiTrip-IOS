  
//
//  TPForgetPWDViewController.m
//  TP
//
//  Created by moxin on 2015-06-06 17:11:51 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPForgetPWDViewController.h"
#import "SectionsViewController.h"
#import "TPForgetPWDModel.h" 

@interface NSTimer(block)
+(NSTimer* )scheduledTimerWithTimeInterval:(NSTimeInterval)ti block:(void(^)())block userInfo:(id)userInfo repeats:(BOOL)repeat;
@end

@implementation NSTimer(block)

+ (NSTimer* )scheduledTimerWithTimeInterval:(NSTimeInterval)ti block:(void (^)())block userInfo:(id)userInfo repeats:(BOOL)repeat
{
    return [NSTimer scheduledTimerWithTimeInterval:ti target:self selector:@selector(onTimerFired:) userInfo:[block copy] repeats:repeat];
}

+ (void)onTimerFired:(NSTimer* )timer
{
    void(^block)() = timer.userInfo;
    
    if (block) {
        block();
    }
}

@end

@interface TPForgetPWDViewController()<SecondViewControllerDelegate>

 
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *vCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *vCodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPWDTextField;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectCountryBtn;

@property(nonatomic,strong)TPForgetPWDModel *forgetPWDModel;

@property(nonatomic,strong) NSString* areaCode;
//side effect
@property(nonatomic,assign) NSNumber* second;
@property(nonatomic,strong) NSTimer* timer;


@end

@implementation TPForgetPWDViewController


//////////////////////////////////////////////////////////// 
#pragma mark - setters 



//////////////////////////////////////////////////////////// 
#pragma mark - getters 

   
- (TPForgetPWDModel *)forgetPWDModel
{
    if (!_forgetPWDModel) {
        _forgetPWDModel = [TPForgetPWDModel new];
        _forgetPWDModel.key = @"__TPForgetPWDModel__";
    }
    return _forgetPWDModel;
}



////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods

- (void)loadView
{
    [super loadView];

    //self.confirmBtn.hidden = true;
    //todo..
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //todo..
    [self setTitle:@"重置密码"];
    
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.vCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.pwdTextField.keyboardType = UIKeyboardTypeDefault;
    self.confirmPWDTextField.keyboardType = UIKeyboardTypeDefault;
    self.pwdTextField.secureTextEntry = YES;
    self.areaCode = [TPUtils defaultLocalCode];
    NSString* localCode = [NSString stringWithFormat:@"+%@ %@",[TPUtils defaultLocalCode],[TPUtils defaultCountry]];
    self.countryLabel.text = localCode;
    __weak typeof(self) weakSelf = self;
    [RACObserve(self, second) subscribeNext:^(NSNumber* x) {
        
        if (x.integerValue == 0) {
            
            [weakSelf.vCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            [weakSelf.vCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            weakSelf.vCodeBtn.backgroundColor = [TPTheme themeColor];
            weakSelf.vCodeBtn.userInteractionEnabled = true;
        }
        else
        {
            [weakSelf.vCodeBtn setTitle:[NSString stringWithFormat:@"重新获取(%@)",x] forState:UIControlStateNormal];
            [weakSelf.vCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            weakSelf.vCodeBtn.backgroundColor = [UIColor grayColor];
            weakSelf.vCodeBtn.userInteractionEnabled = NO;
        }
        
    }];
    
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeKeyboard)]];
    

//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:0 target:self action:@selector(onConfirm:)];
    
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
    
    [self closeKeyboard];
    [self stopTimer];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
        self.tabBarController.tabBar.hidden = true;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

-(void)dealloc {
    
    //todo..
    [self stopTimer];
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


- (IBAction)onSelectCountry:(id)sender {
    
    SHOW_SPINNER(self);
    [TPUtils localCodesWithCompletion:^(NSArray *list) {
        
        HIDE_SPINNER(self);
        
        SectionsViewController* s = [SectionsViewController new];
        s.delegate = self;
        [s setAreaArray:[list mutableCopy]];
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:s] animated:YES completion:nil];
        
    }];
}
- (IBAction)onVCode:(id)sender {
    
    [self startTimer];
    [SMS_SDK getVerificationCodeBySMSWithPhone:self.phoneTextField.text zone:self.areaCode result:^(SMS_SDKError *error) {
        
        if (!error) {
            
        }
        else
        {
            
            NSLog(@"onVCode error in %@: %@", self, error);
            NSString* str = [NSString stringWithFormat:@"获取失败：%@",error.errorDescription];
            TOAST(self , str);
        }
    }];
    
}
- (IBAction)onConfirm:(id)sender {
    
    
    [self.view endEditing:true];
   
    if (self.vCodeTextField.text.length==0) {
        TOAST(self, @"请输入验证码");
        return;
    }

    
    NSString* vCode = self.vCodeTextField.text;
    self.forgetPWDModel.vcode = vCode;
    self.forgetPWDModel.countryCode = self.areaCode;
    self.forgetPWDModel.mobile = self.phoneTextField.text;
    self.forgetPWDModel.anewPasswd = self.pwdTextField.text;
    self.forgetPWDModel.rePasswd = self.confirmPWDTextField.text;
    
    
    SHOW_SPINNER(self);
    [self.forgetPWDModel loadWithCompletion:^(VZModel *model, NSError *error) {
       
        HIDE_SPINNER(self);
        if (error) {
            TOAST_ERROR(self, error);
        }
        else
        {
            TOAST(self, @"修改成功!");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:true];
            });
        }
        
    }];
    
    
}

- (void)setSecondData:(CountryAndAreaCode *)data
{
    self.areaCode = data.areaCode;
    self.countryLabel.text=[NSString stringWithFormat:@"+%@ %@",data.areaCode,data.countryName];
}

#define kDefaultTimeoutSeconds 30
static unsigned int g_seconds = kDefaultTimeoutSeconds;
- (void)startTimer
{
    [self.timer invalidate];
    _timer = nil;
    
    if (!_timer) {
        
        __weak typeof(self) weakSelf = self;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 block:^{
            
            g_seconds--;
            weakSelf.second = @(g_seconds);
            
            if (g_seconds == 0) {
                g_seconds = kDefaultTimeoutSeconds;
                [weakSelf stopTimer];
            }
            
        } userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}
-(void)stopTimer
{
    [self.timer invalidate];
    _timer = nil;
    
}

- (void)closeKeyboard
{
    //    [self.phoneTextField resignFirstResponder];
    //    [self.vCodeTextField resignFirstResponder];
    //    [self.pwdTextField resignFirstResponder];
    //    [self.nickTextField resignFirstResponder];
    [self.view endEditing:true];
}

@end
 
