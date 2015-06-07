//
//  TBCityHUDPicker.m
//  iCoupon
//
//  Created by moxin.xt on 13-12-23.
//  Copyright (c) 2013年 Taobao.com. All rights reserved.
//

#import "TBCityHUDPicker.h"

@interface TBCityHUDPicker()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIWindow*     _HUDwindow;
    UIView*       _containerView;
    NSString*     _currentSelectedString;
    NSInteger     _currentSelectedIndex;
    NSArray*      _dataSource;
    NSString*     _title;
}

@property(nonatomic,weak) id<TBCityHUDPickerDelegate> delegate;


@end

@implementation TBCityHUDPicker

+ (instancetype)sharedInstance
{
    static TBCityHUDPicker* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [TBCityHUDPicker new];
    });
    return instance;
}



- (id)init
{
    self = [super init];
    
    if (self) {
        
       
        // CGRect windowRect = [UIApplication sharedApplication].keyWindow.frame;
        _HUDwindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _HUDwindow.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3f];
        _HUDwindow.windowLevel = UIWindowLevelStatusBar+1;
        _HUDwindow.hidden = YES;
        

        
    }
    return self;
}

- (void)dealloc
{
    _delegate = nil;
}


+  (void)showPicker:(NSArray*)data Title:(NSString*)title Tag:(NSString* )tag Delegate:(id<TBCityHUDPickerDelegate>)delegate
{
    TBCityHUDPicker* picker = [self sharedInstance];
    picker.delegate     = delegate;
    picker->_dataSource = [data copy];
    picker->_title      = [title copy];
    picker->_tag        = [tag copy];
    [picker showPickerInternal];

}
+ (void)hidePicker
{
    [[self sharedInstance] hidePickerInternal];

}
- (void)showPickerInternal
{
    [self reset];
    //capture
    
    
     //毛玻璃效果
  //  UIImage* bluredImg = [self bluredImage];
    UIImageView* imgv = [[UIImageView alloc]initWithFrame:_HUDwindow.bounds];
   // imgv.image = bluredImg;
    imgv.userInteractionEnabled = YES;
    [imgv addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onSelfTapped:)]];
    [_HUDwindow addSubview:imgv];
     

    [self layoutSubViews];
    _HUDwindow.hidden = NO;
    [_HUDwindow bringSubviewToFront:_containerView];
    int w = [UIScreen mainScreen].bounds.size.width;
    int h = [UIScreen mainScreen].bounds.size.height;
    int p_h = CGRectGetHeight(_containerView.frame);
    _containerView.frame = CGRectMake(0, h,w, p_h);
    [UIView animateWithDuration:0.3 animations:^{
        
        _containerView.frame = CGRectMake(0, h-p_h+20, w, p_h);
        
        
    } completion:^(BOOL finished) {
        
        
    }];
}

- (void)hidePickerInternal
{
    [_HUDwindow bringSubviewToFront:_containerView];
    int w = [UIScreen mainScreen].bounds.size.width;
    int h = [UIScreen mainScreen].bounds.size.height;
    int p_h = CGRectGetHeight(_containerView.frame);
    _containerView.frame = CGRectMake(0, h-p_h, w, p_h);
    [UIView animateWithDuration:0.3 animations:^{
        
        _containerView.frame = CGRectMake(0, h,w, p_h);
        
        
    } completion:^(BOOL finished) {
        
        [self removeSubViews];
        _HUDwindow.hidden = YES;
    }];
}

- (void)layoutSubViews
{
    _containerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 244)];
    _containerView.backgroundColor = [UIColor clearColor];
    [_HUDwindow addSubview:_containerView];
    
    int w = [UIScreen mainScreen].bounds.size.width;
    //add a headerview
    UIView* _pickerHeaderView = [[UIView alloc]initWithFrame:CGRectMake(-2, 0, w+4, 44)];
    _pickerHeaderView.backgroundColor = HEXCOLOR(0xFAFAFA);
    _pickerHeaderView.layer.borderColor =  HEXCOLOR(0x9B9B9B).CGColor;
    _pickerHeaderView.layer.borderWidth = 0.5f;
    
    CGSize titleSz = [_title sizeWithFont:[UIFont systemFontOfSize:14.0f]];
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake((w-titleSz.width)/2, 15, titleSz.width, titleSz.height)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:14.0f];
    label.textColor = HEXCOLOR(0x5F646E);
    label.text = _title;
    
    UIButton* cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 13, 35, 18)];
    cancelBtn.backgroundColor = [UIColor clearColor];
    [cancelBtn setTitleColor:HEXCOLOR(0xFA383A) forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [cancelBtn addTarget:self action:@selector(onCacnelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* comfirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(275, 13, 35, 18)];
    comfirmBtn.backgroundColor = [UIColor clearColor];
    [comfirmBtn setTitleColor:HEXCOLOR(0xFA383A) forState:UIControlStateNormal];
    [comfirmBtn setTitle:@"完成" forState:UIControlStateNormal];
    [comfirmBtn.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [comfirmBtn addTarget:self action:@selector(onConfirmBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [_pickerHeaderView addSubview:label];
    [_pickerHeaderView addSubview:cancelBtn];
    [_pickerHeaderView addSubview:comfirmBtn];
    [_containerView addSubview:_pickerHeaderView];
    
    //add a pickerview
    UIPickerView* _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 44, w, 200)];
    _pickerView.delegate   = self;
    _pickerView.dataSource = self;
    _pickerView.showsSelectionIndicator = YES;
    _pickerView.backgroundColor = [UIColor whiteColor];
    [_containerView addSubview:_pickerView];

}

- (void)removeSubViews
{
    //remove subviews
    [_containerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_containerView removeFromSuperview];
    _containerView = nil;

    //remove subviews from window
    for (UIView* v in _HUDwindow.subviews ) {
        [v removeFromSuperview];
    }
}

//- (UIImage*)bluredImage
//{
//    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
//    BOOL isRetina = [TBCityGlobal isRetinaDisplay];
//    if (isRetina) {
//        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
//    }
//    else {
//        UIGraphicsBeginImageContext(imageSize);
//    }
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    // Iterate over every window from back to front
//    for (UIWindow *window in [[UIApplication sharedApplication] windows])
//    {
//        if (![window respondsToSelector:@selector(screen)] || ([window screen] == [UIScreen mainScreen]))
//        {
//        
//            CGContextSaveGState(context);
//            CGContextTranslateCTM(context, [window center].x, [window center].y);
//            CGContextConcatCTM(context, [window transform]);
//            CGContextTranslateCTM(context,
//                                  -[window bounds].size.width * [[window layer] anchorPoint].x,
//                                  -[window bounds].size.height * [[window layer] anchorPoint].y);
//            
//            if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
//                [window drawViewHierarchyInRect:CGRectMake(0, 0, imageSize.width, imageSize.height) afterScreenUpdates:YES];
//            }
//            else
//                [[window layer] renderInContext:context];
//            
//            
//            CGContextRestoreGState(context);
//        }
//    }
//    
//    // Retrieve the screenshot image
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    //return image;
//    return  [image tbcity_applyDarkEffect];
//    
//}

- (void)reset
{
    _currentSelectedIndex = 0;
    _currentSelectedString = @"";
}

- (void)onSelfTapped:(id)sender
{
    [self hidePickerInternal];
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - callback
                                                                    
- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return _dataSource.count;
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return _dataSource[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    _currentSelectedString = _dataSource[row];
    _currentSelectedIndex  = row;
}

- (void)onCacnelBtnClicked:(UIButton*)btn
{
    [self hidePickerInternal];
    
    if([self.delegate respondsToSelector:@selector(onHUDPickerDidCancel)])
       [self.delegate onHUDPickerDidCancel];


}
- (void)onConfirmBtnClicked:(UIButton*)btn
{
    [self hidePickerInternal];
    
    if ([self.delegate respondsToSelector:@selector(onHUDPickerDidSelectedObject:withIndex:)]) {
        [self.delegate onHUDPickerDidSelectedObject:_currentSelectedString withIndex:_currentSelectedIndex];
    }

}
                
                                                                    
                                                                    
@end
