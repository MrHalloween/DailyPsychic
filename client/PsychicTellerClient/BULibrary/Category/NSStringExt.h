//
//  NSString+Emoji.h
//  pbuYaLianWuYeClient
//
//  Created by 1bu2bu on 16/9/7.
//  Copyright © 2016年 1bu2bu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSStringExt)

/**
 *  判断字符串中是否包含表情
 *
 *  @return 包含表情返回是
 */
- (BOOL)stringContainsEmoji;

/**
 *  判断字符串是否是纯数字
 *
 *  @return 是纯数字返回是
 */
- (BOOL)stringIsPureInt;

/**
 *  获取字符串的字数
 *
 *  @return 字数（转化为汉字的字数）
 */
- (NSInteger)getStringCharSize;

/**
 *  判断是否为有效电话号码
 *
 *  @return 是否有效
 */
- (BOOL)isValidPhoneNumber;

/**
 *  检查是否全是空格
 *
 *  @return 是否全是空格
 */
- (BOOL)isEmptyContent;

@end
