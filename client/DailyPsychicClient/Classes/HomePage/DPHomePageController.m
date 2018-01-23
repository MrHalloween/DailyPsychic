//
//  DPHomePageController.m
//  DailyPsychicClient
//
//  Created by zhanghe on 2018/1/23.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPHomePageController.h"
#import "DPHomePageView.h"

@interface DPHomePageController ()
{
    DPHomePageView *m_pHomePageView;
}
@end

@implementation DPHomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    m_pBackButton.hidden = YES;
    m_pNameLabel.text = @"Daily Psychic";
    m_pHomePageView = [[DPHomePageView alloc]initWithFrame:CGRectMake(0, m_pTopBar.bottom, self.view.width, self.view.height - m_pTopBar.bottom)];
    [self.view addSubview:m_pHomePageView];
    
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
