  
//
//  TPPublishCommentModel.h
//  TP
//
//  Created by moxin on 2015-06-11 19:56:48 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//


  
#import "VZHTTPModel.h"

@interface TPPublishCommentModel : VZHTTPModel

@property(nonatomic,strong)NSString* oid;
@property(nonatomic,strong)NSString* content;
@property(nonatomic,strong)NSString* score;

@end

