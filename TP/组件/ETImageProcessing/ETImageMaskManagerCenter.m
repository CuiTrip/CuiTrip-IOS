//
//  ETImageMaskManagerCenter.m
//  ETShopping
//
//  Created by jackiedeng on 13-5-27.
//  Copyright (c) 2013年 etao. All rights reserved.
//

#import "ETImageMaskManagerCenter.h"

#define kMaskTitle          @"title"
#define kMaskArray          @"maskArray"
#define kMaskCoverImage     @"maskCoverImage"
#define kMaskImage          @"maskImage"
#define kMaskCenter         @"maskCenter"
#define kMaskAnchorPoint    @"maskAnchorPoint"

@implementation ETImageMaskManagerCenter
{
    NSArray         * _masks;
    NSString        * _configPath;
}

+ (ETImageMaskManagerCenter*)defaultCenter
{
    static ETImageMaskManagerCenter * sManager = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sManager = [[ETImageMaskManagerCenter alloc] init];
    });
    
    return sManager;
}

- (void)loadConfig
{
    if(!_configPath)
    {
        _configPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"mask_config.plist"];
        
    }
    
    _masks = [NSArray arrayWithContentsOfFile:_configPath];
    
    if(_masks)
    {
        NSLog(@"%@",_masks);
    }



}

- (id)init
{
    if(self = [super init])
    {
        [self loadConfig];
    }
    
    return self;
}

- (int)maskTypeCount
{
    return [_masks count];
}

- (int)maskFilterCountInTheTypeOfIndex:(int)index
{
    
   return [[[_masks objectAtIndex:index] objectForKey:kMaskArray] count];
    
}

- (UIImage*)maskFilterImageInTheType:(int)typeIndex filterIndex:(int)filterIndex
{
    NSString * maskFileName = [[[_masks objectAtIndex:typeIndex] objectForKey:kMaskArray] objectAtIndex:filterIndex];
    
    //return [UIImage imageNamed:maskFileName];
    
    return [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:maskFileName]];
}

- (UIImage*)maskCoverImageAtIndex:(int)index
{
    NSString * coverIcon = [[_masks objectAtIndex:index] objectForKey:kMaskCoverImage];
    
    return [UIImage imageNamed:coverIcon];
}

- (NSString*)maskTitleAtIndex:(int)index
{
    NSString * title = [[_masks objectAtIndex:index] objectForKey:kMaskTitle];
    
    return title;
}

- (void)createMaskConfig
{
    NSMutableArray * masks = [NSMutableArray array];
    
    for(int j = 0; j < 3; j++)
    {
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        
        [dict setValue:@"origin" forKey:@"title"];
        
        [dict setValue:[NSNumber numberWithInt:3] forKey:@"maskNumber"];
        
        [dict setValue:@"icon.png" forKey:@"maskCoverImage"];
        
        NSMutableArray * maskArray = [NSMutableArray array];
        
        for(int i = 0; i < 3;i ++)
        {
            NSMutableDictionary * maskDict = [NSMutableDictionary dictionary];
            
            
            [maskDict setValue:@"{0.5,0.5}" forKey:@"maskCenter"];
            [maskDict setValue:@"{1,1}" forKey:@"maskAnchorPoint"];
            [maskDict setValue:@"icon.png" forKey:@"maskImage"];
            
            [maskArray addObject:maskDict];
        }
        
        [dict setValue:maskArray forKey:@"maskArray"];
        
        [masks addObject:dict];
    }
    
    NSString * path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"mask_config.plist"];
    
    if([masks writeToFile:path atomically:YES])
    {
        NSLog(@"write ok %@",path);
    }

}
@end
