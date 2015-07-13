//
//  TPDDCommentCellContainerView.m
//  TP
//
//  Created by moxin on 15/6/3.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPDDCommentCellContainerView.h"
#import "TPDDCommentItem.h"

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
    [self.viewMoreBtn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onBtnClicked:(id)sender
{
    __weak typeof(self) weakSelf = self;
    if (self.callback) {
        self.callback(@"gotoComment",weakSelf.item);
    }
}


- (void)setItem:(TPDDCommentItem* )item
{
    [super setItem:item];
    
    self.commentNumLabel.text = [NSString stringWithFormat:@"共%@条评论",item.commentNum];
    self.commentTextView.text = item.comment;

}
@end
