//
//  UILable+TextEffect.m
//  pbuSymbolTechPaiPaiJing
//
//  Created by Xue Yan on 15-7-24.
//  Copyright (c) 2015年 周杰. All rights reserved.
//

#import "UILable+TextEffect.h"

@implementation UILabel (TextEffect)

-(void)AddTextUnderscore
{
    NSString* strText = self.text;
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:strText];
    NSRange contentRange = {0,[content length]};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    self.attributedText = content;
}

- (void)SetTextColor:(UIColor *)textColor FontName:(NSString *)fontName FontSize:(CGFloat)fontSize Placehoder:(NSString *)placehoder
{
    self.textColor = textColor;
    self.font = [UIFont fontWithName:fontName size:fontSize];
    self.text = placehoder;
}
@end
