//
//  TPDDCommentCellContainerView.m
//  TP
//
//  Created by moxin on 15/6/3.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPDDCommentCellContainerView.h"

@interface TPDDCommentCellContainerView()

@property (weak, nonatomic) IBOutlet UILabel *commentNumLabel;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;

@property (weak, nonatomic) IBOutlet UIButton *viewMoreBtn;



@end

@implementation TPDDCommentCellContainerView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.viewMoreBtn.layer.cornerRadius = 5.0f;
    self.viewMoreBtn.layer.borderColor = [TPTheme themeColor].CGColor;
    self.viewMoreBtn.layer.borderWidth = 1.0f;
    self.viewMoreBtn.clipsToBounds = true;
}

@end
