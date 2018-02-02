//
//  DPTestCardController.m
//  DailyPsychicClient
//
//  Created by zhanghe on 2018/1/30.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPTestCardController.h"
#import "DPTestCardView.h"

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
    NSLog(@"选择了一个答案");
    DPTestCardController *pVC = [[DPTestCardController alloc]init];
    [self PushChildViewController:pVC animated:YES];
}

@end
