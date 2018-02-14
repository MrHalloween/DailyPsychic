
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

}
#pragma mark - 返回以及跳转按钮
- (void)PopPreviousPage
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - iap
- (void)PushToNextPage:(id)argData
{
    BOOL isbuy = [mUserDefaults boolForKey:@"isbuy"];
    if (isbuy)
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
    else
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
}

- (void)Notice:(UIButton *)button
{
    DPUserProtocolController *pVC = [[DPUserProtocolController alloc]init];
    pVC.notice = @"notice";
    [self PushChildViewController:pVC animated:YES];
}
@end
