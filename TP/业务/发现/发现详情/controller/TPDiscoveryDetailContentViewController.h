//
//  TPDiscoveryDetailContentViewController.h
//  TP
//
//  Created by moxin on 15/6/3.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "VZViewController.h"
#import "SETextView.h"
#import "O2OCommentImageListView.h"
#import "ETImageTransformTool.h"
#import "O2OCommentImageItem.h"
#import "O2OCommentImageView.h"


@interface TPDiscoveryDetailContentViewController : VZViewController<SETextViewDelegate, O2OCommentImageListViewDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property(nonatomic,strong)NSString* titleString;
@property(nonatomic,strong)NSString* content;
 
@end

