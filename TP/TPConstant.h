//
//  TPConstant.h
//  TP
//
//  Created by moxin on 15/6/1.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#ifndef TP_TPConstant_h
#define TP_TPConstant_h

#define kTPScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kTPScreenHeight [UIScreen mainScreen].bounds.size.height

#define kTPWidthWithMargin(x)  (kTPScreenWidth - x*2)
#define kTPHeightWithMargin(y) (kTPScreenHeight - y*2)

#define kTPLoginSuccess @"kTPLoginSuccess"
#define kTPLoginFailure @"kTPLoginFailure"



#define __observeNotify(x,y)   [[NSNotificationCenter defaultCenter] addObserver:self selector:x name:y object:nil]
#define __removeNotifyObserver [[NSNotificationCenter defaultCenter] removeObserver:self]

#define __image(x) [UIImage imageNamed:(x)]
#define __url(x) [NSURL URLWithString:(x)]

#endif
