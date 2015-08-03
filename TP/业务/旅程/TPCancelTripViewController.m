//
//  TPCancelTripViewController.m
//  TP
//
//  Created by zhou li on 15/7/21.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPCancelTripViewController.h"
#import "TPCancelTripOrderModel.h"
#import "TPTripCancelledViewController.h"


@interface TPCancelTripViewController()

@property(nonatomic,strong) UIScrollView* scrollView;
@property(nonatomic,strong) UILabel* titleLabel;
@property(nonatomic,strong) UIImageView* addressIcon;
@property(nonatomic,strong) UILabel* addressLabel;
@property(nonatomic,strong) UIImageView* providerIcon;
@property(nonatomic,strong) UILabel* providerNameLabel;
@property(nonatomic,strong) UIButton* callBtn;
@property(nonatomic,strong) UITextView* reasonText;
@property(nonatomic,strong) UILabel* tipLabel;
@property(nonatomic,strong) UIButton* confirmBtn;

@property(nonatomic,assign) float m_curKeyboardHeight;

@property(nonatomic,strong)TPCancelTripOrderModel* cancelTripOrderModel;


@end


@implementation TPCancelTripViewController

////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods


- (void)loadView
{
    [super loadView];
    [self initViews];
    self.m_curKeyboardHeight = 0;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    tapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGesture];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = true;
    [MobClick beginLogPageView:@"TPCancelTripOrder"];
    //todo..
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //todo..
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"TPCancelTripOrder"];
    //todo..
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //todo..
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}
//
//- (void) viewDidLayoutSubviews {
//    CGRect viewBounds = self.view.bounds;
//    CGFloat topBarOffset = self.topLayoutGuide.length;
//    viewBounds.origin.y = topBarOffset * -1;
//    self.view.bounds = viewBounds;
//}


- (void)dealloc {
    
    //todo..
}


/////////////////////////////////
#pragma mark - setter and getter
- (TPCancelTripOrderModel* )cancelTripOrderModel
{
    if (!_cancelTripOrderModel) {
        _cancelTripOrderModel = [TPCancelTripOrderModel new];
    }
    return _cancelTripOrderModel;
}

/////////////////////////////////
#pragma mark - private method

- (void)initViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"取消旅程"];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.scrollView];
    
    self.titleLabel = [TPUIKit label:[UIColor colorWithRed:74 / 255.0f green:74 / 255.0f blue:74 / 255.0f alpha:1.0f] Font:[UIFont systemFontOfSize:19.0f]];
    self.titleLabel.text = self.tripDetailModel.serviceName;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.frame = CGRectMake(0.0f, 50.0f, self.view.vzWidth, 20.0f);
    [self.scrollView addSubview:self.titleLabel];
    
    self.addressIcon = [TPUIKit imageView];
    [self.addressIcon setImage:__image(@"trip_position.png")];
    self.addressIcon.frame = CGRectMake((self.view.vzWidth - 64.0f) / 2, self.titleLabel.vzBottom + 10.0f, 14.0f, 14.0f);
    [self.scrollView addSubview:self.addressIcon];
    
    self.addressLabel = [TPUIKit label:[UIColor colorWithRed:124 / 255.0f green:124 / 255.0f blue:124 / 255.0f alpha:1.0f] Font:[UIFont systemFontOfSize:13.0f]];
    self.addressLabel.text = self.tripDetailModel.serviceAdress;
    self.addressLabel.textAlignment = NSTextAlignmentCenter;
    self.addressLabel.frame = CGRectMake(self.addressIcon.vzRight + 5, self.addressIcon.vzTop + 2, 50.0f, 15.0f);
    [self.scrollView addSubview:self.addressLabel];
    
    self.providerIcon = [TPUIKit roundImageView:CGSizeMake(65.0f, 65.0f) Border:[UIColor whiteColor]];
    [self.providerIcon sd_setImageWithURL:__url(self.tripDetailModel.insiderHeadPic) placeholderImage:__image(@"girl.jpg")];
    self.providerIcon.frame = CGRectMake((self.view.vzWidth - 65.0f) / 2, self.addressIcon.vzBottom + 20.0f, 65.0f, 65.0f);
    [self.scrollView addSubview:self.providerIcon];
    
    self.providerNameLabel = [TPUIKit label:[UIColor colorWithRed:124 / 255.0f green:124 / 255.0f blue:124 / 255.0f alpha:1.0f] Font:[UIFont systemFontOfSize:15.0f]];
    self.providerNameLabel.text = self.tripDetailModel.insiderNickName;
    self.providerNameLabel.textAlignment = NSTextAlignmentCenter;
    self.providerNameLabel.frame = CGRectMake(0.0f, self.providerIcon.vzBottom + 10.0f, self.view.vzWidth, 18.0f);
    [self.scrollView addSubview:self.providerNameLabel];
    
    self.callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.callBtn.layer.cornerRadius = 10.0;
    self.callBtn.layer.borderWidth = 1.0;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    [self.callBtn setTitleColor: [TPTheme themeColor] forState:UIControlStateNormal];
    CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){36 / 255.0, 194 / 255.0, 213 / 255.0, 1});
    self.callBtn.layer.borderColor = borderColorRef;
    [self.callBtn addTarget:self action:@selector(call) forControlEvents:UIControlEventTouchUpInside];
    [self.callBtn setTitle:@"联系他" forState:UIControlStateNormal];
    self.callBtn.frame = CGRectMake((self.view.vzWidth - 105.0f) / 2, self.providerNameLabel.vzBottom + 15.0f, 105.0f, 44.0f);
    [self.scrollView addSubview:self.callBtn];
    
    self.reasonText = [[UITextView alloc] initWithFrame:CGRectMake(20.0f, self.callBtn.vzBottom + 40.0f, self.view.vzWidth - 40.0f, 120.0f)];
    self.reasonText.font = [UIFont systemFontOfSize:13.0f];
    self.reasonText.layer.cornerRadius = 6;
    self.reasonText.layer.masksToBounds = YES;
    self.reasonText.layer.borderColor = [UIColor colorWithRed:124 / 255.0f green:124 / 255.0f blue:124 / 255.0f alpha:1.0f].CGColor;
    self.reasonText.layer.borderWidth = 0.8;
    self.reasonText.returnKeyType = UIReturnKeyDefault;
    self.reasonText.keyboardType = UIKeyboardTypeDefault;
    [self.scrollView addSubview:self.reasonText];
    
    self.tipLabel = [TPUIKit label:[UIColor colorWithRed:124 / 255.0f green:124 / 255.0f blue:124 / 255.0f alpha:1.0f] Font:[UIFont systemFontOfSize:13.0f]];
    self.tipLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.tipLabel.numberOfLines = 0;
    self.tipLabel.text = @"取消操作在旅程开始48小时外，扣取费用的10%\n取消操作在旅程开始48小时内，扣取费用的50%\n取消操作在旅程开始24小时内，不予退款\n若有其他特殊原因，请联系脆饼";
    self.tipLabel.textAlignment = NSTextAlignmentLeft;
    self.tipLabel.frame = CGRectMake(20.0f, self.reasonText.vzBottom + 15.0f, self.view.vzWidth - 40.0f, 50.0f);
    [self.scrollView addSubview:self.tipLabel];
    
    self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.confirmBtn.backgroundColor = [UIColor colorWithRed:0 / 255.0f green:204 / 255.0f blue:221 / 255.0f alpha:1.0f];
    self.confirmBtn.frame = CGRectMake(15.0f, self.tipLabel.vzBottom + 10.0f, self.view.vzWidth - 30.0f, 44.0f);
    [self.confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [self.confirmBtn setTitle:@"确认取消" forState:UIControlStateNormal];
    [self.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.scrollView addSubview:self.confirmBtn];
    
    [self.scrollView setContentSize:CGSizeMake(self.view.vzWidth, self.confirmBtn.vzBottom + 70.0f)];
}

/////////////////////////////////
#pragma mark - setter

- (void)setTripDetailModel:(TPTripDetailModel *)tripDetailModel
{
    _tripDetailModel = tripDetailModel;
}

/////////////////////////////////
#pragma mark - button action

- (void)call
{
    
}

- (void)confirm
{

    //取消旅程
    self.cancelTripOrderModel.oid = self.tripDetailModel.oid;
    self.cancelTripOrderModel.reason = self.reasonText.text;
    SHOW_SPINNER(self);
    __weak typeof(self) weakSelf = self;
    [WCAlertView showAlertWithTitle:@"" message:@"确定要取消旅程吗?" customizationBlock:^(WCAlertView *alertView) {
        
    } completionBlock:^(NSUInteger buttonIndex, WCAlertView *alertView) {
        
        if (buttonIndex == 1) {
            [self.cancelTripOrderModel loadWithCompletion:^(VZModel *model, NSError *error) {
                HIDE_SPINNER(weakSelf);
                if (!error) {
                    TOAST(weakSelf, @"取消成功");
                    //通知列表刷新
                    [weakSelf vz_postToChannel:kChannelNewOrder withObject:nil Data:nil];
                    [weakSelf vz_postToChannel:kChannelNewMessage withObject:nil Data:nil];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        TPTripCancelledViewController *vc = [TPTripCancelledViewController new];
                        vc.tripDetailModel = self.tripDetailModel;
                        [self.navigationController pushViewController:vc animated:true];
                    });
                }
                else
                {
                    TOAST_ERROR(weakSelf, error);
                }
            }];

        }
        
    } cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    // todo
    
}

- (void)viewTapped
{
    [self.reasonText resignFirstResponder];
}

///////////////////////////////////
#pragma mark - notification

- (void)keyboardWillAppear:(NSNotification *)notification
{
    if ([self.reasonText isFirstResponder] == NO) {
        return;
    }
    
    NSTimeInterval time = [[notification userInfo][UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:time delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         CGRect keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
                         self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - (keyboardRect.size.height - self.m_curKeyboardHeight), self.view.frame.size.width, self.view.frame.size.height);
                         self.m_curKeyboardHeight = keyboardRect.size.height;
                     }
                     completion:nil];
}

- (void)keyboardWillDisappear:(NSNotification *)notification
{
    NSTimeInterval time = [[notification userInfo][UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:time delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + self.m_curKeyboardHeight, self.view.frame.size.width, self.view.frame.size.height);
                         self.m_curKeyboardHeight = 0.0f;
                     }
                     completion:nil];
}

@end
