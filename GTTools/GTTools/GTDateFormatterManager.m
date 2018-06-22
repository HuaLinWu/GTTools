//
//  NSDateFormatterManager.m
//  GTTools
//
//  Created by 吴华林 on 2018/6/20.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "GTDateFormatterManager.h"
#import "GTNullFilter.h"
@implementation GTDateFormatterManager
+ (NSString *)gt_stringFromDate:(NSDate *)date dateFormat:(NSString *)dateFormat {
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    return [self gt_stringFromDate:date dateFormat:dateFormat locale:locale timeZone:timeZone];
}
+ (NSString *)gt_stringFromDate:(NSDate *)date dateFormat:(NSString *)dateFormat locale:(NSLocale *)locale timeZone:(NSTimeZone *)timeZone {
    if([GTNullFilter isNullForObject:date] || [GTNullFilter isNullForObject:dateFormat]) {
        return @"";
    }
    
    self.dateFormatter.locale = locale;
    self.dateFormatter.dateFormat = dateFormat;
    self.dateFormatter.timeZone = timeZone;
    NSDate *localDate = [self gt_processingDate:date];
    return [self.dateFormatter stringFromDate:localDate];
}
+ (NSString *)gt_stringFromNowDate {
    NSString *dateFormatter = @"yyyy-MM-dd HH:mm:ss";
    return [self gt_stringFromNowDateWithDateFormatter:dateFormatter];
}
+ (NSString *)gt_stringFromNowDateWithDateFormatter:(NSString *)dateFormatter {
    NSDate *date = [NSDate date];
    return [self gt_stringFromDate:date dateFormat:dateFormatter];
}
#pragma mark private_method
+ (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    if(!dateFormatter) {
        dispatch_once(&onceToken, ^{
            dateFormatter = [[NSDateFormatter alloc] init];
        });
    }
    return dateFormatter;
}
+ (NSDate *)gt_processingDate:(NSDate *)date {
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    return localeDate;
}
@end
