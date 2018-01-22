//
//  TextManager.m
//  pbuBaseLibrary
//
//  Created by zhanghe on 2018/1/20.
//  Copyright © 2018年 1bu2bu. All rights reserved.
//  文本属性管理者 （颜色、字体、字号...）

#import "TextManager.h"

@implementation TextManager

#pragma mark -- 字体
+ (NSString*)RegularFont
{
    return @"Arial";
}

+ (NSString*)LightFont
{
    return @"Arial";
}

+ (NSString*)BoldFont
{
    return  @"Arial-BoldMT";
}

+ (NSString*)BoldItalicFont
{
    return  @"Arial-BoldItalicMT";
}

#pragma mark - 颜色
+ (UIColor *) Color333
{
    return UIColorFromHex(0x333333);
}

+ (UIColor *) Color666
{
    return UIColorFromHex(0x666666);
}

+ (UIColor *) Color999
{
    return UIColorFromHex(0x999999);
}

//返回随机颜色
+ (UIColor *)RandomColor{
    
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
    
}

+ (void)SetLineSpace:(CGFloat)lineSpace ForLabel:(UILabel *)argLabel;
{
    if (argLabel)
    {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:argLabel.text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = NSTextAlignmentLeft;
        paragraphStyle.maximumLineHeight = 60;  //最大的行高
        paragraphStyle.lineSpacing = lineSpace;  //行自定义行高度
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [argLabel.text length])];
        argLabel.attributedText = attributedString;
    }
}

+ (CGFloat)GetAttributedTextHeightWithText:(NSString *)argText Width:(CGFloat)argWidth LineSpace:(CGFloat)argSpace FontSize:(CGFloat)argFontSize
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:argText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.maximumLineHeight = 60;  //最大的行高
    paragraphStyle.lineSpacing = argSpace;  //行自定义行高度
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, argText.length)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:[TextManager RegularFont] size:argFontSize] range:NSMakeRange(0, argText.length)];
    CGFloat fHeight = [attributedString boundingRectWithSize:CGSizeMake(argWidth, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    return fHeight;
}

@end
