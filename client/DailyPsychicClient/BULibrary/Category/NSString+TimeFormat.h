//
//  NSString+TimeFormat.h
//  pbuTRYYClient
//
//  Created by zhanghe on 2017/4/14.
//  Copyright © 2017年 李鑫浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TimeFormat)

///yyyy年MM月dd日 HH:mm 根据时间戳返回一个指定时间格式的字符串
+ (NSString *)GetTimeWithTimeFormat:(NSString *)timeFormat argTime:(NSString *)argTime;

///根据指定时间格式返回当前时间字符串
+ (NSString*)GetCurrentTimesWithFormat:(NSString *)timeFormat;

///根据指定时间格式返回时间字符串
+ (NSString*)GetTimes:(NSDate *)aDate WithFormat:(NSString *)timeFormat;

///根据时间戳判断是否是今天
+ (BOOL)isTodayCompareWithTime:(NSString *)argTime;

///返回时间戳  argTime 的格式应跟timeFormat一致
+ (NSString *)GetTimeStampWithTimeFormat:(NSString *)timeFormat argTime:(NSString *)argTime;

//传入今天的时间，返回明天的时间
+ (NSString *)GetTomorrowDay:(NSDate *)aDate WithTimeFormat:(NSString *)timeFormat;

//将字符串转成NSDate类型
+ (NSDate *)GetDateFromString:(NSString *)dateString WithTimeFormat:(NSString *)timeFormat;

//比较两个日期大小
+(int)compareDate:(NSString*)startDate withDate:(NSString*)endDate;

//获取当前时间的时间戳
+ (NSString *)getCurrentTimestamp;

/**
 *  获取网络当前时间
 */
+ (NSDate *)GetInternetDate;

/**
 *  获取当前时间
 */
+ (NSString *)getTimeWithTimeFormatSting:(NSString *)timeStampString;

/**
 *  根据时间戳返回年月日
 */
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString;
/**
 *  返回当前是周几
 */
+ (NSInteger)getCurrentWeek;
@end
