//
//  DPHomePageController.m
//  DailyPsychicClient
//
//  Created by zhanghe on 2018/1/23.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPHomePageController.h"
#import "DPHomePageView.h"
#import "DPSelectConstellationController.h"
#import "DPTestCardController.h"

@interface DPHomePageController ()<DPHomePageViewDelegate>
{
    DPHomePageView *m_pHomePageView;
}
@end

@implementation DPHomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    m_pTopBar.hidden = YES;
    m_pHomePageView = [[DPHomePageView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    m_pHomePageView.homePageDel = self;
    [self.view addSubview:m_pHomePageView];
    
}

- (void)PushToDetailByPageNumber:(NSInteger)pageNumber{
    
    BUCustomViewController *pVC;
    switch (pageNumber) {
        case 0: NSLog(@"手相分析"); break;
        case 1: pVC = [[DPSelectConstellationController alloc]init]; break;
        case 2: pVC = [[DPTestCardController alloc]init]; break;
        default:
            break;
    }
    [self PushChildViewController:pVC animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
