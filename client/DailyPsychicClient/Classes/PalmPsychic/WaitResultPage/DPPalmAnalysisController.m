
//
//  DPPalmAnalysisController.m
//  DailyPsychicClient
//
//  Created by 李少艳 on 2018/1/31.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPPalmAnalysisController.h"
#import "DPPalmAnalysisView.h"
#import "DPPalmResultController.h"
#import <StoreKit/StoreKit.h>

//沙盒测试环境验证
#define SANDBOX @"https://sandbox.itunes.apple.com/verifyReceipt"
//正式环境验证
#define AppStore @"https://buy.itunes.apple.com/verifyReceipt"

@interface DPPalmAnalysisController ()<AFBaseTableViewDelegate,SKPaymentTransactionObserver,SKProductsRequestDelegate>
{
    DPPalmAnalysisView *m_pPalmAnalysisView;
}
@end

@implementation DPPalmAnalysisController

- (void)viewDidLoad {
    [super viewDidLoad];
    m_pPalmAnalysisView = [[DPPalmAnalysisView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    m_pPalmAnalysisView.proDelegate = self;
    [self.view addSubview:m_pPalmAnalysisView];
    
    //内购相关
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [self paymentQueue:[SKPaymentQueue defaultQueue] updatedTransactions:[SKPaymentQueue defaultQueue].transactions];
}
#pragma mark - 返回以及跳转按钮
- (void)PopPreviousPage
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)GetResult
{
    DPPalmResultController *resultVc = [[DPPalmResultController alloc]init];
    if ([self.analysisType isEqualToString:@"test"]) {
        resultVc.dpResultType = DPResultTest;
    }else if ([self.analysisType isEqualToString:@"palm"]) {
        resultVc.dpResultType = DPResultPalm;
    }
    [self PushChildViewController:resultVc animated:YES];
}

- (void)PushToNextPage:(id)argData
{
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
//    BOOL isbuy = [[NSUserDefaults standardUserDefaults]boolForKey:@"com.dailypsychic.horoscope01"];
//    if (isbuy) {
//        [self GetResult];
//    }else{
        NSString *product = @"com.dailypsychic.horoscope01";
        _currentProId = product;
        if([SKPaymentQueue canMakePayments]){
            [AlertManager ShowProgressHUDWithMessage:@""];
            [self requestProductData:product];
        }else{
            NSLog(@"不允许程序内付费");
        }
//    }
}
#pragma mark - iap
#pragma mark - 内购
//请求商品
- (void)requestProductData:(NSString *)type{
    NSLog(@"-------------请求对应的产品信息----------------");
    NSArray *product = [[NSArray alloc] initWithObjects:type, nil];
    NSSet *nsset = [NSSet setWithArray:product];
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
    request.delegate = self;
    [request start];
    
}

///查询成功的回调
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    
    NSLog(@"--------------收到产品反馈消息---------------------");
    NSArray *product = response.products;
    if([product count] == 0){
        NSLog(@"--------------没有商品------------------");
        UIAlertView *pAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"商店没有商品信息" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
        [pAlert show];
        [AlertManager HideProgressHUD];
        return;
    }
    
    NSLog(@"productID:%@", response.invalidProductIdentifiers);
    NSLog(@"产品付费数量:%lu",(unsigned long)[product count]);
    
    SKProduct *p = nil;
    for (SKProduct *pro in product) {
        NSLog(@"%@", [pro description]);
        NSLog(@"%@", [pro localizedTitle]);
        NSLog(@"%@", [pro localizedDescription]);
        NSLog(@"%@", [pro price]);
        NSLog(@"%@", [pro productIdentifier]);
        
        if([pro.productIdentifier isEqualToString:_currentProId]){
            p = pro;
        }else
        {
            UIAlertView *pAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"商品id不匹配" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
            [pAlert show];
            [AlertManager HideProgressHUD];
            return;
        }
    }
    
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    
    @try {
        SKPayment *payment = [SKPayment paymentWithProduct:p];
        
        NSLog(@"发送购买请求");
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    } @catch (NSException *exception) {
        UIAlertView *pAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"购买出错，请重试" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
        [pAlert show];
        [AlertManager HideProgressHUD];
        NSLog(@"exception=%@",exception.description);
    } @finally {
        
    }
    
    
}

//查询失败的回调
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"------------------错误-----------------:%@", error);
    
    UIAlertView *pAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@",error.description] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
    [pAlert show];
    [AlertManager HideProgressHUD];
    return;
}

- (void)requestDidFinish:(SKRequest *)request{
    NSLog(@"------------反馈信息结束-----------------");
}


//购买操作后的回调
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transaction{
    
    //    SKPaymentTransactionStateDeferred
    
    for(SKPaymentTransaction *tran in transaction){
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchased:
                NSLog(@"交易完成");
                [self completeTransaction:tran];
                break;
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"商品添加进列表");
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"已经购买过商品");
                [self restorePurchase];
                break;
            case SKPaymentTransactionStateFailed:
            {
                NSLog(@"交易失败%ld",tran.error.code);
                [AlertManager HideProgressHUD];
                //                [self showAlert:@"交易失败"];
                [self failedTransaction:tran];
                [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
                break;
            }
            case SKPaymentTransactionStateDeferred:
            {
                NSLog(@"交易延迟");
                break;
            }
                
            default:
                break;
        }
    }
}

///这个SKErrorUnknown实在是很难处理，我找了好多的帖子，包括stackoverflow，也没看到太多的说法，有一些说可能是越狱手机，才会出现这种状态，在测试的时候，我们通常也会遇到这种问题。测试的时候，我们要再iTunes connect申请测试账号，有的时候，测试账号出问题，或者，测试账号已经被取消了，不再使用了，而支付的时候，仍然在使用这个测试账号，这个时候，也会出现unknown状态。http://www.w2bc.com/article/115403

- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    //    if(transaction.error.code != SKErrorPaymentCancelled) {
    //        NSLog(@"购买失败");
    //    } else {
    //        NSLog(@"用户取消交易");
    //    }
    NSString *detail = @"";
    switch (transaction.error.code) {
            
        case SKErrorUnknown:
            
            NSLog(@"SKErrorUnknown");
            detail = @"未知的错误，您可能正在使用越狱手机";
            break;
            
        case SKErrorClientInvalid:
            
            NSLog(@"SKErrorClientInvalid");
            detail = @"当前苹果账户无法购买商品(如有疑问，可以询问苹果客服)";
            break;
            
        case SKErrorPaymentCancelled:
            
            NSLog(@"SKErrorPaymentCancelled");
            break;
        case SKErrorPaymentInvalid:
            NSLog(@"SKErrorPaymentInvalid");
            detail = @"订单无效(如有疑问，可以询问苹果客服)";
            break;
            
        case SKErrorPaymentNotAllowed:
            NSLog(@"SKErrorPaymentNotAllowed");
            detail = @"当前苹果设备无法购买商品(如有疑问，可以询问苹果客服)";
            break;
            
        case SKErrorStoreProductNotAvailable:
            NSLog(@"SKErrorStoreProductNotAvailable");
            detail = @"当前商品不可用";
            break;
            
        default:
            
            NSLog(@"No Match Found for error");
            detail = @"未知错误";
            break;
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}



- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    NSLog(@"paymentQueueRestoreCompletedTransactionsFinished");
}

- (void)paymentQueue:(SKPaymentQueue *)queue removedTransactions:(NSArray<SKPaymentTransaction *> *)transactions
{
    NSLog(@"removedTransactions");
}

// Sent when an error is encountered while adding transactions from the user's purchase history back to the queue.
- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error
{
    NSLog(@"restoreCompletedTransactionsFailedWithError");
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedDownloads:(NSArray<SKDownload *> *)downloads
{
    NSLog(@"updatedDownloads");
}

/**
 *  验证购买，避免越狱软件模拟苹果请求达到非法购买问题
 *
 */
- (void)checkReceiptIsValid:(NSString *)argStr
{
    //从沙盒中获取交易凭证并且拼接成请求体数据
    NSURL *receiptUrl=[[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receiptData=[NSData dataWithContentsOfURL:receiptUrl];
    NSString *receiptString=[receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];//转化为base64字符串
    NSString *bodyString = [NSString stringWithFormat:@"{\"receipt-data\" : \"%@\"}", receiptString];//拼接请求数据
    NSData *bodyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    //创建请求到苹果官方进行购买验证
    NSURL *url=[NSURL URLWithString:SANDBOX];
    NSMutableURLRequest *requestM=[NSMutableURLRequest requestWithURL:url];
    requestM.HTTPBody=bodyData;
    requestM.HTTPMethod=@"POST";
    //创建连接并发送同步请求
    NSError *error=nil;
    NSData *responseData=[NSURLConnection sendSynchronousRequest:requestM returningResponse:nil error:&error];
    if (error) {
        NSLog(@"验证购买过程中发生错误，错误信息：%@",error.localizedDescription);
        return;
    }
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"------- 李少艳responseDic---------%@",dic);
    if([dic[@"status"] intValue]==0){
        NSLog(@"购买成功！");
        [AlertManager HideProgressHUD];
        NSDictionary *dicReceipt = dic[@"receipt"];
        NSLog(@"----------------------dicReceipt------%@",dicReceipt);
        NSDictionary *dicInApp = [dicReceipt[@"in_app"] firstObject];
        NSString *productIdentifier = dicInApp[@"product_id"];//读取产品标识
        //如果是消耗品则记录购买数量，非消耗品则记录是否购买过
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        if ([productIdentifier isEqualToString:@"com.dailypsychic.horoscope01"]) {
//            long purchasedCount = [defaults integerForKey:productIdentifier];//已购买数量
//            [[NSUserDefaults standardUserDefaults] setInteger:(purchasedCount+1) forKey:productIdentifier];
//        }else{
//            [defaults setBool:YES forKey:productIdentifier];
//            [defaults setBool:YES forKey:@"com.dailypsychic.horoscope01"];
//        }
        [defaults synchronize];
        [self GetResult];
        //在此处对购买记录进行存储，可以存储到开发商的服务器端
    }else if ([dic[@"status"] intValue]==21007)
    {
        NSLog(@"购买失败，未通过验证！");
        [self checkReceiptIsValid:SANDBOX];
    }else
    {
        [AlertManager HideProgressHUD];
        [AlertManager ShowRelutWithMessage:@"交易失败" Dismiss:nil];
        NSLog(@"购买失败，未通过验证！");
    }
}
- (void)restorePurchase
{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    // 恢复已经完成的所有交易.（仅限永久有效商品）
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

- (void)completeTransaction:(SKPaymentTransaction *)transaction{
    NSLog(@"交易结束");
    [self checkReceiptIsValid:AppStore];        //把self.receipt发送到服务器验证是否有效
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}



- (void)dealloc{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

@end
