  
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

#define kUrlScheme      wx_appId
#define kUrl            [_API_ stringByAppendingPathComponent:@"getCharge"]

@interface TPPayViewController()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
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
@property (nonatomic,strong) NSString* deviceIp;

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


//- (TPPayModel *)payModel
//{
//    if (!_payModel) {
//        _payModel = [TPPayModel new];
//        _payModel.key = @"__TPPayModel__";
//    }
//    return _payModel;
//}



////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods

- (void)loadView
{
    [super loadView];
    //todo..
    [self setTitle:@"支付"];
    
    // 适配底部不能拉到底的情况
//    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//    }
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
    
    CGSize containerSize = self.scrollView.frame.size;
    CGSize contentSize = [self.allview sizeThatFits:containerSize];
    
    CGRect frame = self.allview.frame;
    frame.size.height = MAX(contentSize.height, containerSize.height);
    
    self.allview.frame = frame;
    self.scrollView.contentSize = frame.size;
    
    [self.scrollView scrollRectToVisible:self.allview.frame animated:YES];

    self.titleLabel.text = self.tripDetailModel.serviceName;
    [self.imageView sd_setImageWithURL:__url(self.tripDetailModel.insiderHeadPic) placeholderImage:__image(@"default_details.jpg")];
    NSData *sDate = [TPUtils dateWithString:self.tripDetailModel.serviceDate forFormat:nil];
    self.tripDateLabel.text = [TPUtils fullDateFormatString:sDate];
    self.tripNumberLabel.text = [self.tripDetailModel.buyerNum stringByAppendingString:@"人"];
    self.tripFeeLabel.text = self.tripDetailModel.servicePrice;
    self.tripMoneyTypeLabel.text = ([self.tripDetailModel.moneyType isEqual:@"TWD"])?@"新台币":@"人民币";
    self.tripCNYFeeLabel.text = self.tripDetailModel.orderPrice;
    
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

// 适配顶端和状态栏重叠的问题
//- (void) viewDidLayoutSubviews {
//    CGRect viewBounds = self.view.bounds;
//    CGFloat topBarOffset = self.topLayoutGuide.length;
//    viewBounds.origin.y = topBarOffset * -1;
//    self.view.bounds = viewBounds;
//}

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


- (IBAction)alipayAction:(id)sender {
    
    self.channel = @"alipay";
    SHOW_SPINNER(self);
    __weak typeof(self) weakSelf = self;
    self.deviceIp = @"0.0.0.0";
    
    [TPUtils getWANIPAddressWithCompletion:^(NSString *IPAddress) {
        if ([weakSelf.deviceIp isEqualToString:IPAddress]) {
            [TPUtils getLANIPAddressWithCompletion:^(NSString *IPAddress) {
                weakSelf.deviceIp = IPAddress;
                NSDictionary* dict = @{
                                       @"channel" : self.channel,
                                       @"orderId" : self.oid,
                                       @"clientIp": weakSelf.deviceIp,
                                       @"payCurrency": weakSelf.tripDetailModel.payCurrency
                                       };
                
                [self toPay:dict];
            }];
        }
    }];
    
    
    
}

- (IBAction)wxpayAction:(id)sender {
    
    __weak typeof(self) weakSelf = self;
    self.oid = self.tripDetailModel.oid;
    self.channel = @"wx";
    self.deviceIp = @"0.0.0.0";
    
    [TPUtils getWANIPAddressWithCompletion:^(NSString *IPAddress) {
        if ([weakSelf.deviceIp isEqualToString:IPAddress]) {
            [TPUtils getLANIPAddressWithCompletion:^(NSString *IPAddress) {
                weakSelf.deviceIp = IPAddress;
                NSDictionary* dict = @{
                                       @"channel" : self.channel,
                                       @"orderId" : self.oid,
                                       @"clientIp": weakSelf.deviceIp,
                                       @"payCurrency": weakSelf.tripDetailModel.payCurrency
                                       };
                [self toPay:dict];
            }];
        }
    }];
    
    
}

- (IBAction)codepayAction:(id)sender {
    TPPayCodeViewController* vc = [[UIStoryboard storyboardWithName:@"TPPayCodeViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"tppaycode"];
    vc.oid = self.tripDetailModel.oid;
    [self.navigationController pushViewController:vc animated:true];
    
}

- (void)toPay:(NSDictionary*) dict
{
    __weak typeof(self) weakSelf = self;
    SHOW_SPINNER(self);
    
    NSURL* url = [NSURL URLWithString:kUrl];
    NSMutableURLRequest * postRequest=[NSMutableURLRequest requestWithURL:url];
    
    NSData* data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *bodyData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [postRequest setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
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
        
        NSDictionary *dataObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSString* code = dataObj[@"code"];
        if ([code integerValue] != 0 ) {
            TOAST(weakSelf, dataObj[@"msg"]);
            return;
        }
        NSDictionary* chargeDic = dataObj[@"result"];
        NSData *chargeData = [NSJSONSerialization dataWithJSONObject:chargeDic
                                                             options:0
                                                               error:nil];
        NSString* charges = [[NSString alloc] initWithData:chargeData encoding:NSUTF8StringEncoding];
        
        NSLog(@"charge = %@", charges);
        dispatch_async(dispatch_get_main_queue(), ^{
            [Pingpp createPayment:charges
                   viewController:weakSelf
                     appURLScheme:kUrlScheme
                   withCompletion:^(NSString *result, PingppError *error) {
                       NSLog(@"completion block: %@", result);
                       
                       if ([result isEqualToString:@"success"] && error == nil) {
                           NSLog(@"PingppError is nil");
                           TOAST(weakSelf, result);
                           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                               [weakSelf vz_postToChannel:kChannelNewOrder withObject:nil Data:nil];
                               [weakSelf vz_postToChannel:kChannelNewMessage withObject:nil Data:nil];
                               [weakSelf initResultSubView:@"success"];
//                               [weakSelf.navigationController popToRootViewControllerAnimated:true];
                           });
                       } else {
                           [weakSelf initResultSubView:@"error"];
                           NSLog(@"PingppError: code=%lu msg=%@", (unsigned  long)error.code, [error getMsg]);
                       }
                       
                   }];
        });
    }];
    
}

- (void)initResultSubView:(NSString*) result
{
    __weak typeof(self) weakSelf = self;
    
    SHOW_SPINNER(self);
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TPPaySubView" owner:self options:nil];
    self.confirmView = (TPPaySubView *)[nib objectAtIndex:0];
    self.confirmView.vzWidth = 300;
    self.confirmView.vzHeight = 160;
    self.confirmView.vzOrigin = CGPointMake((CGRectGetWidth(self.view.bounds)-300)/2, (CGRectGetHeight(self.view.bounds) - 160)/2);
    self.confirmView.layer.cornerRadius  = 8.0f;
    self.confirmView.layer.masksToBounds = true;

    self.confirmView.onConfirmCallback = ^{

        [[[[UIApplication sharedApplication].delegate window] viewWithTag:996]removeFromSuperview];
        [weakSelf.tabBarController setSelectedIndex:2];
        [weakSelf.navigationController popToRootViewControllerAnimated:true];

    };

    UIView* v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kTPScreenWidth, kTPScreenHeight)];
    v.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    v.tag = 996;
    // 模糊化视图
    //            UIImage *uiimage = [self convertViewToImage:v];
    //            UIView* vc =[self blurryImage:uiimage withBlurLevel:3.0];
    [[[UIApplication sharedApplication].delegate window] addSubview:v];

    if ([result isEqualToString: @"success"]) {
        HIDE_SPINNER(weakSelf);

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
        HIDE_SPINNER(weakSelf);

        TOAST(weakSelf, @"支付失败!");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            [weakSelf vz_postToChannel:kChannelNewOrder withObject:nil Data:nil];
            [weakSelf vz_postToChannel:kChannelNewMessage withObject:nil Data:nil];
            [self.confirmView.titleLabel setText:@"抱歉，您支付未成功" ];
            [self.confirmView.descLabel setText:@"您可以返回旅程重新完成支付"];
            [self.confirmView.confirmBtn setTitle:@"去到旅程看预定的服务" forState:UIControlStateNormal];
            [v addSubview:self.confirmView];

        });
        
    }

}

@end
 
