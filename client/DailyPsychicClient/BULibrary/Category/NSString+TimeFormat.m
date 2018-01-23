//
//  NSString+TimeFormat.m
//  pbuTRYYClient
//
//  Created by zhanghe on 2017/4/14.
//  Copyright © 2017年 李鑫浩. All rights reserved.
//

#import "NSString+TimeFormat.h"

@implementation NSString (TimeFormat)

///yyyy年MM月dd日 HH:mm
+ (NSString *)GetTimeWithTimeFormat:(NSString *)timeFormat argTime:(NSString *)argTime{
    
    NSDateFormatter *pDF = [[NSDateFormatter alloc]init];
    [pDF setDateFormat:timeFormat];
    NSDate *pDate = [NSDate dateWithTimeIntervalSince1970:[argTime floatValue]];
    return [NSString stringWithFormat:@"%@",[pDF stringFromDate: pDate]];
}

+(NSString*)GetCurrentTimesWithFormat:(NSString *)timeFormat{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:timeFormat];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
    
}
+ (NSString *)getTimeWithTimeFormatSting:(NSString *)timeStampString
{
    
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [objDateformat stringFromDate: date];
}


+ (BOOL)isTodayCompareWithTime:(NSString *)argTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSDate *pDate = [NSDate dateWithTimeIntervalSince1970:[argTime floatValue]];
    NSString *targetData = [NSString stringWithFormat:@"%@",[formatter stringFromDate: pDate]];
    
    if ([currentTimeString isEqualToString:targetData])
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}


///返回时间戳
+ (NSString *)GetTimeStampWithTimeFormat:(NSString *)timeFormat argTime:(NSString *)argTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:timeFormat];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:argTime];
    NSTimeInterval b = date.timeIntervalSince1970;
    return [NSString stringWithFormat:@"%.f",b];
}


//传入今天的时间，返回明天的时间
+ (NSString *)GetTomorrowDay:(NSDate *)aDate WithTimeFormat:(NSString *)timeFormat {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:aDate];
    [components setDay:([components day]+1)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:timeFormat];
    return [dateday stringFromDate:beginningOfWeek];
}


//将字符串转成NSDate类型
+ (NSDate *)GetDateFromString:(NSString *)dateString WithTimeFormat:(NSString *)timeFormat{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: timeFormat];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

///根据指定时间格式返回时间字符串
+ (NSString*)GetTimes:(NSDate *)aDate WithFormat:(NSString *)timeFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:timeFormat];
    NSString *dateTime = [formatter stringFromDate:aDate];
    return dateTime;
}

//比较两个日期大小
+(int)compareDate:(NSString*)startDate withDate:(NSString*)endDate{
    
    int comparisonResult;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date1 = [[NSDate alloc] init];
    NSDate *date2 = [[NSDate alloc] init];
    date1 = [formatter dateFromString:startDate];
    date2 = [formatter dateFromString:endDate];
    NSComparisonResult result = [date1 compare:date2];
//    NSLog(@"result==%ld",(long)result);
    switch (result)
    {
            //date02比date01大
        case NSOrderedAscending:
            comparisonResult = 1;
            break;
            //date02比date01小
        case NSOrderedDescending:
            comparisonResult = -1;
            break;
            //date02=date01
        case NSOrderedSame:
            comparisonResult = 0;
            break;
        default:
            NSLog(@"erorr dates %@, %@", date1, date2);
            break;
    }
    return comparisonResult;
}

//获取当前时间的时间戳
+ (NSString *)getCurrentTimestamp{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970] * 1000;
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeString;
}

/**
 *  获取网络当前时间
 */
+ (NSDate *)GetInternetDate
{
    NSString *urlString = @"http://m.www.baidu.com";
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    // 实例化NSMutableURLRequest，并进行参数配置
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString: urlString]];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request setTimeoutInterval: 2];
    [request setHTTPShouldHandleCookies:FALSE];
    [request setHTTPMethod:@"GET"];
    NSError *error = nil;
    NSHTTPURLResponse *response;
    [NSURLConnection sendSynchronousRequest:request
                          returningResponse:&response error:&error];
    // 处理返回的数据
    //    NSString *strReturn = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    if (error) {
        return [NSDate date];
    }
    NSLog(@"response is %@",response);
    NSString *date = [[response allHeaderFields] objectForKey:@"Date"];
    date = [date substringFromIndex:5];
    date = [date substringToIndex:[date length]-4];
    NSDateFormatter *dMatter = [[NSDateFormatter alloc] init];
    dMatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dMatter setDateFormat:@"dd MMM yyyy HH:mm:ss"];
    NSDate *netDate = [[dMatter dateFromString:date] dateByAddingTimeInterval:60*60*8];
    return netDate;
}
@end
