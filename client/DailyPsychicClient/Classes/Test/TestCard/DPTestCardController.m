//
//  DPTestCardController.m
//  DailyPsychicClient
//
//  Created by zhanghe on 2018/1/30.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPTestCardController.h"
#import "DPTestCardView.h"

@interface DPTestCardController ()
{
    DPTestCardView *m_pTestCardView;
}
@end

@implementation DPTestCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    m_pTopBar.hidden = YES;
    m_pTestCardView = [[DPTestCardView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    [self.view addSubview:m_pTestCardView];
    // Do any additional setup after loading the view.
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
