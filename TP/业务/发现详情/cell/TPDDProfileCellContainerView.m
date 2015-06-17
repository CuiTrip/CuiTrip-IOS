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

}

- (void)setItem:(TPDDProfileItem* )item
{
    [super setItem:item];
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

@end
