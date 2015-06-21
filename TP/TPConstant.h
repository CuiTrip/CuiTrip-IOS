//
//  TPConstant.h
//  TP
//
//  Created by moxin on 15/6/1.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#ifndef TP_TPConstant_h
#define TP_TPConstant_h

#define sms_appKey @"7dc26c72f524"
#define sms_appSecret @"d9ff9f18a74898d61821af51b29683e2"

#define um_appKey @"557fbf7b67e58e5a4f003a31"
#define um_appSecret @""

#define _API_ @"http://58.96.175.29:8080/baseservice/"
//#define _API_ @"http://192.168.1.110:8080/baseservice/"

#define kTPCacheKey_User @"TP_USER"
#define kTPCacheKey_APNS @"TPAPNS"

#define kOnePixel (1/[UIScreen mainScreen].scale)

#define kTPScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kTPScreenHeight [UIScreen mainScreen].bounds.size.height

#define kTPWidthWithMargin(x)  (kTPScreenWidth - x)/2
#define kTPHeightWithMargin(y) (kTPScreenHeight - y)/2

#define kTPNofityMessageSwitchIdentity @"kTPNofityMessageSwitchIdentity"
#define kTPNotifyMessageLogout @"kTPNotifyMessageLogout"
#define kTPNotifyMessageLoginSuccess @"kTPLoginSuccess"
#define kTPNotifyMessageLoginFailure @"kTPLoginFailure"

#define ft(x) [UIFont systemFontOfSize:(x)]
#define bft(x) [UIFont boldSystemFontOfSize:(x)]

#define HEXCOLORA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:a]
#define HEXCOLOR(rgbValue) HEXCOLORA(rgbValue, 1.0)


#define SHOW_SPINNER(x)    dispatch_async(dispatch_get_main_queue(), ^{[x.view makeToastActivity];})
#define HIDE_SPINNER(x)    dispatch_async(dispatch_get_main_queue(), ^{[x.view hideToastActivity];})
#define TOAST(this,x)  [this.view makeToast:x duration:2.0f position:CSToastPositionCenter]
#define TOAST_ERROR(this,x)  [this.view makeToast:[NSString stringWithFormat:@"%@",x.userInfo[NSLocalizedDescriptionKey]] duration:1.0f position:CSToastPositionCenter]

#define __notify(x)  [[NSNotificationCenter defaultCenter]postNotificationName:x object:nil]
#define __observeNotify(x,y)   [[NSNotificationCenter defaultCenter] addObserver:self selector:x name:y object:nil]
#define __removeNotifyObserver [[NSNotificationCenter defaultCenter] removeObserver:self]

#define __image(x) [UIImage imageNamed:(x)]
#define __url(x) [NSURL URLWithString:(x)]

#define __story(x,y) \
    [[UIStoryboard storyboardWithName:x bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:y];

#define IsStringValid(_str) (_str && [_str isKindOfClass:[NSString class]] && ([_str length] > 0))
#define IsArrayValid(_array) (_array && [_array isKindOfClass:[NSArray class]] && ([_array count] > 0))
#define IsDictionaryValid(__dic) (__dic && [__dic isKindOfClass:[NSDictionary class]] && ([__dic count] > 0))
#define IsDelegateValid(__aDelegate, __aSelector)   (__aDelegate && [__aDelegate respondsToSelector:__aSelector])
#define $(...) ((NSString *)[NSString stringWithFormat:__VA_ARGS__])

#define vzBool(x,v) ([x isKindOfClass:[NSNumber class]] || [x isKindOfClass:[NSString class]])? [x boolValue]:v

#endif
