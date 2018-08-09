//
//  UtilsMacros.h
//  pbuBaseLibrary
//
//  Created by zhanghe on 2018/1/20.
//  Copyright © 2018年 1bu2bu. All rights reserved.
//  工具类的宏

#ifndef UtilsMacros_h
#define UtilsMacros_h

//打印
#ifdef DEBUG
#define NSLog(...) printf("%f %s\n",[[NSDate date]timeIntervalSince1970],[[NSString stringWithFormat:__VA_ARGS__]UTF8String]);
#else
#define NSLog(format, ...)
#endif

//判断字符串为空
#define IS_NULL(x)                  (!x || [x isKindOfClass:[NSNull class]])
#define IS_EMPTY_STRING(x)          (IS_NULL(x) || [x isEqual:@""] || [x isEqual:@"(null)"])

//获取RGB颜色
#define UIColorFromHexWithAlpha(hexValue,a)  [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0xFF00) >> 8))/255.0 \
blue:((float)(hexValue & 0xFF)) /255.0 \
alpha:a]

#define UIColorFromHex(hexValue)         UIColorFromHexWithAlpha(hexValue,1.0)
#define kColorWithRGB(r,g,b) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1.0];

//weakself
#define AFWeak         __weak __typeof(self) weakSelf = self

//根据文字字号获取高度
#define SIZE_HEIGHT(i)  [@"占位符" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:i]} context:nil].size.height

//方法简写
#define mAppDelegate        ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define mWindow             [[[UIApplication sharedApplication] windows] lastObject]
#define mKeyWindow          [[UIApplication sharedApplication] keyWindow]
#define mUserDefaults       [NSUserDefaults standardUserDefaults]
#define mNotificationCenter [NSNotificationCenter defaultCenter]

//第一个参数是当下的控制器适配iOS11 一下的，第二个参数表示scrollview或子类
#define AdjustsScrollViewInsetNever(controller,view) if(@available(iOS 11.0, *)) {view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;} else if([controller isKindOfClass:[UIViewController class]]) {controller.automaticallyAdjustsScrollViewInsets = false;}


//内购中创建的商品
#define ProductID_IAP01 @"com.mydestiny.tell.member"
//共享秘钥
#define SharedSecretKey @"785b3591e8aa48c28f355184474a4e32"


#endif /* UtilsMacros_h */
