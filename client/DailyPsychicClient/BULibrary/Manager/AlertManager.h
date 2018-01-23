//
//  AlertManager.h
//  pbuBaseLibrary
//
//  Created by zhanghe on 2018/1/20.
//  Copyright © 2018年 1bu2bu. All rights reserved.
//  提示框管理者 加载进度管理者

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

typedef void (^MakeSure)(void);

typedef void (^Dismiss)(void);

@interface AlertManager : NSObject

//alert
+ (void)ShowAlertWithTitle:(NSString *)title message:(NSString *)message MakeSure:(MakeSure)makesure;

//actionSheet
+ (void)ShowActionSheetWithTitle:(NSString *)title message:(NSString *)message MakeSure:(MakeSure)makesure;

//显示加载结果 2秒消失
+ (void)ShowRelutWithMessage:(NSString *)message Dismiss:(Dismiss)dismiss;

//显示风火轮
+ (void)ShowProgressHUDWithMessage:(NSString *)message;

//隐藏风火轮
+ (void)HideProgressHUD;

@end
