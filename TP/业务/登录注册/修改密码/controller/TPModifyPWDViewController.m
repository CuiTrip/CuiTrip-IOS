  
//
//  TPModifyPWDViewController.m
//  TP
//
//  Created by moxin on 2015-06-25 22:52:10 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPModifyPWDViewController.h"
 
#import "TPModifyPWDModel.h" 

@interface TPModifyPWDViewController()

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPWDTextField;
 
@property(nonatomic,strong)TPModifyPWDModel *modifyPWDModel; 
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@end

@implementation TPModifyPWDViewController


//////////////////////////////////////////////////////////// 
#pragma mark - setters 



//////////////////////////////////////////////////////////// 
#pragma mark - getters 

   
- (TPModifyPWDModel *)modifyPWDModel
{
    if (!_modifyPWDModel) {
        _modifyPWDModel = [TPModifyPWDModel new];
        _modifyPWDModel.key = @"__TPModifyPWDModel__";
    }
    return _modifyPWDModel;
}



////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods

- (void)loadView
{
    [super loadView];
    //todo..
    [self setTitle:@"修改密码"];
    self.pwdTextField.secureTextEntry = true;
    self.confirmPWDTextField.secureTextEntry = true;
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
- (IBAction)onConfirm:(id)sender {

    if (self.phoneTextField.text.length == 0||self.pwdTextField.text.length == 0||self.confirmPWDTextField.text.length==0) {
        
        TOAST(self, @"请完善信息");
        return;
    }
    else if(![self.pwdTextField.text isEqualToString:self.confirmPWDTextField.text])
    {
        TOAST(self, @"两次输入密码不一致");
        return;
    }
    else
    {
        self.modifyPWDModel.pwd = self.pwdTextField.text;
        self.modifyPWDModel.confirmPwd = self.confirmPWDTextField.text;
        
        
        SHOW_SPINNER(self);
        [self.modifyPWDModel loadWithCompletion:^(VZModel *model, NSError *error) {
            
            HIDE_SPINNER(self);
            if (error) {
                TOAST_ERROR(self, error);
            }
            else
            {
                TOAST(self, @"密码修改成功!");
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:true];
                });
            }
            
        }];
        
    }

}

@end
 
