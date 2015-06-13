//
//  ETImageMaskManagerCenter.h
//  ETShopping
//
//  Created by jackiedeng on 13-5-27.
//  Copyright (c) 2013年 etao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETImageMaskManagerCenter : NSObject

+ (ETImageMaskManagerCenter*)defaultCenter;

- (int)maskTypeCount;

- (UIImage*)maskCoverImageAtIndex:(int)index;

- (NSString*)maskTitleAtIndex:(int)index;

- (int)maskFilterCountInTheTypeOfIndex:(int)index;

- (UIImage*)maskFilterImageInTheType:(int)typeIndex filterIndex:(int)filterIndex;

@end
