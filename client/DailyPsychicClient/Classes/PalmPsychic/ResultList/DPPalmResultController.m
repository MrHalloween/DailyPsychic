//
//  DPPalmResultController.m
//  DailyPsychicClient
//
//  Created by lsy on 2018/2/1.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPPalmResultController.h"
#import "DPPalmResultView.h"

@interface DPPalmResultController ()<AFBaseTableViewDelegate>
{
    DPPalmResultView *m_pPalmResultView;
}
@end

@implementation DPPalmResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    m_pPalmResultView = [[DPPalmResultView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    m_pPalmResultView.proDelegate = self;
    [self.view addSubview:m_pPalmResultView];
}
- (void)PopPreviousPage
{
    [self.navigationController popToRootViewControllerAnimated:YES];
//    [self Back];
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
