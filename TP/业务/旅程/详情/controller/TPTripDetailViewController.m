  
//
//  TPTripDetailViewController.m
//  TP
//
//  Created by moxin on 2015-06-07 21:28:19 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPTripDetailViewController.h"
#import "TPPublishCommentViewController.h"
#import "TPConfirmTripOrderModel.h"
#import "TPCancelTripOrderModel.h"
#import "TPTripDetailModel.h" 

@interface TPTripDetailViewController()

@property (weak, nonatomic) IBOutlet UIView *bkView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tripDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tripNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *tripFeeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tripStatusLabel;
@property (weak, nonatomic) IBOutlet UIButton *actionBtn;

@property(nonatomic,strong)TPTripDetailModel *tripDetailModel;
@property(nonatomic,strong)TPConfirmTripOrderModel* confirmTripOrderModel;
@property(nonatomic,strong)TPCancelTripOrderModel* cancelTripOrderModel;

@end

@implementation TPTripDetailViewController


//////////////////////////////////////////////////////////// 
#pragma mark - setters 



//////////////////////////////////////////////////////////// 
#pragma mark - getters 

   
- (TPTripDetailModel *)tripDetailModel
{
    if (!_tripDetailModel) {
        _tripDetailModel = [TPTripDetailModel new];
        _tripDetailModel.key = @"__TPTripDetailModel__";
    }
    return _tripDetailModel;
}


- (TPConfirmTripOrderModel* )confirmTripOrderModel
{
    if (!_confirmTripOrderModel) {
        _confirmTripOrderModel = [TPConfirmTripOrderModel new];
    }
    return _confirmTripOrderModel;
}

- (TPCancelTripOrderModel* )cancelTripOrderModel
{
    if (!_cancelTripOrderModel) {
        _cancelTripOrderModel = [TPCancelTripOrderModel new];
    }
    return _cancelTripOrderModel;
}


////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods

- (void)loadView
{
    [super loadView];
    
    [self setTitle:@"旅程信息"];
    
    self.imageView.layer.cornerRadius = 0.5*self.imageView.vzWidth;
    self.imageView.layer.masksToBounds = true;
    self.imageView.clipsToBounds = true;
    self.imageView.layer.borderWidth = 2.0f;
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    //todo..
    self.bkView.layer.borderColor = [TPTheme grayColor].CGColor;
    self.bkView.layer.borderWidth = 0.5;
    
    self.actionBtn.layer.cornerRadius = 5.0f;
    self.actionBtn.layer.masksToBounds = true;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //todo..
    if([TPUser type] == kCustomer)
    {
        if (self.status == kWillBegin) {
            self.tripStatusLabel.hidden = true;
            self.actionBtn.hidden = false;
            [self.actionBtn setTitle:@"取消旅程" forState:UIControlStateNormal];
        }
        else
        {
            self.tripStatusLabel.hidden = false;
            self.tripStatusLabel.text = @"旅程已经结束";
            self.actionBtn.hidden = false;
            [self.actionBtn setTitle:@"去评价" forState:UIControlStateNormal];
        }
    }
    else
    {
        if (self.status == kWillBegin) {
            self.tripStatusLabel.hidden = true;
            self.actionBtn.hidden = false;
            self.actionBtn.hidden = false;
            self.actionBtn.vzTop -= 30;
            [self.actionBtn setTitle:@"确认" forState:UIControlStateNormal];
        }
        else
        {

        }
    }
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
    [self.imageView sd_setImageWithURL:__url(self.tripDetailModel.insiderHeadPic) placeholderImage:__image(@"girl.jpg")];
    self.nameLabel.text = self.tripDetailModel.insiderNickName;
    self.descLabel.text = self.tripDetailModel.insiderSign;
    self.tripDateLabel.text = self.tripDetailModel.serviceDate;
    self.tripNumberLabel.text = self.tripDetailModel.buyerNum;
    self.tripFeeLabel.text = self.tripDetailModel.orderPrice;

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
    
    if ([TPUser type] == kCustomer) {
        
        if (self.status == kFinish) {
            //完成去评价
            
            TPPublishCommentViewController* vc = [[UIStoryboard storyboardWithName:@"TPPublishCommentViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"tppublishcomment"];
            [self.navigationController pushViewController:vc animated:true];
            
        }
        else
        {
            //取消旅程
            self.cancelTripOrderModel.oid = self.oid;
            
            SHOW_SPINNER(self);
            __weak typeof(self) weakSelf;
            [self.cancelTripOrderModel loadWithCompletion:^(VZModel *model, NSError *error) {
               
                HIDE_SPINNER(weakSelf);
                if (!error) {
                    TOAST(weakSelf, @"取消成功");
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [weakSelf.navigationController popViewControllerAnimated:true];
                    });
                }
                else
                {
                    TOAST_ERROR(weakSelf, error);
                }
            }];
            
        }
    }
    else{
     
        if (self.status == kFinish) {
            
            //去确认行程
            self.confirmTripOrderModel.oid = self.oid;
            
            SHOW_SPINNER(self);
            __weak typeof(self) weakSelf;
            [self.confirmTripOrderModel loadWithCompletion:^(VZModel *model, NSError *error) {
                
                HIDE_SPINNER(weakSelf);
                if (!error) {
                    TOAST(weakSelf, @"确认成功");
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [weakSelf.navigationController popViewControllerAnimated:true];
                    });
                }
                else
                {
                    TOAST_ERROR(weakSelf, error);
                }
                
                
            }];
            
            
        }
        
        
    }

    
}

@end
 
