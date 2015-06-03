  
//
//  TPDDProfileCell.m
//  TP
//
//  Created by moxin on 2015-06-02 22:48:12 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPDDProfileCell.h"
#import "TPDDProfileCellContainerView.h"

@interface TPDDProfileCell()

@property(nonatomic,strong) TPDDProfileCellContainerView* containerView;

@end

@implementation TPDDProfileCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //todo: add some UI code
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TPDDProfileCell" owner:self options:nil];
        self.containerView = (TPDDProfileCellContainerView *)[nib objectAtIndex:0];
        [self.contentView addSubview:self.containerView];

    
        
    }
    return self;
}

+ (CGFloat) tableView:(UITableView *)tableView variantRowHeightForItem:(id)item AtIndex:(NSIndexPath *)indexPath
{
    return 400;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
  
    self.containerView.vzHeight = 400;
    self.containerView.vzWidth = self.vzWidth;
}


@end
  
