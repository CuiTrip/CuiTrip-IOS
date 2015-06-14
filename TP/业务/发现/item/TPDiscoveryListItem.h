  
//
//  TPDiscoveryListItem.h
//  TP
//
//  Created by moxin on 2015-06-14 13:55:04 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "VZListItem.h"

@interface TPDiscoveryListItem : VZListItem
  
@property(nonatomic,strong)NSString *serviceNo;  
@property(nonatomic,strong)NSString *sid;  
@property(nonatomic,strong)NSString *serviceName;  
@property(nonatomic,strong)NSString *address;  
@property(nonatomic,strong)NSString *insiderHeadPic;  
@property(nonatomic,strong)NSString *insiderNickName;
@property(nonatomic,strong)NSString* serviceBackPic;
@property(nonatomic,strong)NSMutableAttributedString* attributedUserString;
@end

  
