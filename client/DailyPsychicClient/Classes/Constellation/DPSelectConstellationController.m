//
//  DPSelectConstellationController.m
//  DailyPsychicClient
//
//  Created by 李少艳 on 2018/1/29.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPSelectConstellationController.h"
#import "DPSelectConstellationView.h"
@interface DPSelectConstellationController ()
{
    DPSelectConstellationView *m_pSelectView;
}
@end

@implementation DPSelectConstellationController

- (void)viewDidLoad {
    [super viewDidLoad];
    m_pNameLabel.text = @"Choose your constellation";
    [m_pBackButton setBackgroundImage:[UIImage imageNamed:@"constellation_back"] forState:UIControlStateNormal];
    m_pSelectView = [[DPSelectConstellationView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    [self.view addSubview:m_pSelectView];
    
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