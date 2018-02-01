//
//  DPPalmAnalyingViewController.m
//  DailyPsychicClient
//
//  Created by 李少艳 on 2018/2/1.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPPalmAnalyingViewController.h"
#import "DPPalmAnaylyingView.h"

@interface DPPalmAnalyingViewController ()
{
    DPPalmAnaylyingView * m_pPalmAnaylyingView;
}
@end

@implementation DPPalmAnalyingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    m_pPalmAnaylyingView = [[DPPalmAnaylyingView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    [self.view addSubview:m_pPalmAnaylyingView];
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
