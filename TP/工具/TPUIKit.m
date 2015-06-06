//
//  TPUIKit.m
//  TP
//
//  Created by moxin on 15/6/2.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPUIKit.h"


@interface TPExceptionView:UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *actionBtn;
@property(nonatomic,copy) void(^callback)(void);

@end


@implementation TPExceptionView

- (IBAction)onAction:(id)sender {
    
    if (self.callback) {
        self.callback();
    }

}


@end

@implementation TPUIKit

+ (UILabel* )label:(UIColor* )color Font:(UIFont* )font;
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = font;
    label.textColor = color;
    return label;

}

+ (UIImageView* )imageView
{
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = true;
    imageView.userInteractionEnabled = true;
    return imageView;
}

+ (UIImageView* )roundImageView:(CGSize)sz Border:(UIColor* )color
{
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:(CGRect){0,0,sz}];
    imageView.layer.cornerRadius = 0.5*sz.width;
    imageView.layer.borderColor = color.CGColor;
    imageView.layer.borderWidth = 1.0f;
    imageView.layer.masksToBounds=  true;
    imageView.userInteractionEnabled = true;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.userInteractionEnabled = true;
    
    return imageView;
}

+ (UIView* )defaultExceptionView:(NSString* )title SubTitle:(NSString* )subTitle btnTitle:(NSString* )btn Callback:(void(^)(void))c
{
    int w = kTPScreenWidth;
    int h = kTPScreenHeight;
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ExceptionView" owner:self options:nil];
    TPExceptionView* excptionView = (TPExceptionView *)[nib objectAtIndex:0];
    excptionView.vzWidth = w;
    excptionView.vzHeight = h;
    excptionView.titleLabel.text = title;
    excptionView.subTitleLabel.text = subTitle;
    [excptionView.actionBtn setTitle:btn forState:UIControlStateNormal];
    excptionView.callback=c;
    
    return excptionView;
}


+ (void )showRequestErrorView:(UIView* )v retryCallback:(void(^)(void))c
{
    [[v viewWithTag:997] removeFromSuperview];
    UIView*  sev = [self defaultExceptionView:@"获取数据失败" SubTitle:@"请检查网络连接" btnTitle:@"点击重试" Callback:^{
        
        if(c)
        {
            c();
        }
        
    }];
    sev.tag = 997;
    [v addSubview:sev];
    [v bringSubviewToFront:sev];


}


+ (void )showSessionErrorView:(UIView* )v loginSuccessCallback:(void(^)(void))c
{
    [[v viewWithTag:999]removeFromSuperview];
     UIView*  sev = [self defaultExceptionView:@"您还没有登陆" SubTitle:@"请点击下面按钮登录" btnTitle:@"点击登录" Callback:^{
           
            [TPLoginManager showLoginViewControllerWithCompletion:^(NSError *error) {
               
                [self removeExceptionView:v];
                
                if (c) {
                    c();
                }
            }];
            
        }];
    sev.tag = 999;
    [v addSubview:sev];
    [v bringSubviewToFront:sev];
}


+ (void)removeExceptionView:(UIView* )v
{
    [[v viewWithTag:997] removeFromSuperview];
    [[v viewWithTag:998] removeFromSuperview];
    [[v viewWithTag:999] removeFromSuperview];
}

@end
