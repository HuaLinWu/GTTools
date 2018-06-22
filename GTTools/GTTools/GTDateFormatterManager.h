//
//  NSDateFormatterManager.h
//  GTTools
//
//  Created by 吴华林 on 2018/6/20.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTDateFormatterManager : NSObject
@property(nonatomic,strong,class,readonly)NSDateFormatter *dateFormatter;

/**
 根据NSDate 转化成字符串默认的时区为UTC，LocaleIdentifier为en_US_POSIX（已经处理时间差的问题）

 @param date 需要转化的时间
 @param dateFormat 时间格式（yyyy 表示年，MM：表示月，dd 表示日，hh：表示12小时制，HH表示24小时制，mm 表示分，ss表示秒，.SSS 表示秒小数的位数）
 @return 时间字符串
 */
+ (NSString *)gt_stringFromDate:(NSDate *)date dateFormat:(NSString *)dateFormat;

/**
 根据NSDate 转化成字符串

 @param date 需要转化的时间（已经处理时间差的问题）
 @param dateFormat 时间格式（yyyy 表示年，MM：表示月，dd 表示日，hh：表示12小时制，HH表示24小时制，mm 表示分，ss表示秒，.SSS 表示秒小数的位数）
 @param locale 位置
 @param timeZone 时区
 @return 时间字符串
 */
+ (NSString *)gt_stringFromDate:(NSDate *)date dateFormat:(NSString *)dateFormat locale:(NSLocale *)locale timeZone:(NSTimeZone *)timeZone;

/**
 获取当前日期的字符串（将以yyyy-MM-dd HH:mm:ss 格式返回）
 */
+ (NSString *)gt_stringFromNowDate;

/**
 根据规定的时间格式返回当前的时间字符串
 @param dateFormatter 时间格式
 */
+ (NSString *)gt_stringFromNowDateWithDateFormatter:(NSString *)dateFormatter;
@end
