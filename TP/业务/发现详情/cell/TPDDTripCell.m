  
//
//  TPDDTripCell.m
//  TP
//
//  Created by moxin on 2015-06-02 22:47:45 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPDDTripCell.h"
#import "TPDDTripCellContainerView.h"

@interface TPDDTripCell()

@property(nonatomic,strong)TPDDTripCellContainerView* containerView;

@end

@implementation TPDDTripCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TPDDTripCell" owner:self options:nil];
        self.containerView = (TPDDTripCellContainerView *)[nib objectAtIndex:0];
        __weak typeof(self) weakSelf = self;
        self.containerView.callback = ^(NSString* type, id item)
        {
            if ([weakSelf.delegate respondsToSelector:@selector(onCellComponentClickedAtIndex:Bundle:)]) {
                
                [weakSelf.delegate onCellComponentClickedAtIndex:weakSelf.indexPath Bundle:@{@"type":type,@"data":item}];
            }
            
        };
        [self.contentView addSubview:self.containerView];
        
    }
    return self;
}

+ (CGFloat) tableView:(UITableView *)tableView variantRowHeightForItem:(id)item AtIndex:(NSIndexPath *)indexPath
{
    return 320;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.containerView.vzWidth  = self.vzWidth;
    self.containerView.vzHeight = 320;
  
  
}
@end
  
