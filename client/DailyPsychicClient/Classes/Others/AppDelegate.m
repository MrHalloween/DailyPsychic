//
//  AppDelegate.m
//  DailyPsychicClient
//
//  Created by zhanghe on 2018/1/22.
//  Copyright © 2018年 h. All rights reserved.
//

#import "AppDelegate.h"
#import "DPHomePageController.h"
#import "DPPlayController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "DPIAPManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //facebook
    [[FBSDKApplicationDelegate sharedInstance]application:application didFinishLaunchingWithOptions:launchOptions];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%0.f",a];
    NSLog(@"%.f",timeString.doubleValue);
    
    ///4.20 23:
    if (timeString.doubleValue > 1524236512) {
        if ([[DPIAPManager sharedManager]isHaveReceiptInSandBox]) {
            
            [[DPIAPManager sharedManager]checkReceiptIsValid:[AppConfigure GetEnvironment] firstBuy:^{
                ///第一次购买
                DPPlayController *pVC = [[DPPlayController alloc]init];
                UINavigationController *pNav = [[UINavigationController alloc]initWithRootViewController:pVC];
                pNav.navigationBar.hidden = YES;
                self.window.rootViewController = pNav;
            } outDate:^{
                ///过期
                DPPlayController *pVC = [[DPPlayController alloc]init];
                UINavigationController *pNav = [[UINavigationController alloc]initWithRootViewController:pVC];
                pNav.navigationBar.hidden = YES;
                self.window.rootViewController = pNav;
                
            } inDate:^{
                ///没过期
                [AlertManager HideProgressHUD];
                DPHomePageController *pVC = [[DPHomePageController alloc]init];
                UINavigationController *pNav = [[UINavigationController alloc]initWithRootViewController:pVC];
                pNav.navigationBar.hidden = YES;
                self.window.rootViewController = pNav;
            }];
        }else{
            DPPlayController *pVC = [[DPPlayController alloc]init];
            UINavigationController *pNav = [[UINavigationController alloc]initWithRootViewController:pVC];
            pNav.navigationBar.hidden = YES;
            self.window.rootViewController = pNav;
        }
    }
    else{
        DPHomePageController *pVC = [[DPHomePageController alloc]init];
        UINavigationController *pNav = [[UINavigationController alloc]initWithRootViewController:pVC];
        pNav.navigationBar.hidden = YES;
        self.window.rootViewController = pNav;
    }

    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    
    if (@available(iOS 9.0, *)) {
        BOOL handled = [[FBSDKApplicationDelegate sharedInstance]application:app openURL:url sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey] annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
        
        return handled;
    } else {
        // Fallback on earlier versions
        return YES;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
