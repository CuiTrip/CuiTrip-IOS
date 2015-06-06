//
//  TPUtils.m
//  TP
//
//  Created by moxin on 15/6/3.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPUtils.h"

@implementation TPUtils

+ (UIViewController* )rootViewController
{
    return [[[[UIApplication sharedApplication] delegate] window] rootViewController];
}


static NSArray* list = nil;
+ (void)localCodesWithCompletion:(void(^)(NSArray* list))completion
{
    if (list.count > 0) {
        if (completion) {
            completion(list);
        }
    }else
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
            //获取支持的地区列表
            [SMS_SDK getZone:^(enum SMS_ResponseState state, NSArray *array)
             {
                 if (1 == state)
                 {
                     NSLog(@"get the area code sucessfully");
                     //区号数据
                     list = [array copy];
                     if (completion) {
                         dispatch_async(dispatch_get_main_queue(), ^{
                             completion(list);
                         });
                     }
                 }
                 else if (0 == state)
                 {
                     if (completion) {
                         dispatch_async(dispatch_get_main_queue(), ^{
                             completion(nil);
                         });
                     }
                 }
                 
             }];
            
        });
    }

}

@end
