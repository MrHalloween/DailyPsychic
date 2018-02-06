
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


@interface DPPalmAnalysisController ()<AFBaseTableViewDelegate,SKPaymentTransactionObserver,SKProductsRequestDelegate>
{
    DPPalmAnalysisView *m_pPalmAnalysisView;
}
@end

@implementation DPPalmAnalysisController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    m_pPalmAnalysisView = [[DPPalmAnalysisView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    m_pPalmAnalysisView.proDelegate = self;
    [self.view addSubview:m_pPalmAnalysisView];
}

- (void)PushToNextPage:(id)argData
{
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    self.profuctIdArr = @[@"com.dailypsychic.horoscope01"];
    BOOL isbuy = [[NSUserDefaults standardUserDefaults]boolForKey:@"com.dailypsychic.horoscope01"];
    if (isbuy) {
        [self GetResult];
    }else{
        NSString *product = @"com.dailypsychic.horoscope01";
        _currentProId = product;
        if([SKPaymentQueue canMakePayments]){
            [AlertManager ShowProgressHUDWithMessage:@""];
            [self requestProductData:product];
        }else{
            NSLog(@"不允许程序内付费");
        }
    }
}
#pragma mark - Apple Pay
- (void)btnClick:(UIButton *)button
{
    NSString *product = self.profuctIdArr[button.tag-100];
    _currentProId = product;
    if([SKPaymentQueue canMakePayments]){
        [self requestProductData:product];
    }else{
        NSLog(@"不允许程序内付费");
    }
}
//请求商品
- (void)requestProductData:(NSString *)type{
    NSLog(@"-------------请求对应的产品信息----------------");
    NSArray *product = [[NSArray alloc] initWithObjects:type,nil];
    NSSet *nsset = [NSSet setWithArray:product];
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
    request.delegate = self;
    [request start];
}
//收到产品返回信息
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    NSLog(@"--------------收到产品反馈消息---------------------");
    NSArray *product = response.products;
    if([product count] == 0){
        NSLog(@"--------------没有商品------------------");
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
        }
    }
    SKPayment *payment = [SKPayment paymentWithProduct:p];
    NSLog(@"发送购买请求");
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}
//请求失败
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    [AlertManager HideProgressHUD];
    NSLog(@"------------------错误支付失败-----------------:%@", error);
}

- (void)requestDidFinish:(SKRequest *)request{
    NSLog(@"------------反馈信息结束-----------------");
}
//沙盒测试环境验证
#define SANDBOX @"https://sandbox.itunes.apple.com/verifyReceipt"
//正式环境验证
#define AppStore @"https://buy.itunes.apple.com/verifyReceipt"

/**
 *  验证购买，避免越狱软件模拟苹果请求达到非法购买问题
 *
 */
-(void)verifyPurchaseWithPaymentTransaction
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
    NSLog(@"%@",dic);
    if([dic[@"status"] intValue]==0){
        NSLog(@"购买成功！");
        [AlertManager HideProgressHUD];
        NSDictionary *dicReceipt = dic[@"receipt"];
        NSDictionary *dicInApp = [dicReceipt[@"in_app"] firstObject];
        NSString *productIdentifier = dicInApp[@"product_id"];//读取产品标识
        //如果是消耗品则记录购买数量，非消耗品则记录是否购买过
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([productIdentifier isEqualToString:@"com.dailypsychic.horoscope01"]) {
            long purchasedCount = [defaults integerForKey:productIdentifier];//已购买数量
            [[NSUserDefaults standardUserDefaults] setInteger:(purchasedCount+1) forKey:productIdentifier];
        }else{
            [defaults setBool:YES forKey:productIdentifier];
            [defaults setBool:YES forKey:@"com.dailypsychic.horoscope01"];
        }
        [defaults synchronize];
        [self GetResult];
        //在此处对购买记录进行存储，可以存储到开发商的服务器端
    }else{
        [AlertManager HideProgressHUD];
        [AlertManager ShowRelutWithMessage:@"交易失败" Dismiss:nil];
        NSLog(@"购买失败，未通过验证！");
    }
}

//监听购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transaction{
    for(SKPaymentTransaction *tran in transaction){
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchased:
            {
                NSLog(@"交易完成");
                [self verifyPurchaseWithPaymentTransaction];
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
            }
                break;
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"商品添加进列表");
                break;
            case SKPaymentTransactionStateRestored:
            {
                [AlertManager HideProgressHUD];
                NSLog(@"已经购买过商品");
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                [self GetResult];
            }
                break;
            case SKPaymentTransactionStateFailed:
            {
                [AlertManager HideProgressHUD];
                [AlertManager ShowRelutWithMessage:@"交易失败" Dismiss:nil];
                NSLog(@"交易失败");
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
            }
                break;
            default:
                break;
        }
    }
}
//交易结束
- (void)completeTransaction:(SKPaymentTransaction *)transaction{
    NSLog(@"交易结束");
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)dealloc{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
    
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


@end
