  
//
//  TPDDInfoCell.m
//  TP
//
//  Created by moxin on 2015-06-02 22:45:43 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPDDInfoCell.h"
#import "TPDDInfoCellContainerView.h"

@interface TPDDInfoCell()

@property(nonatomic,strong) TPDDInfoCellContainerView* containerView;

@end

@implementation TPDDInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
       
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TPDDInfoCell" owner:self options:nil];
        self.containerView = (TPDDInfoCellContainerView *)[nib objectAtIndex:0]; // or if it exists, (MCQView *)[nib objectAtIndex:0];
        
        [self.contentView addSubview:self.containerView];
        
    }
    return self;
}

+ (CGFloat) tableView:(UITableView *)tableView variantRowHeightForItem:(id)item AtIndex:(NSIndexPath *)indexPath
{
    return 240;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.containerView.vzWidth = self.vzWidth;
    self.containerView.vzHeight = self.vzHeight;
  
  
}
@end
  
