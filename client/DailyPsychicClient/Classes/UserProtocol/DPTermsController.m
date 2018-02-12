//
//  DPTermsController.m
//  DailyPsychicClient
//
//  Created by zhanghe on 2018/2/12.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPTermsController.h"
#import "DPTermsView.h"

@interface DPTermsController ()<AFBaseTableViewDelegate>
{
    DPTermsView *m_pTermsView;
}
@end

@implementation DPTermsController

- (void)viewDidLoad {
    [super viewDidLoad];
    m_pTermsView = [[DPTermsView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    m_pTermsView.proDelegate = self;
    m_pTermsView.propTitle = self.propTitle;
    m_pTermsView.propContent = self.propContent;
    [self.view addSubview:m_pTermsView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 返回以及跳转按钮
- (void)PopPreviousPage
{
    [self.navigationController popViewControllerAnimated:YES];
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
