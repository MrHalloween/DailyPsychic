
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
#import "NSString+TimeFormat.h"

//沙盒测试环境验证
#define SANDBOX @"https://sandbox.itunes.apple.com/verifyReceipt"
//正式环境验证
#define AppStore @"https://buy.itunes.apple.com/verifyReceipt"

//内购中创建的商品
#define ProductID_IAP01 @"com.dailypsychic.horoscope01"//购买产品ID号
//共享秘钥
#define SharedSecretKey @"a727f397ec8d4ff69e35948f1ead6237"//共享秘钥

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
    [AlertManager HideProgressHUD];
    DPPalmResultController *resultVc = [[DPPalmResultController alloc]init];
    if ([self.analysisType isEqualToString:@"test"]) {
        resultVc.dpResultType = DPResultTest;
        resultVc.testId = self.testId;
    }else if ([self.analysisType isEqualToString:@"palm"]) {
        resultVc.dpResultType = DPResultPalm;
    }
    [self PushChildViewController:resultVc animated:YES];
}

#pragma mark - iap
#pragma mark - 内购
- (void)PushToNextPage:(id)argData
{
    NSURL *receiptUrl=[[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receiptData=[NSData dataWithContentsOfURL:receiptUrl];
    if (receiptData != nil) {
        NSLog(@"------本地沙盒存放了receiptData数据-----");
        [self checkReceiptIsValid:SANDBOX];
    }else{
        NSLog(@"------本地沙盒没有receiptData数据-----");
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        if([SKPaymentQueue canMakePayments]){
            [AlertManager ShowProgressHUDWithMessage:@""];
            [self requestProductData:ProductID_IAP01];
        }else{
            NSLog(@"-------------不允许程序内付费-------------");
        }

    }

}
//请求商品信息
- (void)requestProductData:(NSString *)type{
    NSLog(@"-------------请求对应的产品信息----------------");
    NSArray *product = [[NSArray alloc] initWithObjects:type, nil];
    NSSet *nsset = [NSSet setWithArray:product];
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
    request.delegate = self;
    [request start];
}

//请求商品信息成功的回调
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    NSLog(@"--------------收到产品信息---------------------");
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
        NSLog(@"价格%@", [pro price]);
        NSLog(@"产品ID%@", [pro productIdentifier]);
        if([pro.productIdentifier isEqualToString:ProductID_IAP01]){
            p = pro;
        }else{
            UIAlertView *pAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"商品id不匹配" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
            [pAlert show];
            [AlertManager HideProgressHUD];
            return;
        }
    }
    
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    @try {
        NSLog(@"发送购买请求");
        SKPayment *payment = [SKPayment paymentWithProduct:p];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    } @catch (NSException *exception) {
        UIAlertView *pAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"购买出错，请重试" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
        [pAlert show];
        [AlertManager HideProgressHUD];
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
    for(SKPaymentTransaction *tran in transaction){
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchased:
                NSLog(@"---购买操作后的回调-------交易完成");
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
                [self failedTransaction:tran];
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
    NSMutableDictionary *bodyDic = [[NSMutableDictionary alloc]init];
    [bodyDic setValue:receiptString forKey:@"receipt-data"];
    [bodyDic setValue:SharedSecretKey forKey:@"password"];
    NSData *data=[NSJSONSerialization dataWithJSONObject:bodyDic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *bodyString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];//拼接请求数据
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
        [AlertManager HideProgressHUD];
        [AlertManager ShowRelutWithMessage:@"交易失败" Dismiss:nil];
        return;
    }
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
    
    if([dic[@"status"] intValue] == 0){
        
        NSArray *arrLatestReceipt = dic[@"latest_receipt_info"];
        NSLog(@"------取得arrLatestReceipt 看第一次购买有几个值--%@",arrLatestReceipt);
        if (arrLatestReceipt.count)
        {
            //已经购买过，在这里判断订阅是否过期
            NSDictionary *info = arrLatestReceipt.lastObject;
            //最后一次购买的过期时间时间戳
            long int expires = [info[@"expires_date_ms"] integerValue];
            //当前时间时间戳
            NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
            long int now = (long)[dat timeIntervalSince1970] * 1000;
            
            if (expires > now)
            {
                //订阅没过期
                NSLog(@"****************订阅没过期*******************");
                [self GetResult];
            }
            else
            {
                //订阅过期
                NSLog(@"****************订阅过期*******************");
                [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
                if([SKPaymentQueue canMakePayments]){
                    [AlertManager ShowProgressHUDWithMessage:@""];
                    [self requestProductData:ProductID_IAP01];
                }else{
                    NSLog(@"-------------不允许程序内付费-------------");
                }
                
            }
        }
        else
        {
            //第一次购买
            NSLog(@"****************第一次购买*******************");
            [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
            if([SKPaymentQueue canMakePayments]){
                [AlertManager ShowProgressHUDWithMessage:@""];
                [self requestProductData:ProductID_IAP01];
            }else{
                NSLog(@"-------------不允许程序内付费-------------");
            }
//            NSLog(@"购买成功！");
//            [AlertManager HideProgressHUD];
//            [self GetResult];
            
        }
    }
    
    else if ([dic[@"status"] intValue] == 21007)
    {
        NSLog(@"购买失败，未通过验证！");
        [AlertManager HideProgressHUD];
        [AlertManager ShowRelutWithMessage:@"交易失败" Dismiss:nil];
//        [self checkReceiptIsValid:SANDBOX];
    }
    else
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
}

- (void)completeTransaction:(SKPaymentTransaction *)transaction{
    NSLog(@"-----1------交易完成开始2次验证");
    [self checkReceiptIsValid:SANDBOX];       //把self.receipt发送到服务器验证是否有效
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}



- (void)dealloc{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

@end
