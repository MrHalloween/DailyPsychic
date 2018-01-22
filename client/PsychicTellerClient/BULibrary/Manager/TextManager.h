//
//  TextManager.h
//  pbuBaseLibrary
//
//  Created by zhanghe on 2018/1/20.
//  Copyright © 2018年 1bu2bu. All rights reserved.
//  文本属性管理者 （颜色、字体、字号...）

#import <Foundation/Foundation.h>

@interface TextManager : NSObject

#pragma mark - 字体
+ (NSString *) RegularFont;
+ (NSString *) LightFont;
+ (NSString *) BoldFont;
+ (NSString *) BoldItalicFont;

#pragma mark - 颜色
+ (UIColor *) Color333;
+ (UIColor *) Color666;
+ (UIColor *) Color999;

//返回随机颜色
+ (UIColor *) RandomColor;

//给UILabel设置行间距
+ (void)SetLineSpace:(CGFloat)lineSpace ForLabel:(UILabel *)argLabel;

+ (CGFloat)GetAttributedTextHeightWithText:(NSString *)argText Width:(CGFloat)argWidth LineSpace:(CGFloat)argSpace FontSize:(CGFloat)argFontSize;

@end
