//
//  TBCityHUDPicker.h
//  iCoupon
//
//  Created by moxin.xt on 13-12-23.
//  Copyright (c) 2013年 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol TBCityHUDPickerDelegate <NSObject>

@optional
- (void)onHUDPickerDidSelectedObject:(NSString*)str withIndex:(NSInteger)index;
- (void)onHUDPickerDidCancel;

@end


@interface TBCityHUDPicker : NSObject

@property(nonatomic,strong,readonly) NSString* tag;

+  (instancetype)sharedInstance;
+  (void)showPicker:(NSArray*)data Title:(NSString*)title Tag:(NSString* )tag Delegate:(id<TBCityHUDPickerDelegate>)delegate;
+  (void)hidePicker;

@end
