//
//  HYWebViewController.m
//  pbuHanYiBianPinQiClient
//
//  Created by 1bu2bu on 2017/4/5.
//  Copyright © 2017年 董融. All rights reserved.
//

#import "BUWebViewController.h"
#import "AppDelegate.h"

@interface BUWebViewController ()<UIGestureRecognizerDelegate>
{
    WKUserContentController *userContentController;
}
@end

@implementation BUWebViewController
@synthesize propUrl;

- (void)dealloc
{
    [userContentController removeScriptMessageHandlerForName:@"webkitJsCallLib"];
}

-(void)Back
{
    [userContentController removeScriptMessageHandlerForName:@"webkitJsCallLib"];
    [self.navigationController popViewControllerAnimated:YES];
    if (self.propBackAction) {
        self.propBackAction(nil);
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[mAppDelegate.propTabVc HideTabBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //删除缓存
    [self ClearCache];
    [self CreateWebView];
}

-(void)CreateWebView
{
    WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc] init];
    userContentController =[[WKUserContentController alloc] init];
    //注册一个name为aaa的js方法
    [userContentController addScriptMessageHandler:self name:@"webkitJsCallLib"];

    configuration.userContentController = userContentController;
    m_pWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(m_pTopBar.frame), self.view.width, self.view.height - CGRectGetMaxY(m_pTopBar.frame)) configuration:configuration];
    m_pWebView.scrollView.showsVerticalScrollIndicator = NO;
    m_pWebView.scrollView.showsHorizontalScrollIndicator = NO;
    m_pWebView.navigationDelegate = self;
    m_pWebView.UIDelegate = self;
    m_pWebView.scrollView.bounces = NO;
    [self.view addSubview:m_pWebView];
    
    
}

-(void)StartRequestWithUrl:(NSString *)argUrl
{
    NSString* urlString = [argUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    m_pWebPageRequest =[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [m_pWebView loadRequest:m_pWebPageRequest];
}

-(void)ClearCache
{
    /*
     
     WKWebsiteDataTypeDiskCache,
     
     WKWebsiteDataTypeOfflineWebApplicationCache,
     
     WKWebsiteDataTypeMemoryCache,
     
     WKWebsiteDataTypeLocalStorage,
     
     WKWebsiteDataTypeCookies,
     
     WKWebsiteDataTypeSessionStorage,
     
     WKWebsiteDataTypeIndexedDBDatabases,
     
     WKWebsiteDataTypeWebSQLDatabases
     
     */
    
    if (([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0))
    {
        NSArray * types = @[WKWebsiteDataTypeMemoryCache, WKWebsiteDataTypeDiskCache];
        NSSet *websiteDataTypes = [NSSet setWithArray:types];
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        
        
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            
            
        }];
    }
    NSString *libraryDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                               NSUserDomainMask, YES)[0];
    NSString *bundleId  =  [[[NSBundle mainBundle] infoDictionary]
                            objectForKey:@"CFBundleIdentifier"];
    NSString *webkitFolderInLib = [NSString stringWithFormat:@"%@/WebKit",libraryDir];
    NSString *webKitFolderInCaches = [NSString
                                      stringWithFormat:@"%@/Caches/%@/WebKit",libraryDir,bundleId];
    NSString *webKitFolderInCachesfs = [NSString
                                        stringWithFormat:@"%@/Caches/%@/fsCachedData",libraryDir,bundleId];
    
    NSError *error;
    /* iOS8.0 WebView Cache的存放路径 */
    [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCaches error:&error];
    [[NSFileManager defaultManager] removeItemAtPath:webkitFolderInLib error:nil];
    
    /* iOS7.0 WebView Cache的存放路径 */
    [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCachesfs error:&error];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//WKScriptMessageHandler protocol?
//WebKit Webview delegate
//在这个方法里实现注册的供js调用的oc方法
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"Message.body: %@", message.body);
    NSLog(@"Message.name: %@", message.name);

    if ([message.name isEqualToString:@"webkitJsCallLib"])
    {
        [self HandleUrlAction:message.body];
    }
    
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [AlertManager ShowProgressHUDWithMessage:@"正在全力加载..."];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    [AlertManager HideProgressHUD];
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"加载页面完成");
    [AlertManager HideProgressHUD];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    //设置机型
    [self WebViewCallBackJavascript:@"setDevice('ios');"];
    //禁用选中效果和放大镜
    [m_pWebView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none'" completionHandler:nil];
    [m_pWebView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none'" completionHandler:nil];
    
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    [AlertManager HideProgressHUD];
    // 类似 UIWebView 的- webView:didFailLoadWithError:
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(nonnull NSError *)error
{
    [AlertManager HideProgressHUD];
}

// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    
}

// 在收到响应后，决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
//{
//    
//}

//// 在发送请求之前，决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
//{
//    
//}

#pragma mark - WKUIDelegate
/**
 *  web界面中有弹出警告框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    //    DLOG(@"msg = %@ frmae = %@",message,frame);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    
}

#pragma mark - function
-(void)WebViewCallBackJavascript:(NSString*)argJavaScript
{
    if (IS_IOS8_OR_LATER)
    {
        [m_pWebView evaluateJavaScript:argJavaScript completionHandler:^(id result, NSError * _Nullable error) {
            
        }];
    }
}


@end
