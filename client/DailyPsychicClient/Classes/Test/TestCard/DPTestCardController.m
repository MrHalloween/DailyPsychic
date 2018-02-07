//
//  DPTestCardController.m
//  DailyPsychicClient
//
//  Created by zhanghe on 2018/1/30.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPTestCardController.h"
#import "DPTestCardView.h"
#import "DPPalmAnalysisController.h"

@interface DPTestCardController ()<AFBaseTableViewDelegate,DPTestCardViewDelegate>
{
    DPTestCardView *m_pTestCardView;
    NSInteger m_nPageNum;
}
@end

@implementation DPTestCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    m_pTopBar.hidden = YES;
    m_pTestCardView = [[DPTestCardView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    ///从测试列表进入
    if (self.testId.length) {
        [[NSUserDefaults standardUserDefaults] setObject:self.testId forKey:@"testidtestid"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        m_pTestCardView.testId = self.testId;
    }
    if (self.dictTest) {
        m_pTestCardView.dictTest = self.dictTest;
    }
    m_pTestCardView.proDelegate = self;
    m_pTestCardView.testCardDelegate = self;
    [self.view addSubview:m_pTestCardView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - AFBaseTableViewDelegate
- (void)PopPreviousPage
{
    [self Back];
}

- (void)SelectedAnswer
{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"questions"]];
    if (arr.count == 0) {
        DPPalmAnalysisController *pVC = [[DPPalmAnalysisController alloc]init];
        pVC.analysisType = @"test";
        NSString *testid = [[NSUserDefaults standardUserDefaults]objectForKey:@"testidtestid"];
        pVC.testId = testid;
        [self PushChildViewController:pVC animated:YES];

    }else{
        NSLog(@"选择了一个答案");
        DPTestCardController *pVC = [[DPTestCardController alloc]init];
        pVC.dictTest = arr[0];
        [arr removeObjectAtIndex:0];
        [[NSUserDefaults standardUserDefaults]setObject:arr forKey:@"questions"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self PushChildViewController:pVC animated:YES];
    }

}

@end
