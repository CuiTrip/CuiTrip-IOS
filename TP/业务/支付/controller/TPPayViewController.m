  
//
//  TPPayViewController.m
//  TP
//
//  Created by wifigo on 2015-07-21 20:44:52 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPPayViewController.h"

#import "TPPayCodeViewController.h"
#import "TPPayModel.h" 
#import "TPPaySubView.h"
#import "Pingpp.h"

#define kUrlScheme      @"YOUR-APP-URL-SCHEME"
#define kUrl            @"YOUR-URL"

@interface TPPayViewController()


@property (weak, nonatomic) IBOutlet UIView *bkView;
@property (weak, nonatomic) IBOutlet UIView *allview;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *tripDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tripNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *tripFeeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tripMoneyTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tripCNYFeeLabel;

@property (weak, nonatomic) IBOutlet UIButton *alipayBtn;
@property (weak, nonatomic) IBOutlet UIButton *wxpayBtn;
@property (weak, nonatomic) IBOutlet UIButton *codepayBtn;

@property (nonatomic,strong) TPPayModel *payModel;
@property (nonatomic,strong) TPPaySubView* confirmView;

@end

@implementation TPPayViewController
@synthesize channel;

//////////////////////////////////////////////////////////// 
#pragma mark - setters 

- (void)setTripDetailModel:(TPTripDetailModel *)tripDetailModel
{
    _tripDetailModel = tripDetailModel;
}



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
    
    self.titleLabel.textColor = [UIColor whiteColor];
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
    self.payModel.oid = self.oid;
    [self registerModel:self.payModel];
    [self load];
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
    
    self.titleLabel.text = self.tripDetailModel.serviceName;
    [self.imageView sd_setImageWithURL:__url(self.tripDetailModel.insiderHeadPic) placeholderImage:__image(@"default_details.jpg")];
    self.tripDateLabel.text = self.tripDetailModel.serviceDate;
    self.tripNumberLabel.text = [self.tripDetailModel.buyerNum stringByAppendingString:@"人"];
    self.tripFeeLabel.text = self.tripDetailModel.orderPrice;
    self.tripMoneyTypeLabel.text = ([self.tripDetailModel.moneyType isEqual:@"TWD"])?@"新台币":@"人民币";
    self.tripCNYFeeLabel.text = self.tripDetailModel.orderPrice;
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
    
    self.channel = @"alipay";
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TPPaySubView" owner:self options:nil];
    self.confirmView = (TPPaySubView *)[nib objectAtIndex:0];
    self.confirmView.vzWidth = 300;
    self.confirmView.vzHeight = 160;
    self.confirmView.vzOrigin = CGPointMake((CGRectGetWidth(self.view.bounds)-300)/2, (CGRectGetHeight(self.view.bounds) - 160)/2);
    self.confirmView.layer.cornerRadius  = 8.0f;
    self.confirmView.layer.masksToBounds = true;

    __weak typeof(self)weakSelf = self;
    self.confirmView.onConfirmCallback = ^{
        
        [[[[UIApplication sharedApplication].delegate window] viewWithTag:996]removeFromSuperview];
        [weakSelf.tabBarController setSelectedIndex:2];
        [weakSelf.navigationController popToRootViewControllerAnimated:true];
        
    };
    
    
    SHOW_SPINNER(self);
    self.payModel.oid = self.tripDetailModel.oid;

    
    [self.payModel loadWithCompletion:^(VZModel *model, NSError *error) {
        
        HIDE_SPINNER(weakSelf);
        UIView* v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kTPScreenWidth, kTPScreenHeight)];
        v.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        v.tag = 996;
        // 模糊化视图
        //            UIImage *uiimage = [self convertViewToImage:v];
        //            UIView* vc =[self blurryImage:uiimage withBlurLevel:3.0];
        [[[UIApplication sharedApplication].delegate window] addSubview:v];
        
        if (!error) {
            
            TOAST(weakSelf, @"支付成功!");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [weakSelf vz_postToChannel:kChannelNewOrder withObject:nil Data:nil];
                [weakSelf vz_postToChannel:kChannelNewMessage withObject:nil Data:nil];
                [self.confirmView.titleLabel setText:@"您已支付成功" ];
                [self.confirmView.descLabel setText:@"可以在旅程中查看您的预约"];
                [self.confirmView.confirmBtn setTitle:@"去到旅程看预定的服务" forState:UIControlStateNormal];
                [v addSubview:self.confirmView];
            });
        }
        else
        {
            TOAST_ERROR(weakSelf, error);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [weakSelf vz_postToChannel:kChannelNewOrder withObject:nil Data:nil];
                [weakSelf vz_postToChannel:kChannelNewMessage withObject:nil Data:nil];
                [self.confirmView.titleLabel setText:@"抱歉，您支付未成功" ];
                [self.confirmView.descLabel setText:@"您可以返回旅程重新完成支付"];
                [self.confirmView.confirmBtn setTitle:@"去到旅程看预定的服务" forState:UIControlStateNormal];
                [v addSubview:self.confirmView];

            });
            
        }
        
    }];
}
- (IBAction)wxpayAction:(id)sender {
    
    SHOW_SPINNER(self);
    self.payModel.oid = self.tripDetailModel.oid;
    
    __weak typeof(self) weakSelf = self;


    self.channel = @"wx";
    long long amount = [[self.tripCNYFeeLabel.text stringByReplacingOccurrencesOfString:@"." withString:@""] longLongValue];
    if (amount == 0) {
        return;
    }
    NSString *amountStr = [NSString stringWithFormat:@"%lld", amount];
    NSURL* url = [NSURL URLWithString:kUrl];
    NSMutableURLRequest * postRequest=[NSMutableURLRequest requestWithURL:url];
    
    NSDictionary* dict = @{
                           @"channel" : self.channel,
                           @"amount"  : amountStr
                           };
    NSData* data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *bodyData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [postRequest setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [self showAlertWait];
    [NSURLConnection sendAsynchronousRequest:postRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        HIDE_SPINNER(weakSelf);
        if (httpResponse.statusCode != 200) {
            TOAST_ERROR(weakSelf, connectionError);
            return;
        }
        if (connectionError != nil) {
            NSLog(@"error = %@", connectionError);
            TOAST_ERROR(weakSelf, connectionError);
            return;
        }
        NSString* charge = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"charge = %@", charge);
        dispatch_async(dispatch_get_main_queue(), ^{
            [Pingpp createPayment:charge viewController:weakSelf appURLScheme:kUrlScheme withCompletion:^(NSString *result, PingppError *error) {
                NSLog(@"completion block: %@", result);
                if (error == nil) {
                    NSLog(@"PingppError is nil");
                    TOAST(weakSelf, result);
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [weakSelf vz_postToChannel:kChannelNewOrder withObject:nil Data:nil];
                        [weakSelf vz_postToChannel:kChannelNewMessage withObject:nil Data:nil];
                        [weakSelf.navigationController popToRootViewControllerAnimated:true];
                    });
                } else {
                    NSLog(@"PingppError: code=%lu msg=%@", (unsigned  long)error.code, [error getMsg]);
                }

            }];
        });
    }];

}

- (IBAction)codepayAction:(id)sender {
    TPPayCodeViewController* vc = [[UIStoryboard storyboardWithName:@"TPPayCodeViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"tppaycode"];
    vc.oid = self.tripDetailModel.oid;
    [self.navigationController pushViewController:vc animated:true];
    
}

@end
 
