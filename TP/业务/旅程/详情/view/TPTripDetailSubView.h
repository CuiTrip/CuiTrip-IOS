
//
//  TPTripDetailSubView.h
//  TP
//
//  Created by moxin on 2015-06-07 21:28:19 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPTripDetailSubView.h"
#import "TPTripDetailModel.h"

@protocol TripSubViewDelegate <NSObject>

- (void)goToUser;

@end


@interface TPTripDetailSubView : UIView

@property(nonatomic,strong)TPTripDetailModel* tripDetailModel;
@property(nonatomic,strong)id<TripSubViewDelegate> delegate;

@end

