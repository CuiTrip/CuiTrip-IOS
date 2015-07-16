  
//
//  TPPayViewController.m
//  TP
//
//  Created by moxin on 2015-06-15 17:32:26 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPPayOrderViewController.h"
#import "TPPayViewController.h"
 
#import "TPPayModel.h" 

@interface TPPayOrderViewController()

@property (weak, nonatomic) IBOutlet UIView *bkView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *tripDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tripNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *tripFeeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tripCNYFeeLabel;
@property(nonatomic,strong)TPPayModel *payModel; 
@property (weak, nonatomic) IBOutlet UIButton *alipayBtn;
@property (weak, nonatomic) IBOutlet UIButton *wxpayBtn;
@property (weak, nonatomic) IBOutlet UIButton *codepayBtn;

@end

@implementation TPPayOrderViewController


//////////////////////////////////////////////////////////// 
#pragma mark - setters 



//////////////////////////////////////////////////////////// 
#pragma mark - getters 

   
- (TPPayModel *)payModel
{
    if (!_payModel) {
        _payModel = [TPPayModel new];
        _payModel.key = @"__TPPayModel__";
    }
    return _payModel;
}



////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods

- (void)loadView
{
    [super loadView];
    //todo..
    [self setTitle:@"支付"];
//    self.imageView.layer.cornerRadius = 0.5*self.imageView.vzWidth;
    self.imageView.layer.masksToBounds = true;
    self.imageView.clipsToBounds = true;
    self.imageView.layer.borderWidth = 2.0f;
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    //todo..
    self.bkView.layer.borderColor = [TPTheme grayColor].CGColor;
    self.bkView.layer.borderWidth = 0.5;

    self.titleLabel.layer.backgroundColor = [TPTheme grayColor].CGColor;
    
    
    self.codepayBtn.backgroundColor = HEXCOLOR(0xff0058);
    self.codepayBtn.layer.cornerRadius = 0.5*self.imageView.vzHeight;
    self.codepayBtn.clipsToBounds = true;

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
    
//    self.titleLabel.text = self.tripDetailModel.serviceName;
//    [self.imageView sd_setImageWithURL:__url(self.tripDetailModel.insiderHeadPic) placeholderImage:__image(@"girl.jpg")];
//    self.nameLabel.text = self.tripDetailModel.insiderNickName;
//    self.descLabel.text = self.tripDetailModel.insiderSign;
//    self.tripDateLabel.text = self.tripDetailModel.serviceDate;
//    self.tripNumberLabel.text = [self.tripDetailModel.buyerNum stringByAppendingString:@"人"];
//    self.tripFeeLabel.text = [TPUtils money:self.tripDetailModel.orderPrice WithType:self.tripDetailModel.moneyType];
//    
//    if ([self.tripDetailModel.status integerValue] == 1)
//    {
//        self.status = kOrderCreated;
//    }
//    else if ([self.tripDetailModel.status integerValue] == 2)
//    {
//        self.status = kOrderConfirmed;
//    }
//    else if([self.tripDetailModel.status integerValue] == 4)
//    {
//        self.status = kOrderDidBegin;
//    }
//    else if ([self.tripDetailModel.status integerValue] == 5)
//    {
//        self.status = kOrderComplted;
//    }
//    else if ([self.tripDetailModel.status integerValue] == 7)
//    {
//        self.status = kOrderClosed;
//    }
//    else if ([self.tripDetailModel.status integerValue] == 8)
//    {
//        self.status = kOrderPaied;
//    }
//    else
//        self.status = kOrderUnknown;
//    
//    [self refreshStatus];
//
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

- (IBAction)alipayAction:(id)sender {
    
    SHOW_SPINNER(self);
    self.payModel.orderId = self.oid;
//    self.payModel.inviteCode = self.textField.text;
    
    __weak typeof(self) weakSelf = self;
    [self.payModel loadWithCompletion:^(VZModel *model, NSError *error) {
       
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
- (IBAction)wxpayAction:(id)sender {
    
    SHOW_SPINNER(self);
    self.payModel.orderId = self.oid;
    //    self.payModel.inviteCode = self.textField.text;
    
    __weak typeof(self) weakSelf = self;
    [self.payModel loadWithCompletion:^(VZModel *model, NSError *error) {
        
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

- (IBAction)codepayAction:(id)sender {
    __weak typeof(self) weakSelf = self;
    TPPayViewController* vc = [[UIStoryboard storyboardWithName:@"TPPayOrderViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"tppayorder"];
    vc.oid = weakSelf.oid;
    [weakSelf.navigationController pushViewController:vc animated:true];
    
//    SHOW_SPINNER(self);
//    self.payModel.orderId = self.oid;
//    //    self.payModel.inviteCode = self.textField.text;
//    
//    __weak typeof(self) weakSelf = self;
//    [self.payModel loadWithCompletion:^(VZModel *model, NSError *error) {
//        
//        HIDE_SPINNER(weakSelf);
//        
//        if (!error) {
//            
//            TOAST(weakSelf, @"支付成功!");
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                
//                [weakSelf vz_postToChannel:kChannelNewOrder withObject:nil Data:nil];
//                [weakSelf vz_postToChannel:kChannelNewMessage withObject:nil Data:nil];
//                [weakSelf.navigationController popToRootViewControllerAnimated:true];
//            });
//        }
//        else
//        {
//            TOAST_ERROR(weakSelf, error);
//        }
//        
//    }];
}

@end
 
