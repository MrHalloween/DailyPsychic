
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
#import "NSString+TimeFormat.h"
#import "DPUserProtocolController.h"
#import "DPIAPManager.h"

//内购中创建的商品
#define ProductID_IAP01 @"sub.dailytest.weeklypackage"//购买产品ID号


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
    
    //NOTICE
    UIButton *pNotice = [UIButton buttonWithType:UIButtonTypeCustom];
    [pNotice addTarget:self action:@selector(Notice:) forControlEvents:UIControlEventTouchUpInside];
    [pNotice setTitle:@"NOTICE" forState:0];
    pNotice.titleLabel.font = [UIFont fontWithName:[TextManager RegularFont] size:15];
    pNotice.titleLabel.textColor = [UIColor whiteColor];
    pNotice.bounds = CGRectMake(0, 0, 100 * AdaptRate, 44);
    pNotice.center = CGPointMake(self.view.width - pNotice.width * 0.5, NAVIGATION_BAR_Y + pNotice.height * 0.5);
    [self.view addSubview:pNotice];
    
    [DPIAPManager sharedManager].propCheckReceipt = ^(id object) {
        [[DPIAPManager sharedManager]checkReceiptIsValid:[AppConfigure GetEnvironment] firstBuy:^{
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

#pragma mark - iap
- (void)PushToNextPage:(id)argData
{
    if ([[DPIAPManager sharedManager]isHaveReceiptInSandBox]) {
        
        [[DPIAPManager sharedManager]checkReceiptIsValid:[AppConfigure GetEnvironment] firstBuy:^{
            ///第一次购买
            [self PushProtocol];
        } outDate:^{
            ///过期
            [self PushProtocol];

        } inDate:^{
            ///没过期
            [self GetResult];
        }];
    }else{
        [self PushProtocol];
    }
}

- (void)Notice:(UIButton *)button
{
    DPUserProtocolController *pVC = [[DPUserProtocolController alloc]init];
    pVC.notice = @"notice";
    [self PushChildViewController:pVC animated:YES];
}

- (void)GetResult
{
    DPPalmResultController *resultVc = [[DPPalmResultController alloc]init];
    if ([self.analysisType isEqualToString:@"test"]) {
        resultVc.dpResultType = DPResultTest;
        resultVc.testId = self.testId;
    }else if ([self.analysisType isEqualToString:@"palm"]) {
        resultVc.dpResultType = DPResultPalm;
    }
    [self PushChildViewController:resultVc animated:YES];
}

- (void)PushProtocol
{
    DPUserProtocolController *pVC = [[DPUserProtocolController alloc]init];
    if ([self.analysisType isEqualToString:@"test"]) {
        pVC.analysisType = @"test";
        pVC.testId = self.testId;
    }else if ([self.analysisType isEqualToString:@"palm"]) {
        pVC.analysisType = @"palm";
    }
    [self PushChildViewController:pVC animated:YES];
}
@end
