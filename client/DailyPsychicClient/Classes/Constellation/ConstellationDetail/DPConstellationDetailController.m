//
//  DPConstellationDetailController.m
//  DailyPsychicClient
//
//  Created by lsy on 2018/1/31.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPConstellationDetailController.h"
#import "DPConstellationDetailView.h"
#import "DPPalmResultController.h"
#import "DPSelectConstellationController.h"

@class DPSelectConstellationController;

@interface DPConstellationDetailController ()<AFBaseTableViewDelegate,DPConstellationDetailDelegate>
{
    DPConstellationDetailView *m_pConstellDetail;
}
@end

@implementation DPConstellationDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    m_pConstellDetail = [[DPConstellationDetailView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    m_pConstellDetail.proDelegate = self;
    m_pConstellDetail.conDetailDel = self;
    [self.view addSubview:m_pConstellDetail];
}

- (void)PopPreviousPage{

    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)PushToNextPage:(id)argData{
    
    NSInteger btnTag = [argData integerValue];
    BUCustomViewController *pVC;
    switch (btnTag) {
        case 100:pVC = [[DPPalmResultController alloc]init];
            break;
        case 101:pVC = [[DPPalmResultController alloc]init];
            break;
        case 102:
            break;
        default:
            break;
    }
    [self PushChildViewController:pVC animated:YES];
}
- (void)PresentToselect{
    
    DPSelectConstellationController * selectVc = [[DPSelectConstellationController alloc]init];
    selectVc.isPresent = YES;
    [self presentViewController:selectVc animated:YES completion:^{
        
    }];
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
