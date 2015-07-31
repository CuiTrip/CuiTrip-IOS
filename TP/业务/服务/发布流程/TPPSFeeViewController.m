//
//  TPPSFeeViewController.m
//  TP
//
//  Created by moxin on 15/6/11.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPPSFeeViewController.h"
#import "TBCityHUDPicker.h"


@interface TPPSFeeSelectionView:UIView

@property(nonatomic,strong)UIImageView* imageView;
@property(nonatomic,strong)UILabel* label;

@end

@implementation TPPSFeeSelectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.userInteractionEnabled = true;
        self.imageView = [TPUIKit imageView];
        self.imageView.image = __image(@"trip_down_g.png");
        self.imageView.vzSize = CGSizeMake(10, 10);
        self.imageView.vzOrigin = CGPointMake(10, (frame.size.height-10)/2);
        
        self.label = [TPUIKit label:[TPTheme themeColor] Font:ft(14.0f)];
        self.label.backgroundColor = [UIColor clearColor];
        self.label.vzOrigin = CGPointMake(self.imageView.vzRight+5, (frame.size.height-16)/2);
        self.label.vzSize = CGSizeMake(36, 16);
        self.label.text = @"CNY";
        
        UIView* sep = [[UIView alloc]initWithFrame:CGRectMake(self.label.vzRight+2, 4, kOnePixel, frame.size.height-8)];
        sep.backgroundColor = [TPTheme grayColor];
        [self addSubview:sep];
        
        [self addSubview:self.imageView];
        [self addSubview:self.label];
    }
    return self;
}

@end

@interface TPPSFeeViewController ()<TBCityHUDPickerDelegate>

@property(nonatomic,strong) NSString* moneyType;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation TPPSFeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.moneyType = @"CNY";
    
    self.descLabel.text = @"1. 本费⽤为发现者的基本服务费⽤，不包含双⽅任何⻔门票、餐饮、公共交通费⽤。\n\n2. 发现者在旅程中产⽣的门票、餐饮、私家车费⽤，均由旅⾏者承担。\n\n3. 其他可能产生的费用，双方自行沟通协调。";
    [self.descLabel sizeToFit];
    
    TPPSFeeSelectionView* selectionView = [[TPPSFeeSelectionView alloc]initWithFrame:CGRectMake(0, 0, 70, 44)];
    [selectionView addGestureRecognizer:[[ UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onMoneyTapClicked:)]];
    
    self.textField.layer.cornerRadius = 5.0f;
    self.textField.layer.borderColor = [TPTheme grayColor].CGColor;
    self.textField.layer.borderWidth = kOnePixel;
    self.textField.layer.masksToBounds = true;
    self.textField.leftView = selectionView;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)onNext
{
    if (self.textField.text.length == 0 || [self.textField.text integerValue] == 0) {
        TOAST(self, @"请输入价格");
        return NO;
    }
    else
    {
        if (self.callback) {
            
            RACTuple* tupe = RACTuplePack(self.textField.text,self.moneyType,nil);
            self.callback(tupe,nil);
        }
        return YES;
    }
}

- (void)onBack
{


}

- (void)onMoneyTapClicked:(id)sender
{
    [TBCityHUDPicker showPicker:@[@"人民币 CNY",@"新台币 TWD"] Title:@"货币种类" Tag:@"1" Delegate:self];
}

- (void)onHUDPickerDidSelectedObject:(NSString*)str withIndex:(NSInteger)index
{
    TPPSFeeSelectionView* selectionView = (TPPSFeeSelectionView* )self.textField.leftView;
    
    if (index == 0)
    {
        selectionView.label.text = @"CNY";
        self.moneyType = @"CNY";
    }
    else
    {
        selectionView.label.text = @"TWD";
        self.moneyType = @"TWD";
    }
}

@end
