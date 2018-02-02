
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


@interface DPPalmAnalysisController ()<AFBaseTableViewDelegate>
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
}

- (void)PopPreviousPage
{
    [self Back];
}
- (void)PushToNextPage:(id)argData{
    
    DPPalmResultController *resultVc = [[DPPalmResultController alloc]init];
    [self PushChildViewController:resultVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
