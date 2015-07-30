//
//  TPPSAccessoryView.m
//  TP
//
//  Created by zhou li on 15/7/30.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPPSAccessoryView.h"

@interface TPPSAccessoryView()

@end

@implementation TPPSAccessoryView

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //todo...
        UIImage* itemImage = [UIImage imageNamed:@"trip_key-down.png"];
        itemImage = [itemImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.keyDownBtn = [[UIBarButtonItem alloc] initWithImage:itemImage style:UIBarButtonItemStylePlain target:nil action:nil];
        itemImage = [UIImage imageNamed:@"trip_addpic.png"];
        itemImage = [itemImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.addImageBtn = [[UIBarButtonItem alloc] initWithImage:itemImage style:UIBarButtonItemStylePlain target:nil action:nil];
        
        
        UIBarButtonItem *flexSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        [self setItems:[NSArray arrayWithObjects:flexSpacer, self.keyDownBtn, flexSpacer, self.addImageBtn, flexSpacer, nil] animated:YES];
    }
    
    return self;
}

@end
