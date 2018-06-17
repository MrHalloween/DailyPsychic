//
//  DPIAPManager.m
//  DailyPsychicClient
//
//  Created by zhanghe on 2018/2/9.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPIAPManager.h"
#import <StoreKit/StoreKit.h>

//内购中创建的商品
#define ProductID_IAP01 @"sub.dailytest.weeklypackage"//购买产品ID号
//共享秘钥
#define SharedSecretKey @"e6a40e87f7024bf5b034f7d766db1bf2"//共享秘钥

@interface DPIAPManager()<SKPaymentTransactionObserver,SKProductsRequestDelegate>
{
    
}
@end

@implementation DPIAPManager

static DPIAPManager *_iap;

+ (instancetype)sharedManager
{
    if(!_iap){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _iap = (DPIAPManager *)[[DPIAPManager alloc]init];
            
        });
    }
    return _iap;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    
    if(!_iap){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _iap = [super allocWithZone:zone];
        });
    }
    return _iap;
}

///判断本地沙盒是否存储了receiptData数据
- (BOOL)isHaveReceiptInSandBox
{
    //内购相关
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [self paymentQueue:[SKPaymentQueue defaultQueue] updatedTransactions:[SKPaymentQueue defaultQueue].transactions];
    
    NSURL *receiptUrl=[[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receiptData=[NSData dataWithContentsOfURL:receiptUrl];
    if (receiptData != nil) {
        NSLog(@"------本地沙盒存放了receiptData数据-----");
        return YES;
    }else{
        NSLog(@"------本地沙盒没有receiptData数据-----");
        return NO;
    }
}

///请求商品数据
- (void)requestProductWithProductId:(NSString *)productId
{
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    if([SKPaymentQueue canMakePayments]){
        NSLog(@"-------------请求对应的产品信息----------------");
        NSArray *product = [[NSArray alloc] initWithObjects:productId, nil];
        NSSet *nsset = [NSSet setWithArray:product];
        SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
        request.delegate = self;
        [request start];
    }else{
        NSLog(@"-------------不允许程序内付费-------------");
    }
    

}

#pragma mark - SKProductsRequestDelegate
//请求商品信息成功的回调
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSLog(@"--------------收到产品信息---------------------");
    NSArray *product = response.products;
    if([product count] == 0){
        NSLog(@"--------------没有商品------------------");
        UIAlertView *pAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"商店没有商品信息" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
        [pAlert show];
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
        if([pro.productIdentifier isEqualToString:[pro productIdentifier]]){
            p = pro;
        }else{
            UIAlertView *pAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"商品id不匹配" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
            [pAlert show];
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
    } @finally {
        
    }
}

//查询失败的回调
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"------------------错误-----------------:%@", error);
    UIAlertView *pAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@",error.description] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
    [pAlert show];
    return;
}

- (void)requestDidFinish:(SKRequest *)request{
    NSLog(@"------------反馈信息结束-----------------");
}

#pragma mark - SKPaymentTransactionObserver
//购买操作后的回调
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transaction{
    for(SKPaymentTransaction *tran in transaction){
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchased:
                NSLog(@"---购买操作后的回调-------交易完成");
                [self completeTransaction:tran];
                [mUserDefaults setBool:YES forKey:@"isbuy"];
                [mUserDefaults synchronize];
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
                [AlertManager HideProgressHUD];
                NSLog(@"交易失败%ld",tran.error.code);
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

- (void)restorePurchase
{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
}

- (void)completeTransaction:(SKPaymentTransaction *)transaction{
    NSLog(@"-----1------交易完成开始2次验证");
    //把self.receipt发送到服务器验证是否有效
    if (self.propCheckReceipt) {
        self.propCheckReceipt(nil);
    }
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

///这个SKErrorUnknown实在是很难处理，我找了好多的帖子，包括stackoverflow，也没看到太多的说法，有一些说可能是越狱手机，才会出现这种状态，在测试的时候，我们通常也会遇到这种问题。测试的时候，我们要再iTunes connect申请测试账号，有的时候，测试账号出问题，或者，测试账号已经被取消了，不再使用了，而支付的时候，仍然在使用这个测试账号，这个时候，也会出现unknown状态。http://www.w2bc.com/article/115403
- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    
    [AlertManager HideProgressHUD];
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

///验证购买，避免越狱软件模拟苹果请求达到非法购买问题
- (void)checkReceiptIsValid:(NSString *)environment firstBuy:(block)firstBuy outDate:(block)outDate inDate:(block)inDate
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
    NSURL *url=[NSURL URLWithString:environment];
    NSMutableURLRequest *requestM=[NSMutableURLRequest requestWithURL:url];
    requestM.HTTPBody=bodyData;
    requestM.HTTPMethod=@"POST";
    //创建连接并发送同步请求
    NSError *error=nil;
    NSData *responseData=[NSURLConnection sendSynchronousRequest:requestM returningResponse:nil error:&error];
    if (error) {
        [AlertManager HideProgressHUD];
        NSLog(@"验证购买过程中发生错误，错误信息：%@",error.localizedDescription);
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
                if (inDate) {
                    inDate();
                }
                
            }
            else
            {
                //订阅过期
                NSLog(@"****************订阅过期*******************");
                if (outDate) {
                    outDate();
                }
                [mUserDefaults setBool:NO forKey:@"isbuy"];
                [mUserDefaults synchronize];
            }
        }
        else
        {
            //第一次购买
            NSLog(@"****************第一次购买*******************");
            if (firstBuy) {
                firstBuy();
            }
        }
    }
    
    else if ([dic[@"status"] intValue] == 21007)
    {
        NSLog(@"购买失败，未通过验证！");
//        if (self.propCheckReceipt) {
//            self.propCheckReceipt(nil);
//        }
    }
    else
    {
        NSLog(@"购买失败，未通过验证！");
    }
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

- (void)dealloc{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}
@end
