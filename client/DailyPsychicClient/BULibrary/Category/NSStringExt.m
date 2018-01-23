//
//  NSString+Emoji.m
//  pbuYaLianWuYeClient
//
//  Created by 1bu2bu on 16/9/7.
//  Copyright © 2016年 1bu2bu. All rights reserved.
//

#import "NSStringExt.h"

@implementation NSString (Emoji)

- (BOOL)stringContainsEmoji
{
    __block BOOL isEomji = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    isEomji = YES;
                }else if (0xd83e == hs){
                    isEomji = YES;
                }
            }
        } else {
            // non surrogate
            if (0x278b <= hs && hs <= 0x2792) {
                isEomji = NO;
            } else if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                isEomji = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                isEomji = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                isEomji = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                isEomji = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                isEomji = YES;
            }
            if (!isEomji && substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    isEomji = YES;
                }
            }
        }
    }];
    return isEomji;
}

- (BOOL)stringIsPureInt
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (NSInteger)getStringCharSize
{
    NSInteger strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++)
    {
        if (*p)
        {
            p++;
            strlength++;
        }
        else
        {
            p++;
        }
    }
    return (strlength+1)/2;
}

////按照中文两个字符，英文数字一个字符计算字符数
//-(NSUInteger) unicodeLengthOfString: (NSString *) text {
//    NSUInteger asciiLength = 0;
//    for (NSUInteger i = 0; i < text.length; i++) {
//        unichar uc = [text characterAtIndex: i];
//        asciiLength += isascii(uc) ? 1 : 2;
//    }
//    return asciiLength;
//}

#pragma mark -- 判断电话是否为有效电话号码
- (BOOL)isValidPhoneNumber
{
    /**
     * 移动号段正则表达式
     */
    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
    /**
     * 联通号段正则表达式
     */
    NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
    /**
     * 电信号段正则表达式
     */
    NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
    BOOL isMatch1 = [pred1 evaluateWithObject:self];
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
    BOOL isMatch2 = [pred2 evaluateWithObject:self];
    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
    BOOL isMatch3 = [pred3 evaluateWithObject:self];
    
    if (isMatch1 || isMatch2 || isMatch3) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)isEmptyContent
{
    BOOL pIsEmpty=YES;   ///是否是空格
    NSString *strSpace =@" ";
    NSString *pString = self;
    for(int i =0;i<[pString  length];i++)    {
        NSString *pStr = [self substringWithRange:NSMakeRange(i, 1)];//抽取子字符
        if(![pStr isEqualToString:strSpace])   ///判断是否为空格
        {
            pIsEmpty=NO;           ///如果是则改变 状态
            break;         ///结束循环
        }
    }
    return pIsEmpty;
}


@end
