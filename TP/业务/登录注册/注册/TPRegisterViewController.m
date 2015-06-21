//
//  TPRegisterViewController.m
//  TP
//
//  Created by moxin on 15/6/5.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPRegisterViewController.h"
#import "SectionsViewController.h"
#import "TPLicenceViewController.h"

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

@interface TPRegisterViewController ()<SecondViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *contryLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectContryBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *vCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *vCodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *nickTextField;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIButton *privacyBtn;

@property(nonatomic,strong) NSString* areaCode;
//side effect
@property(nonatomic,assign) NSNumber* second;
@property(nonatomic,strong) NSTimer* timer;
@end

@implementation TPRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"注册"];
    
    self.areaCode = [TPUtils defaultLocalCode];
    
    NSString* localCode = [NSString stringWithFormat:@"+%@ %@",[TPUtils defaultLocalCode],[TPUtils defaultCountry]];
    self.contryLabel.text = localCode;
    
    
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
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self closeKeyboard];
    [self stopTimer];
}

- (void)dealloc
{
    [self stopTimer];
}


- (IBAction)selectCountry:(id)sender {
    
    SHOW_SPINNER(self);
    [TPUtils localCodesWithCompletion:^(NSArray *list) {
        
        HIDE_SPINNER(self);
        
        SectionsViewController* s = [SectionsViewController new];
        s.delegate = self;
        [s setAreaArray:[list mutableCopy]];
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:s] animated:YES completion:nil];
        
    }];
}
- (IBAction)onGetVCode:(id)sender {
    
    
    [self startTimer];
    self.areaCode = @"86";
    [SMS_SDK getVerificationCodeBySMSWithPhone:self.phoneTextField.text zone:self.areaCode result:^(SMS_SDKError *error) {
       
        if (!error) {
            
        }
        else
        {
            NSString* str = [NSString stringWithFormat:@"状态码：%zi ,错误描述：%@",error.errorCode,error.errorDescription];
            TOAST(self , str);
        }
    }];
    
}
- (IBAction)onHidePWD:(id)sender {
    
    self.pwdTextField.secureTextEntry = !self.pwdTextField.secureTextEntry;
}
- (IBAction)onConfirm:(id)sender {
    
    
    SHOW_SPINNER(self);
    VZHTTPRequestConfig config = vz_defaultHTTPRequestConfig();
    config.requestMethod = VZHTTPMethodPOST;
    [[VZHTTPNetworkAgent sharedInstance] HTTP:[_API_ stringByAppendingString:@"/register"]
                                requestConfig:config
                               responseConfig:vz_defaultHTTPResponseConfig()
                                       params:@{@"mobile":self.phoneTextField.text,
                                                @"newPasswd":self.pwdTextField.text,
                                                @"countryCode":self.areaCode.length == 0 ?@"86":self.areaCode,
                                                @"vcode":self.vCodeTextField.text,
                                                @"nick":self.nickTextField.text
                                                }
                            completionHandler:^(VZHTTPConnectionOperation *connection, NSString *responseString, id responseObj, NSError *error) {
                                
                                
                                HIDE_SPINNER(self);
                                
                                if (!error) {
                                    
                                    if ([responseObj[@"code"] integerValue] == 0) {
                                        
                                        TOAST(self, @"注册成功");
                                        
                                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                            
                                            [self.navigationController popViewControllerAnimated:true];
                                        });
                                    
                                    }
                                }
                                else
                                {
                                    HIDE_SPINNER(self);
                                    TOAST_ERROR(self, error);
                                }
       
    }];
    
}
- (IBAction)onPrivacy:(id)sender {

    TPLicenceViewController* v = [TPLicenceViewController new];
    [self.navigationController pushViewController:v animated:true];
}

- (void)setSecondData:(CountryAndAreaCode *)data
{
    self.contryLabel.text=[NSString stringWithFormat:@"+%@ %@",data.areaCode,data.countryName];
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
