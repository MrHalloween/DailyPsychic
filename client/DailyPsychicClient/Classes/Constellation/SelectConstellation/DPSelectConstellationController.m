//
//  DPSelectConstellationController.m
//  DailyPsychicClient
//
//  Created by 李少艳 on 2018/1/29.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPSelectConstellationController.h"
#import "DPSelectConstellationView.h"
#import "DPConstellationDetailController.h"

@interface DPSelectConstellationController ()<SelectConstellationDelegate,AFBaseTableViewDelegate>
{
    DPSelectConstellationView *m_pSelectView;
}
@end

@implementation DPSelectConstellationController

- (void)viewDidLoad {
    [super viewDidLoad];
    m_pSelectView = [[DPSelectConstellationView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    m_pSelectView.proDelegate = self;
    m_pSelectView.selectConstellationDel = self;
    [self.view addSubview:m_pSelectView];
    
}

- (void)PopPreviousPage
{
    [self Back];
}
- (void)StartToNextPage
{
    DPConstellationDetailController *detailVc = [[DPConstellationDetailController alloc]init];
    [self PushChildViewController:detailVc animated:YES];
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
