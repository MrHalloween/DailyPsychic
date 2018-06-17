//
//  DPHomePageController.m
//  DailyPsychicClient
//
//  Created by zhanghe on 2018/1/23.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPHomePageController.h"
#import "DPHomePageView.h"
#import "DPTestListController.h"
#import "DPTakePhotoController.h"
#import "DPBasicInforController.h"

@interface DPHomePageController ()<AFBaseTableViewDelegate>
{
    DPHomePageView *m_pHomePageView;
}
@end

@implementation DPHomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    m_pTopBar.hidden = YES;
    m_pHomePageView = [[DPHomePageView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    m_pHomePageView.proDelegate = self;
    [self.view addSubview:m_pHomePageView];
    
}

- (void)PushToNextPage:(id)argData{
    
    NSInteger pageNumber = [argData integerValue];
    BUCustomViewController *pVC;
    switch (pageNumber) {
        case 0: pVC = [[DPTestListController alloc]init]; break;
        case 1:
        {
            DPBasicInforController * baseVc = [[DPBasicInforController alloc]init];
            baseVc.previousName = @"DPHomePageController";
            pVC = baseVc;
            
        }
            break;
        case 2: pVC = [[DPTakePhotoController alloc]init]; break;
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
