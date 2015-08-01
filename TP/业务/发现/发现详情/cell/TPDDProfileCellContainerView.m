//
//  TPDDProfileCellContainerView.m
//  TP
//
//  Created by moxin on 15/6/3.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPDDProfileCellContainerView.h"
#import "TPDDProfileItem.h"

@interface TPDDProfileCellContainerView()

@property (weak, nonatomic) IBOutlet UIImageView *avatarIcon;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userDescLabel;
@property (weak, nonatomic) IBOutlet UILabel *registerDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *identifierLabel;
@property (weak, nonatomic) IBOutlet UILabel *professionalLabel;
@property (weak, nonatomic) IBOutlet UILabel *hobbiesLabel;
@property (weak, nonatomic) IBOutlet UILabel *languageLabel;


@end

@implementation TPDDProfileCellContainerView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.avatarIcon.image = __image(@"girl.jpg");
    self.avatarIcon.layer.cornerRadius = 0.5*self.avatarIcon.vzWidth;
    self.avatarIcon.layer.masksToBounds = true;
    
    self.avatarIcon.userInteractionEnabled = YES;
    UIGestureRecognizer *singleTap = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(headPicClicked:)];
    [self.avatarIcon addGestureRecognizer:singleTap];

}

- (void)headPicClicked:(id)sender
{
    __weak typeof(self) weakSelf = self;
    if (self.callback) {
        self.callback(@"gotoUserIntroduce",weakSelf.item);
    }
}

- (void)setItem:(TPDDProfileItem* )item
{
    [super setItem:item];
    
    [self.avatarIcon sd_setImageWithURL:__url(item.avatar) placeholderImage:__image(@"girl.jpg")];
    self.userNameLabel.text = item.insiderName;
    self.userDescLabel.text = item.insiderSign;
    self.registerDateLabel.text = item.registerTime;
    self.identifierLabel.text = [item.status integerValue] == 0 ? @"已认证":@"未认证";
    self.professionalLabel.text = item.career.length == 0?@"暂无":item.career;
    self.hobbiesLabel.text = item.hobby.length == 0?@"暂无":item.hobby;
    self.languageLabel.text = item.language == 0?@"暂无":item.language;
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

@end
