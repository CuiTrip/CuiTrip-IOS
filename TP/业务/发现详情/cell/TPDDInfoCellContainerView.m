//
//  TPDDInfoCellContainerView.m
//  TP
//
//  Created by moxin on 15/6/2.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPDDInfoCellContainerView.h"
#import "TPStarView.h"

@interface TPDDInfoCellContainerView()

@property (weak, nonatomic) IBOutlet UILabel *infoNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoAddressLabel;
@property (weak, nonatomic) IBOutlet UITextView *infoContentLabel;
@property (weak, nonatomic) IBOutlet UIButton *viewDetailBtn;
@property (weak, nonatomic) IBOutlet UIImageView *grayStarView;

@end

@implementation TPDDInfoCellContainerView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.viewDetailBtn.layer.cornerRadius = 5.0f;
    self.viewDetailBtn.layer.borderColor = [TPTheme themeColor].CGColor;
    self.viewDetailBtn.layer.borderWidth = 1.0f;
    [self.viewDetailBtn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView* imgv = [TPStarView starViewWithCount:3.5];
    [self.grayStarView addSubview:imgv];
}

- (void)onBtnClicked:(id)sender
{
    __weak typeof(self) weakSelf = self;
    if (self.callback) {
        self.callback(@"gotoServiceDetail",weakSelf.item);
    }
}

@end
