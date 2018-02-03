//
//  DPBasicInforController.m
//  DailyPsychicClient
//
//  Created by lsy on 2018/2/2.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPBasicInforController.h"
#import "DPBasicInforView.h"
#import "DPSelectConstellationController.h"
#import "DPTestCardController.h"

@interface DPBasicInforController ()<AFBaseTableViewDelegate>
{
    DPBasicInforView * m_pBasicView;
}
@end

@implementation DPBasicInforController

- (void)viewDidLoad {
    [super viewDidLoad];
    m_pBasicView = [[DPBasicInforView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    m_pBasicView.proDelegate = self;
    [self.view addSubview:m_pBasicView];
}
- (void)PopPreviousPage{
    [self Back];
}
- (void)PushToNextPage:(id)argData
{
    if ([self.previousName isEqualToString:@"DPTestListController"] ) {//测试
        
        DPTestCardController * testVc = [[DPTestCardController alloc]init];
        testVc.testId = self.testId;
        [self PushChildViewController:testVc animated:YES];
        
    }else if ([self.previousName isEqualToString:@"DPHomePageController"]){//选择星座
        
        DPSelectConstellationController * selectVc = [[DPSelectConstellationController alloc]init];
        [self PushChildViewController:selectVc animated:YES];
    }
    
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
