//
//  TPUtils.m
//  TP
//
//  Created by moxin on 15/6/3.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPUtils.h"

#include <ifaddrs.h>
#include <arpa/inet.h>

static NSDictionary* localCodes = nil;

@implementation TPUtils

+ (UIViewController* )rootViewController
{
    return [[[[UIApplication sharedApplication] delegate] window] rootViewController];
}

+ (NSDictionary* )localCodes
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        localCodes = [NSDictionary dictionaryWithObjectsAndKeys:@"972", @"IL",
                      @"93", @"AF", @"355", @"AL", @"213", @"DZ", @"1", @"AS",
                      @"376", @"AD", @"244", @"AO", @"1", @"AI", @"1", @"AG",
                      @"54", @"AR", @"374", @"AM", @"297", @"AW", @"61", @"AU",
                      @"43", @"AT", @"994", @"AZ", @"1", @"BS", @"973", @"BH",
                      @"880", @"BD", @"1", @"BB", @"375", @"BY", @"32", @"BE",
                      @"501", @"BZ", @"229", @"BJ", @"1", @"BM", @"975", @"BT",
                      @"387", @"BA", @"267", @"BW", @"55", @"BR", @"246", @"IO",
                      @"359", @"BG", @"226", @"BF", @"257", @"BI", @"855", @"KH",
                      @"237", @"CM", @"1", @"CA", @"238", @"CV", @"345", @"KY",
                      @"236", @"CF", @"235", @"TD", @"56", @"CL", @"86", @"CN",
                      @"61", @"CX", @"57", @"CO", @"269", @"KM", @"242", @"CG",
                      @"682", @"CK", @"506", @"CR", @"385", @"HR", @"53", @"CU",
                      @"537", @"CY", @"420", @"CZ", @"45", @"DK", @"253", @"DJ",
                      @"1", @"DM", @"1", @"DO", @"593", @"EC", @"20", @"EG",
                      @"503", @"SV", @"240", @"GQ", @"291", @"ER", @"372", @"EE",
                      @"251", @"ET", @"298", @"FO", @"679", @"FJ", @"358", @"FI",
                      @"33", @"FR", @"594", @"GF", @"689", @"PF", @"241", @"GA",
                      @"220", @"GM", @"995", @"GE", @"49", @"DE", @"233", @"GH",
                      @"350", @"GI", @"30", @"GR", @"299", @"GL", @"1", @"GD",
                      @"590", @"GP", @"1", @"GU", @"502", @"GT", @"224", @"GN",
                      @"245", @"GW", @"595", @"GY", @"509", @"HT", @"504", @"HN",
                      @"36", @"HU", @"354", @"IS", @"91", @"IN", @"62", @"ID",
                      @"964", @"IQ", @"353", @"IE", @"972", @"IL", @"39", @"IT",
                      @"1", @"JM", @"81", @"JP", @"962", @"JO", @"77", @"KZ",
                      @"254", @"KE", @"686", @"KI", @"965", @"KW", @"996", @"KG",
                      @"371", @"LV", @"961", @"LB", @"266", @"LS", @"231", @"LR",
                      @"423", @"LI", @"370", @"LT", @"352", @"LU", @"261", @"MG",
                      @"265", @"MW", @"60", @"MY", @"960", @"MV", @"223", @"ML",
                      @"356", @"MT", @"692", @"MH", @"596", @"MQ", @"222", @"MR",
                      @"230", @"MU", @"262", @"YT", @"52", @"MX", @"377", @"MC",
                      @"976", @"MN", @"382", @"ME", @"1", @"MS", @"212", @"MA",
                      @"95", @"MM", @"264", @"NA", @"674", @"NR", @"977", @"NP",
                      @"31", @"NL", @"599", @"AN", @"687", @"NC", @"64", @"NZ",
                      @"505", @"NI", @"227", @"NE", @"234", @"NG", @"683", @"NU",
                      @"672", @"NF", @"1", @"MP", @"47", @"NO", @"968", @"OM",
                      @"92", @"PK", @"680", @"PW", @"507", @"PA", @"675", @"PG",
                      @"595", @"PY", @"51", @"PE", @"63", @"PH", @"48", @"PL",
                      @"351", @"PT", @"1", @"PR", @"974", @"QA", @"40", @"RO",
                      @"250", @"RW", @"685", @"WS", @"378", @"SM", @"966", @"SA",
                      @"221", @"SN", @"381", @"RS", @"248", @"SC", @"232", @"SL",
                      @"65", @"SG", @"421", @"SK", @"386", @"SI", @"677", @"SB",
                      @"27", @"ZA", @"500", @"GS", @"34", @"ES", @"94", @"LK",
                      @"249", @"SD", @"597", @"SR", @"268", @"SZ", @"46", @"SE",
                      @"41", @"CH", @"992", @"TJ", @"66", @"TH", @"228", @"TG",
                      @"690", @"TK", @"676", @"TO", @"1", @"TT", @"216", @"TN",
                      @"90", @"TR", @"993", @"TM", @"1", @"TC", @"688", @"TV",
                      @"256", @"UG", @"380", @"UA", @"971", @"AE", @"44", @"GB",
                      @"1", @"US", @"598", @"UY", @"998", @"UZ", @"678", @"VU",
                      @"681", @"WF", @"967", @"YE", @"260", @"ZM", @"263", @"ZW",
                      @"591", @"BO", @"673", @"BN", @"61", @"CC", @"243", @"CD",
                      @"225", @"CI", @"500", @"FK", @"44", @"GG", @"379", @"VA",
                      @"852", @"HK", @"98", @"IR", @"44", @"IM", @"44", @"JE",
                      @"850", @"KP", @"82", @"KR", @"856", @"LA", @"218", @"LY",
                      @"853", @"MO", @"389", @"MK", @"691", @"FM", @"373", @"MD",
                      @"258", @"MZ", @"970", @"PS", @"872", @"PN", @"262", @"RE",
                      @"7", @"RU", @"590", @"BL", @"290", @"SH", @"1", @"KN",
                      @"1", @"LC", @"590", @"MF", @"508", @"PM", @"1", @"VC",
                      @"239", @"ST", @"252", @"SO", @"47", @"SJ", @"963", @"SY",
                      @"886", @"TW", @"255", @"TZ", @"670", @"TL", @"58", @"VE",
                      @"84", @"VN", @"1", @"VG", @"1", @"VI", nil];

    });
    return localCodes;
}

static NSString* localCode=nil;
+ (NSString* )defaultLocalCode
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSLocale *locale = [NSLocale currentLocale];
        NSString* tt=[locale objectForKey:NSLocaleCountryCode];
        NSString* defaultCode=[[self localCodes] objectForKey:tt];
        localCode =  [NSString stringWithFormat:@"%@",defaultCode];

        
    });
    return localCode;
}

static NSString* defaultCountry=nil;
+ (NSString* )defaultCountry
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSLocale *locale = [NSLocale currentLocale];
        NSString* tt=[locale objectForKey:NSLocaleCountryCode];
        defaultCountry = [locale displayNameForKey:NSLocaleCountryCode value:tt];
    });
    return defaultCountry;
    
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
    }

}

+(NSError* )errorForHTTP:(NSDictionary* )dict;
{
    if (!dict) {
        return nil;
    }
    else
    {
        NSInteger code = [dict[@"code"] integerValue];
        NSString* msg = dict[@"msg"]?:@"";
        NSError* err = [NSError errorWithDomain:@"" code:code userInfo:@{NSLocalizedDescriptionKey:msg}];
        return err;
    }
    
}

+ (NSString* )monthDateFormatString:(NSDate* )date
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    calendar.firstWeekday = 1;
    calendar.minimumDaysInFirstWeek = 7;
    NSDateComponents* component = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSCalendarCalendarUnit fromDate:date];
    
    NSString* str = [[NSString alloc]initWithFormat:@"%ld年%ld月",component.year,component.month];
    
    return str;
}

+ (NSString* )fullDateFormatString:(NSDate* )date
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    calendar.firstWeekday = 1;
    calendar.minimumDaysInFirstWeek = 7;
    NSDateComponents* component = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSCalendarCalendarUnit fromDate:date];
    
    NSString* str = [[NSString alloc]initWithFormat:@"%ld年%ld月%ld日",component.year,component.month,component.day];
    
    return str;
}

+ (NSString* )timeFormatString:(NSDate* )date
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned units  =  NSCalendarCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    NSDateComponents* component = [calendar components:units fromDate:date];
    NSString* str = [[NSString alloc]initWithFormat:@"%ld:%ld",component.hour,component.minute];
    
    return str;
}

+ (NSDate *)dateWithString:(NSString *)dateString forFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];;
    if (format == nil) {
        format = @"YYYY-MM-dd HH:mm:ss";
    }
    [formatter setDateFormat:format];
    NSTimeZone* timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    
    return [formatter dateFromString:dateString];
}

+ (NSString *)stringWithDate:(NSDate *)date forFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];;
    if (format == nil) {
        format = @"YYYY-MM-dd HH:mm:ss";
    }
    [formatter setDateFormat:format];
    NSTimeZone* timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    
    return [formatter stringFromDate:date];
}

+ (NSString *)timeInfoWithDateString:(NSString *)dateString forFormat:(NSString *)format
{
    return [self timeInfoWithDate:[self dateWithString:dateString forFormat:format]];
}

+ (NSString *)timeInfoWithDate:(NSDate *)date
{
    NSDate *curDate = [NSDate date];
    
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    
    NSString* dateStr = [self stringWithDate:date forFormat:@"YYYY-MM-dd HH:mm"];
    NSString* timeStr = [dateStr componentsSeparatedByString:@" "][1];
    
    NSString *strCurDate = [TPUtils stringWithDate:curDate forFormat:@"yyyy-MM-dd"];
    NSDate *dateToday = [TPUtils dateWithString:strCurDate forFormat:@"yyyy-MM-dd"];
    NSTimeInterval timeToday = [dateToday timeIntervalSince1970];   // 这个就是今天0点的那个秒点整数了
    NSTimeInterval timeNow = [curDate timeIntervalSince1970];       // 现在的秒数
    NSTimeInterval nowSec = timeNow - timeToday;    // 现在是今天的第多少秒
    
    if (time < nowSec) { // 小于一天，也就是今天
        return timeStr;
    } else if (time < (nowSec + 3600 * 24)) { // 昨天
        return [NSString stringWithFormat:@"昨天 %@", timeStr];
    } else {
        return dateStr;
    }

}

+ (NSString *)shortTimeInfoWithDateString:(NSString *)dateString forFormat:(NSString *)format
{
    return [self shortTimeInfoWithDate:[self dateWithString:dateString forFormat:format]];
}

+ (NSString *)shortTimeInfoWithDate:(NSDate *)date
{
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned units  = NSMonthCalendarUnit|NSDayCalendarUnit|NSYearCalendarUnit| NSCalendarCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    
//    NSDate *date = [formatter dateFromString:dateString];
    NSDateComponents* dateCmp = [calendar components:units fromDate:date];
    
    NSDate *curDate = [NSDate date];
    NSDateComponents* curDateCmp = [calendar components:units fromDate:curDate];
    
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    
    
    int month = (int)(curDateCmp.month - dateCmp.month);
    int year = (int)(curDateCmp.year - dateCmp.year);
    int day = (int)(curDateCmp.day - dateCmp.day);
    
    NSTimeInterval retTime = 1.0;
    if (time < 3600) { // 小于一小时
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"@%.0f分钟前", retTime];
    } else if (time < 3600 * 24) { // 小于一天，也就是今天
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f小时前", retTime];
    } else if (time < 3600 * 24 * 2) {
        return @"昨天";
    }
    // 第一个条件是同年，且相隔时间在一个月内
    // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
    else if ((abs(year) == 0 && abs(month) <= 1)
             || (abs(year) == 1 && curDateCmp.month == 1 && dateCmp.month == 12))
    {
        int retDay = 0;
        if (year == 0) { // 同年
            if (month == 0) { // 同月
                retDay = day;
            }
        }
        
        if (retDay <= 0) {
            // 获取发布日期中，该月有多少天
            NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
            int totalDays = (int)range.length;
            
            // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
            retDay = (int)curDateCmp.day + (totalDays - (int)dateCmp.day);
        }
        
        return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
    }
    else
    {
        if (abs(year) <= 1) {
            if (year == 0) { // 同年
                return [NSString stringWithFormat:@"%d个月前", abs(month)];
            }
            
            // 隔年
            int month = (int)curDateCmp.month;
            int preMonth = (int)dateCmp.month;
            if (month == 12 && preMonth == 12) {// 隔年，但同月，就作为满一年来计算
                return @"1年前";
            }
            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];
        }
        
        return [NSString stringWithFormat:@"%d年前", abs(year)];
    }
    
    return @"1小时前";
}

+ (NSString* )money:(NSString* )money WithType:(NSString* )type
{
    NSString* moneyType = type;
    if (moneyType.length == 0) {
        moneyType = @"CNY";
    }
    return [NSString stringWithFormat:@"%@ %@元",moneyType,money];
}

+ (void)uploadImage:(NSString* )base64 WithCompletion:(void(^)(NSString* url,NSError* err))callback
{
    VZHTTPRequestConfig config = vz_defaultHTTPRequestConfig();
    config.requestMethod = VZHTTPMethodPOST;
    [[VZHTTPNetworkAgent sharedInstance] HTTP:[_API_ stringByAppendingString:@"upPic"]
                                requestConfig:config
                               responseConfig:vz_defaultHTTPResponseConfig()
                                       params:@{@"uid":[TPUser uid]?:@"",@"token":[TPUser token],@"picBase64":base64?:@"",@"picName":[NSUUID UUID].UUIDString}
                            completionHandler:^(VZHTTPConnectionOperation *connection, NSString *responseString, id responseObj, NSError *error) {
                                
                                if (!error) {
                                    NSInteger code = [responseObj[@"code"] integerValue];
                                    
                                    if (code == 0) {
                                        // TOAST([UIScreen mainScreen], @"更新成功!");
                                        NSDictionary* result = responseObj[@"result"];
                                        NSString* picURL = result[@"picurl"];
                                        
                                        if (callback) {
                                            callback(picURL,nil);
                                        }
                                    }
                                    else
                                    {
                                        NSError* err= [TPUtils errorForHTTP:responseObj];
                                        if (callback) {
                                            callback(nil,err);
                                        }
                                        //TOAST_ERROR(self, err);
                                    }
                                }
                                else
                                {
                                    //TOAST_ERROR(self, error);
                                    if (callback) {
                                        callback(nil,error);
                                    }
                                }
                                
                            }];

    
}

+ (NSString* )changeDateFormatString:(NSString *)dateString FromOldFmt:(NSString *)old ToNew:(NSString *)fmt{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:old];
    NSDate *date = [dateFormatter dateFromString:dateString];
    [dateFormatter setDateFormat:fmt];
    return [dateFormatter stringFromDate:date];
}

+ (void)getLANIPAddressWithCompletion:(void (^)(NSString *IPAddress))completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *IP = [self getIPAddress];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(IP);
            }
        });
    });
}

+ (void)getWANIPAddressWithCompletion:(void(^)(NSString *IPAddress))completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *IP = @"0.0.0.0";
        NSURL *url = [NSURL URLWithString:@"http://ifconfig.me/ip"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:3.0];
        
        NSURLResponse *response = nil;
        NSError *error = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        if (error) {
            NSLog(@"Failed to get WAN IP Address!\n%@", error);
//            [[[UIAlertView alloc] initWithTitle:@"获取外网 IP 地址失败" message:[error localizedFailureReason] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        } else {
            NSString *responseStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            IP = responseStr;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(IP);
        });
    });
}

#pragma mark -
///// http://zachwaugh.me/posts/programmatically-retrieving-ip-address-of-iphone/
+ (NSString *)getIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    return address;
}

// 判断是否包含表情
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}


@end
