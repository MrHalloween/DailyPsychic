//
//  AlertManager.m
//  pbuBaseLibrary
//
//  Created by zhanghe on 2018/1/20.
//  Copyright © 2018年 1bu2bu. All rights reserved.
//

#import "AlertManager.h"

@implementation AlertManager

+ (void)ShowAlertWithTitle:(NSString *)title message:(NSString *)message MakeSure:(MakeSure)makesure
{
    UIAlertController *pAlertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [pAlertVC addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }])];
    [pAlertVC addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (makesure) {
            makesure();
        }
    }])];
    [mKeyWindow.rootViewController presentViewController:pAlertVC animated:YES completion:nil];
}


+ (void)ShowActionSheetWithTitle:(NSString *)title message:(NSString *)message MakeSure:(MakeSure)makesure
{
    UIAlertController *pAlertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    [pAlertVC addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }])];
    [pAlertVC addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (makesure) {
            makesure();
        }
    }])];
    [mKeyWindow.rootViewController presentViewController:pAlertVC animated:YES completion:nil];
}

//显示加载结果 2秒消失
+ (void)ShowRelutWithMessage:(NSString *)message Dismiss:(Dismiss)dismiss
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:mKeyWindow.rootViewController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelFont = [UIFont boldSystemFontOfSize:14];
    hud.detailsLabelText = message;
    hud.removeFromSuperViewOnHide = YES;
    hud.userInteractionEnabled = NO;
    [hud hide:YES afterDelay:2.0];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (dismiss) {
            dismiss();
        }
    });
}

//显示风火轮
+ (void)ShowProgressHUDWithMessage:(NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:mKeyWindow.rootViewController.view animated:YES];
    hud.detailsLabelText = message;
    hud.removeFromSuperViewOnHide = YES;
    hud.userInteractionEnabled = NO;
}

//隐藏风火轮
+ (void)HideProgressHUD
{
    [MBProgressHUD hideAllHUDsForView:mKeyWindow.rootViewController.view animated:YES];
}

@end
