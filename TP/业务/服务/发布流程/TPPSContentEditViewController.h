//
//  TPPSContentEditViewController.h
//  TP
//
//  Created by zhou li on 15/8/2.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPPSViewController.h"
#import "TPTripArrangementModel.h"
#import "TPDiscoveryDetailListModel.h"

@interface  TPPSContentEditViewController: TPPSViewController

@property(nonatomic,strong)TPTripArrangementModel *tripArrangementModel;
@property(nonatomic,strong)TPDiscoveryDetailListModel *discoveryDetailListModel;

@end