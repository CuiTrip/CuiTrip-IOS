//
//  TPDDTripCellContainerView.m
//  TP
//
//  Created by moxin on 15/6/3.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPDDTripCellContainerView.h"
#import "TPDDTripItem.h"


@interface TPDDTripCellContainerView()
@property (weak, nonatomic) IBOutlet UILabel *viewDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tripLength;
@property (weak, nonatomic) IBOutlet UILabel *tripTime;
@property (weak, nonatomic) IBOutlet UILabel *tripMemberLabel;
@property (weak, nonatomic) IBOutlet UILabel *tripFeeLabel;
@property (weak, nonatomic) IBOutlet UILabel *licenceLabel;


@end

@implementation TPDDTripCellContainerView

- (void)awakeFromNib
{
    self.tripFeeLabel.userInteractionEnabled=true;
    self.tripFeeLabel.tag = 100;
    [self.tripFeeLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onLabelTapped:)]];
    
    self.licenceLabel.userInteractionEnabled = true;
    self.licenceLabel.tag = 101;
    [self.licenceLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onLabelTapped:)]];
    
    self.viewDateLabel.userInteractionEnabled = true;
    self.viewDateLabel.tag = 102;
    [self.viewDateLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onLabelTapped:)]];
}

- (void)onLabelTapped:(UITapGestureRecognizer* )gesture
{
    NSInteger tag = gesture.view.tag;
    
    if (tag == 100) {
        
        self.callback(@"gotoFee",self.item);
    }
    
    if (tag == 101) {
        
        self.callback(@"gotoLicence",self.item);
    }
    
    if (tag == 102) {
        
        self.callback(@"gotoDatePicker",self.item);
    }
}

- (void)setItem:(TPDDTripItem* )item
{
    [super setItem:item];
    
    self.tripLength.text = item.tripTimeLength;
    self.tripTime.text = item.tripTime;
    self.tripMemberLabel.text = item.tripPeopleNum;
    
    
}

@end
