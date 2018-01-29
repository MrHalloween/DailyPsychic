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

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    m_pTopBar.hidden = YES;
    m_pHomePageView = [[DPHomePageView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    [self.view addSubview:m_pHomePageView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
