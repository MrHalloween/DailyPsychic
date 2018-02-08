//
//  DPTakePhotoController.m
//  DailyPsychicClient
//
//  Created by zhanghe on 2018/2/1.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPTakePhotoController.h"
#import "DPTakePhotoView.h"
#import "DPPalmAnalyingViewController.h"
#import "DPCustomCameraController.h"

@interface DPTakePhotoController ()<AFBaseTableViewDelegate,DPTakePhotoViewDelegate>
{
    DPTakePhotoView *m_pTakePhotoView;
}
@end

@implementation DPTakePhotoController

- (void)viewDidLoad {
    [super viewDidLoad];
    m_pTopBar.hidden = YES;
    m_pTakePhotoView = [[DPTakePhotoView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    m_pTakePhotoView.proDelegate = self;
    m_pTakePhotoView.takePhotoDelegate = self;
    [self.view addSubview:m_pTakePhotoView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - AFBaseTableViewDelegate
- (void)PopPreviousPage
{
    [self Back];
}

#pragma mark - DPTakePhotoViewDelegate
- (void)TakePhoto
{
    DPCustomCameraController *pVC = [[DPCustomCameraController alloc]init];
    if (m_pTakePhotoView.righthand == 1) {
        pVC.isRight = YES;
    }
    pVC.propBackAction = ^(id object) {
        if (m_pTakePhotoView.righthand == 1) {
            DPPalmAnalyingViewController * Analying = [[DPPalmAnalyingViewController alloc]init];
            [self PushChildViewController:Analying animated:YES];
        }
        m_pTakePhotoView.righthand = 1;
    };
    [self presentViewController:pVC animated:YES completion:nil];
}

@end
