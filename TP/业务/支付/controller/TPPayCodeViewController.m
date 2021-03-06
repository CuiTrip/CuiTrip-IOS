  
//
//  TPPayViewController.m
//  TP
//
//  Created by moxin on 2015-06-15 17:32:26 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPPayCodeViewController.h"
 
#import "TPPayCodeModel.h"

@interface TPPayCodeViewController()

 
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property(nonatomic,strong)TPPayCodeModel *payCodeModel;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@end

@implementation TPPayCodeViewController


//////////////////////////////////////////////////////////// 
#pragma mark - setters 



//////////////////////////////////////////////////////////// 
#pragma mark - getters 

   
- (TPPayCodeModel *)payCodeModel
{
    if (!_payCodeModel) {
        _payCodeModel = [TPPayCodeModel new];
        _payCodeModel.key = @"__TPPayCodeModel__";
    }
    return _payCodeModel;
}



////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods

- (void)loadView
{
    [super loadView];
    //todo..
    [self setTitle:@"体验码支付"];
    self.textField.layer.cornerRadius = 5.0f;
    self.textField.layer.masksToBounds = true;
    self.textField.layer.borderWidth = 0.5;
    self.textField.layer.borderColor = [TPTheme grayColor].CGColor;
    self.textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, self.textField.bounds.size.height)];
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    
    self.confirmBtn.backgroundColor = HEXCOLOR(0xff0058);
    self.confirmBtn.layer.cornerRadius = 20.0f;
    self.confirmBtn.clipsToBounds = true;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //todo..
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"TPPayCodeView"];
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
    [MobClick endLogPageView:@"TPPayCodeView"];
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
- (IBAction)onAction:(id)sender {
    
    SHOW_SPINNER(self);
    self.payCodeModel.orderId = self.oid;
    self.payCodeModel.inviteCode = self.textField.text;
    
    __weak typeof(self) weakSelf = self;
    [self.payCodeModel loadWithCompletion:^(VZModel *model, NSError *error) {
       
        HIDE_SPINNER(weakSelf);
        
        if (!error) {
            
            TOAST(weakSelf, @"支付成功!");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [weakSelf vz_postToChannel:kChannelNewOrder withObject:nil Data:nil];
                [weakSelf vz_postToChannel:kChannelNewMessage withObject:nil Data:nil];
                [weakSelf.navigationController popToRootViewControllerAnimated:true];
            });
        }
        else
        {
            TOAST_ERROR(weakSelf, error);
        }
        
    }];
}

@end
 
