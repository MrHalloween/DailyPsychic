//
//  DPTestListController.m
//  DailyPsychicClient
//
//  Created by zhanghe on 2018/1/31.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPTestListController.h"
#import "DPTestListView.h"
#import "DPTestCardController.h"

@interface DPTestListController ()<AFBaseTableViewDelegate>
{
    DPTestListView *m_pTestListView;
}
@end

@implementation DPTestListController

- (void)viewDidLoad {
    [super viewDidLoad];
    m_pTopBar.hidden = YES;
    m_pTestListView = [[DPTestListView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    m_pTestListView.proDelegate = self;
    [self.view addSubview:m_pTestListView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - AFBaseTableViewDelegate
-(void)PushToNextPage:(id)argData
{
    DPTestCardController *pVC = [[DPTestCardController alloc]init];
    [self PushChildViewController:pVC animated:YES];
}

- (void)PopPreviousPage
{
    [self Back];
}

@end
