  
//
//  TPDDCommentCell.m
//  TP
//
//  Created by moxin on 2015-06-02 22:48:00 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPDDCommentCell.h"
#import "TPDDCommentCellContainerView.h"

@interface TPDDCommentCell()

@property(nonatomic,strong)TPDDCommentCellContainerView* containerView;

@end

@implementation TPDDCommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //todo: add some UI code
        //todo: add some UI code
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TPDDCommentCell" owner:self options:nil];
        self.containerView = (TPDDCommentCellContainerView *)[nib objectAtIndex:0];
        __weak typeof(self) weakSelf = self;
        self.containerView.callback = ^(NSString* type, id item)
        {
             [weakSelf.delegate onCellComponentClickedAtIndex:weakSelf.indexPath Bundle:@{@"type":type,@"data":item?:[NSNull null]}];
        };
        
        [self.contentView addSubview:self.containerView];
    }
    return self;
}

+ (CGFloat) tableView:(UITableView *)tableView variantRowHeightForItem:(id)item AtIndex:(NSIndexPath *)indexPath
{
    return 185;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.containerView.vzHeight=  185;
    self.containerView.vzWidth = self.vzWidth;
  
  
}
@end
  
