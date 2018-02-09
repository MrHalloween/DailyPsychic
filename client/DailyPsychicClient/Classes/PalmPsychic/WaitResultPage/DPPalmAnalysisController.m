
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
#import "DPIAPManager.h"

//沙盒测试环境验证
#define SANDBOX @"https://sandbox.itunes.apple.com/verifyReceipt"
//正式环境验证
#define AppStore @"https://buy.itunes.apple.com/verifyReceipt"

//内购中创建的商品
#define ProductID_IAP01 @"com.dailypsychic.horoscope01"//购买产品ID号

@interface DPPalmAnalysisController ()<AFBaseTableViewDelegate>
{
    DPPalmAnalysisView *m_pPalmAnalysisView;
    BOOL m_bIsShow;
}
@end

@implementation DPPalmAnalysisController

- (void)viewDidLoad {
    [super viewDidLoad];
    m_pPalmAnalysisView = [[DPPalmAnalysisView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    m_pPalmAnalysisView.proDelegate = self;
    [self.view addSubview:m_pPalmAnalysisView];
    
    [DPIAPManager sharedManager].propCheckReceipt = ^(id object) {
        [[DPIAPManager sharedManager]checkReceiptIsValid:SANDBOX firstBuy:^{
            ///第一次购买
            [[DPIAPManager sharedManager]requestProductWithProductId:ProductID_IAP01];
        } outDate:^{
            ///过期
            [[DPIAPManager sharedManager]requestProductWithProductId:ProductID_IAP01];
            
        } inDate:^{
            ///没过期
            [self GetResult];
        }];
    };
}
#pragma mark - 返回以及跳转按钮
- (void)PopPreviousPage
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)GetResult
{
    [AlertManager HideProgressHUD];
    m_bIsShow = NO;
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
- (void)PushToNextPage:(id)argData
{
    if (m_bIsShow) {
        return;
    }
    [AlertManager ShowProgressHUDWithMessage:@""];
    m_bIsShow = YES;
    if ([[DPIAPManager sharedManager]isHaveReceiptInSandBox]) {

        [[DPIAPManager sharedManager]checkReceiptIsValid:SANDBOX firstBuy:^{
            ///第一次购买
            [[DPIAPManager sharedManager]requestProductWithProductId:ProductID_IAP01];
        } outDate:^{
            ///过期
            [[DPIAPManager sharedManager]requestProductWithProductId:ProductID_IAP01];
            
        } inDate:^{
            ///没过期
            [self GetResult];
        }];
    }else{
        [[DPIAPManager sharedManager]requestProductWithProductId:ProductID_IAP01];
    }
}

@end
