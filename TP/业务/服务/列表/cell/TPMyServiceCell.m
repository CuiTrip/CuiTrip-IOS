//
//  TPMyServiceCell.m
//  TP
//
//  Created by zhou li on 15/7/13.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPMyServiceCell.h"
#import "TPMyServiceListItem.h"
#import "TPMyServiceListViewDelegate.h"

@interface TPMyServiceCell()

@property(nonatomic,strong) UIView* colorView;
@property(nonatomic,strong) UIView* containerView;
@property(nonatomic,strong) UIImageView* poster;
@property(nonatomic,strong) UIImageView* icon;
@property(nonatomic,strong) UILabel* posterNameLabel;
@property(nonatomic,strong) UILabel* shadeLabel;
@property(nonatomic,strong) UIButton* editBtn;
@property(nonatomic,strong) UILabel* delReasonLabel;
@property(nonatomic,strong) UILabel* delTipLabel;
@property(nonatomic,strong) CAGradientLayer* gradientLayer;

@end


@implementation TPMyServiceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.backgroundColor = [TPTheme bgColor];
        //todo: add some UI code
        self.colorView = [[UIView alloc]initWithFrame:CGRectZero];
        self.colorView.backgroundColor = [UIColor colorWithRed:(255 / 255.0f) green:(251 / 255.0f) blue:(244 / 255.0f) alpha:1.0f];
        [self.contentView addSubview:self.colorView];
        
        self.containerView = [[UIView alloc] initWithFrame:CGRectZero];
        self.containerView.layer.masksToBounds = true;
        self.containerView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.containerView];
        
        self.poster = [TPUIKit imageView];
        self.icon = [TPUIKit roundImageView:CGSizeMake(45, 45) Border:[UIColor whiteColor]];
        self.posterNameLabel = [TPUIKit label:[UIColor whiteColor] Font:[UIFont systemFontOfSize:18.0f]];
        
        self.gradientLayer = [CAGradientLayer layer];
        self.gradientLayer.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithWhite:0.8 alpha:0.0].CGColor,(id)[UIColor colorWithWhite:0.0 alpha:0.8].CGColor,nil];
        
        [self.containerView addSubview:self.poster];
        [self.containerView.layer addSublayer:self.gradientLayer];
        [self.containerView addSubview:self.icon];
        [self.containerView addSubview:self.posterNameLabel];
    }
    return self;
}

+ (CGFloat) tableView:(UITableView *)tableView variantRowHeightForItem:(id)item AtIndex:(NSIndexPath *)indexPath
{
    TPMyServiceListItem* serviceItem = (TPMyServiceListItem *)item;
    if ([serviceItem.checkStatus intValue] != 2) {
        return 170;
    }
    return 200;
}

- (void)setItem:(TPMyServiceListItem *)item
{
    [super setItem:item];
    [self.poster sd_setImageWithURL:__url(item.backPic) placeholderImage:__image(@"default_list.jpg")];
    [self.icon sd_setImageWithURL:__url([TPUser avatar]) placeholderImage:__image(@"girl.jpg")];
    self.posterNameLabel.text = item.name;
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:[item.extInfo dataUsingEncoding:NSUTF8StringEncoding]options:NSJSONReadingAllowFragments error:nil];
    if ([jsonObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = (NSDictionary *)jsonObject;
        self.delReasonLabel.text = [NSString stringWithFormat:@"未通过原因：%@",[dict objectForKey:@"refuseReason"]];
    }
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.colorView.frame = CGRectMake(0, 0, self.vzWidth, 10);
    self.containerView.frame = CGRectMake(0, 10, self.vzWidth, 160);
    self.poster.frame = CGRectMake(0, 0, self.contentView.vzWidth, 160);
    self.icon.frame = CGRectMake(10, self.poster.vzHeight - 50, 45, 45);
    self.gradientLayer.frame = CGRectMake(0, self.containerView.vzHeight - 44, self.vzWidth, 44);
    self.posterNameLabel.frame = CGRectMake(self.icon.vzRight + 10, self.icon.vzOrigin.y + 15, self.vzWidth - self.icon.vzRight - 120, 20);
    TPMyServiceListItem* serviceItem = (TPMyServiceListItem *)self.item;
    
    //cell复用时服务状态可能会改变，将一些非通过的view先remove掉
    [self resetViews];
    
    if ([serviceItem.checkStatus intValue] == 0) {
        //待审核的service，加黑色遮罩
        if (self.shadeLabel == nil) {
            self.shadeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
            self.shadeLabel.backgroundColor = [UIColor colorWithRed:(61 / 255.0f) green:(61 / 255.0f) blue:(61 / 255.0f) alpha:0.8f];
            self.shadeLabel.font = [UIFont systemFontOfSize:18.0f];
            self.shadeLabel.textColor = [UIColor colorWithRed:(255 / 255.0f) green:(255 / 255.0f) blue:(255 / 255.0f) alpha:1.0f];
            self.shadeLabel.textAlignment = NSTextAlignmentCenter;
            self.shadeLabel.text = @"审核中...";
        }
        [self.containerView addSubview: self.shadeLabel];
        self.shadeLabel.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
    }
    else if ([serviceItem.checkStatus intValue] == 1) {
        //已审核的service，加编辑按钮
        if (self.editBtn == nil) {
            self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.editBtn addTarget:(TPMyServiceListViewDelegate *)self.delegate action:@selector(editMyServiceCal) forControlEvents:UIControlEventTouchUpInside];
            [self.editBtn setImage:__image(@"trip_cal.png") forState:UIControlStateNormal];
        }
        [self.containerView addSubview:self.editBtn];
        self.editBtn.frame = CGRectMake(self.poster.vzRight - 10.0f - 44.0f, self.poster.vzHeight - 44.0f, 44.0f, 44.0f);
    }
    else if([serviceItem.checkStatus intValue] == 2){
        //未通过的service，增加未通过原因和删除按钮
        if (self.delReasonLabel == nil) {
            self.delReasonLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            self.delReasonLabel.backgroundColor = [UIColor colorWithRed:(255 / 255.0f) green:(0 / 255.0f) blue:(88 / 255.0f) alpha:0.8f];
            self.delReasonLabel.font = [UIFont systemFontOfSize:13.0f];
            self.delReasonLabel.textColor = [UIColor colorWithRed:(255 / 255.0f) green:(255 / 255.0f) blue:(255 / 255.0f) alpha:1.0f];
            self.delReasonLabel.textAlignment = NSTextAlignmentLeft;
        }
        if (self.delTipLabel == nil) {
            self.delTipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            self.delTipLabel.backgroundColor = [UIColor clearColor];
            self.delTipLabel.font = [UIFont systemFontOfSize:13.0f];
            self.delTipLabel.textColor = [UIColor colorWithRed:(255 / 255.0f) green:(255 / 255.0f) blue:(255 / 255.0f) alpha:1.0f];
            self.delTipLabel.textAlignment = NSTextAlignmentLeft;
            self.delTipLabel.text = @"审核未通过";
        }
        [self.contentView addSubview:self.delReasonLabel];
        [self.contentView addSubview:self.delTipLabel];
        self.delReasonLabel.frame = CGRectMake(0, self.containerView.vzHeight + 10, self.containerView.frame.size.width, 30.0f);
        self.delTipLabel.frame = CGRectMake(self.containerView.vzWidth - 80, self.posterNameLabel.frame.origin.y + 10, 80, 30.0f);
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark ------------ private method


- (void)resetViews{
    [self.shadeLabel removeFromSuperview];
    [self.editBtn removeFromSuperview];
    [self.delReasonLabel removeFromSuperview];
    [self.delTipLabel removeFromSuperview];
}

@end