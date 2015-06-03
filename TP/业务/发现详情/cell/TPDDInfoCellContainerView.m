//
//  TPDDInfoCellContainerView.m
//  TP
//
//  Created by moxin on 15/6/2.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPDDInfoCellContainerView.h"

@interface TPDDInfoCellContainerView()

@property (weak, nonatomic) IBOutlet UILabel *infoNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoAddressLabel;
@property (weak, nonatomic) IBOutlet UIView *startView;
@property (weak, nonatomic) IBOutlet UITextView *infoContentLabel;
@property (weak, nonatomic) IBOutlet UIButton *viewDetailBtn;

@end

@implementation TPDDInfoCellContainerView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.viewDetailBtn.layer.cornerRadius = 5.0f;
    self.viewDetailBtn.layer.borderColor = [TPTheme themeColor].CGColor;
    self.viewDetailBtn.layer.borderWidth = 1.0f;
    
    [self.viewDetailBtn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onBtnClicked:(id)sender
{
    __weak typeof(self) weakSelf = self;
    if (self.callback) {
        self.callback(@"gotoServiceDetail",weakSelf.item);
    }
}

@end
