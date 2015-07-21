  
//
//  TPPayViewController.m
//  TP
//
//  Created by wifigo on 2015-07-21 20:44:52 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPPayViewController.h"
 
#import "TPPayModel.h" 
#import "TPPaySubView.h"

@interface TPPayViewController()


@property (weak, nonatomic) IBOutlet UIView *bkView;
@property (weak, nonatomic) IBOutlet UIView *allview;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *tripDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tripNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *tripFeeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tripCNYFeeLabel;

@property (weak, nonatomic) IBOutlet UIButton *alipayBtn;
@property (weak, nonatomic) IBOutlet UIButton *wxpayBtn;
@property (weak, nonatomic) IBOutlet UIButton *codepayBtn;

@property (nonatomic,strong) TPPayModel *payModel;
@property (nonatomic,strong) TPPaySubView* confirmView;

@end

@implementation TPPayViewController


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
    
    self.bkView.layer.cornerRadius = 5.0f;
    self.bkView.clipsToBounds = true;
    
    self.titleLabel.layer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7].CGColor;
    //    self.titleLabel.layer.backgroundColor = [UIColor colorWithRed:(33/255.0) green:(33/255.0) blue:(33/255.0) alpha:0.5].CGColor;
    
    
    self.codepayBtn.backgroundColor = HEXCOLOR(0xff0058);
    self.codepayBtn.layer.cornerRadius = 22.0f;
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
    
    self.titleLabel.text = self.payModel.serviceName;
    [self.imageView sd_setImageWithURL:__url(self.payModel.insiderHeadPic) placeholderImage:__image(@"girl.jpg")];
    self.tripDateLabel.text = self.payModel.serviceDate;
    self.tripNumberLabel.text = [self.payModel.buyerNum stringByAppendingString:@"人"];
    self.tripFeeLabel.text = [TPUtils money:self.payModel.orderPrice WithType:self.payModel.moneyType];
    self.tripCNYFeeLabel.text = self.payModel.orderPrice;
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
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TPPaySubView" owner:self options:nil];
    self.confirmView = (TPPaySubView *)[nib objectAtIndex:0];
    self.confirmView.vzWidth = 300;
    self.confirmView.vzHeight = 160;
    self.confirmView.vzOrigin = CGPointMake((CGRectGetWidth(self.view.bounds)-300)/2, (CGRectGetHeight(self.view.bounds) - 160)/2);
    self.confirmView.layer.cornerRadius  = 8.0f;
    self.confirmView.layer.masksToBounds = true;
    [self.confirmView.confirmBtn setTitle:@"前往旅程查看预定的订单" forState:UIControlStateNormal];
    
    
    __weak typeof(self)weakSelf = self;
    self.confirmView.onConfirmCallback = ^{
        
        [[[[UIApplication sharedApplication].delegate window] viewWithTag:996]removeFromSuperview];
        [weakSelf.tabBarController setSelectedIndex:2];
        [weakSelf.navigationController popToRootViewControllerAnimated:true];
        
    };
    
    
    SHOW_SPINNER(self);
    self.payModel.oid = self.oid;
    //    self.payModel.inviteCode = self.textField.text;
    
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
            
            UIView* v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kTPScreenWidth, kTPScreenHeight)];
            v.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
            v.tag = 996;
            // 模糊化视图
            //            UIImage *uiimage = [self convertViewToImage:v];
            //            UIView* vc =[self blurryImage:uiimage withBlurLevel:3.0];
            
            [[[UIApplication sharedApplication].delegate window] addSubview:v];
            [v addSubview:self.confirmView];
            //            TOAST_ERROR(weakSelf, error);
        }
        
    }];
}
- (IBAction)wxpayAction:(id)sender {
    
    SHOW_SPINNER(self);
    self.payModel.oid = self.oid;
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
    TPPayViewController* vc = [[UIStoryboard storyboardWithName:@"TPPayViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"tppay"];
    vc.oid = weakSelf.oid;
    [weakSelf.navigationController pushViewController:vc animated:true];
    
    
}

@end
 
