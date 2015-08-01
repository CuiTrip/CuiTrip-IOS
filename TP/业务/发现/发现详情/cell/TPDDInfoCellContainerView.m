//
//  TPDDInfoCellContainerView.m
//  TP
//
//  Created by moxin on 15/6/2.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPDDInfoCellContainerView.h"
#import "TPStarView.h"
#import "TPDDInfoItem.h"

@interface TPDDInfoCellContainerView()

@property (weak, nonatomic) IBOutlet UILabel *infoNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoAddressLabel;
@property (weak, nonatomic) IBOutlet UIButton *viewDetailBtn;
@property (weak, nonatomic) IBOutlet UIImageView *grayStarView;
@property (weak, nonatomic) IBOutlet UILabel *infoContentLabel;

@end

@implementation TPDDInfoCellContainerView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.viewDetailBtn.layer.cornerRadius = 5.0f;
    self.viewDetailBtn.layer.borderColor = [TPTheme themeColor].CGColor;
    self.viewDetailBtn.layer.borderWidth = 1.0f;
    [self.viewDetailBtn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self setScore:0.0];

}

- (void)onBtnClicked:(id)sender
{
    __weak typeof(self) weakSelf = self;
    if (self.callback) {
        self.callback(@"gotoServiceDetail",weakSelf.item);
    }
}

- (void)setItem:(TPDDInfoItem *)item
{
    [super setItem:item];
    
    self.infoNameLabel.text = item.name;
    self.infoAddressLabel.text=  item.address;

    NSString *string = @"";
    NSRange range = [item.desc rangeOfString:@"<div>"];
    if (range.length == 0) {
        string = item.desc;
    }
    else{
        string = [item.desc substringToIndex:range.location];
    }
    
    self.infoContentLabel.text = string;
    [self setScore:[item.score floatValue]];
}

- (void)setScore:(CGFloat)score
{
    UIImageView* starView = [TPStarView starViewWithCount:score];
    [self.grayStarView addSubview:starView];
    
}

@end
