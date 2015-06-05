//
//  VZStringBuilder.m
//  TP
//
//  Created by moxin on 15/6/4.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "VZStringBuilder.h"
#import <CoreText/CTFont.h>
#import <CoreText/CTStringAttributes.h>


bool vz_isCoreTextAttribute(NSString* coretextAttribute )
{
    static NSSet* coreTextSet;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        coreTextSet = [NSSet setWithObjects:(__bridge id)kCTForegroundColorAttributeName,
                              kCTForegroundColorFromContextAttributeName,
                              kCTForegroundColorAttributeName,
                              kCTStrokeColorAttributeName,
                              kCTUnderlineStyleAttributeName,
                              kCTVerticalFormsAttributeName,
                              kCTRunDelegateAttributeName,
                              kCTBaselineClassAttributeName,
                              kCTBaselineInfoAttributeName,
                              kCTBaselineReferenceInfoAttributeName,
                              kCTUnderlineColorAttributeName,
                              nil];

        
    });
    
    return [coreTextSet containsObject:coretextAttribute];
}
@implementation VZStringBuilder

@end
