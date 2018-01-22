//
//  HYWebViewController.h
//  pbuHanYiBianPinQiClient
//
//  Created by 1bu2bu on 2017/4/5.
//  Copyright © 2017年 董融. All rights reserved.
//

#import "BUCustomViewController.h"
#import <WebKit/WebKit.h>
#define IS_IOS8_OR_LATER ([[UIDevice currentDevice].systemVersion floatValue] >=8.0)

@protocol BUWebViewControllerDelegate <NSObject>

@optional
-(void)RefreshCallerController;

@end

@interface BUWebViewController : BUCustomViewController<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>
{
    WKWebView *m_pWebView;
    NSURLRequest *m_pWebPageRequest;
}

@property (nonatomic, strong)NSString *propUrl;
@property (nonatomic, weak)id<BUWebViewControllerDelegate>  propDelegate;


-(void)StartRequestWithUrl:(NSString *)argUrl;
-(BOOL)HandleUrlAction:(NSString*)argPath;

@end
