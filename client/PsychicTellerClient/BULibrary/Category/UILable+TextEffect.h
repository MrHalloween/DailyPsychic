//
//  UILable+TextEffect.h
//  pbuSymbolTechPaiPaiJing
//
//  Created by Xue Yan on 15-7-24.
//  Copyright (c) 2015年 周杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (TextEffect)

/**
 *  在label下加一条下划线
 */
-(void)AddTextUnderscore;

- (void)SetTextColor:(UIColor *)textColor FontName:(NSString *)fontName FontSize:(CGFloat)fontSize Placehoder:(NSString *)placehoder;
@end
