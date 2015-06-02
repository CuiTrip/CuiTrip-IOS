  
//
//  TPDiscoveryListItem.m
//  TP
//
//  Created by moxin on 2015-06-01 19:38:20 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPDiscoveryListItem.h"

@interface TPDiscoveryListItem()

@end

@implementation TPDiscoveryListItem

- (void)autoKVCBinding:(NSDictionary *)dictionary
{
    [super autoKVCBinding:dictionary];
    
    //todo...
    if (self.userName.length > 0 && self.userCity.length > 0) {
        self.attributedUserString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@   %@",self.userName,self.userCity]];
        [self.attributedUserString addAttributes:@{NSForegroundColorAttributeName:[TPTheme themeColor]} range:NSMakeRange(0, self.userName.length)];
    }
    else
        self.attributedUserString = [[NSMutableAttributedString alloc]initWithString:@""];
   
    
    
}

@end

