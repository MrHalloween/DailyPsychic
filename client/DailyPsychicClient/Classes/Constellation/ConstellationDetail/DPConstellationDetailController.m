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
#import "DPConstellationModel.h"
#import "DPTakePhotoController.h"
#import "DPTestListController.h"
#import "DPIAPManager.h"


//沙盒测试环境验证
#define SANDBOX @"https://sandbox.itunes.apple.com/verifyReceipt"
//正式环境验证
#define AppStore @"https://buy.itunes.apple.com/verifyReceipt"

//内购中创建的商品
#define ProductID_IAP01 @"com.dailypsychic.horoscope01"//购买产品ID号

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
    
    [DPIAPManager sharedManager].propCheckReceipt = ^(id object) {
        [[DPIAPManager sharedManager]checkReceiptIsValid:SANDBOX firstBuy:^{
            ///第一次购买
            [[DPIAPManager sharedManager]requestProductWithProductId:ProductID_IAP01];
        } outDate:^{
            ///过期
            [[DPIAPManager sharedManager]requestProductWithProductId:ProductID_IAP01];
            
        } inDate:^{
            ///没过期
            [self GetResult];
        }];
    };
}

- (void)PopPreviousPage{

    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)PushToNextPage:(id)argData{
    
    NSInteger btnTag = [argData integerValue];
    switch (btnTag) {
        case 100:
        {
            [self iap];
        }
            break;
        case 101:
        {
            DPTestListController *pVC = [[DPTestListController alloc]init];
            [self PushChildViewController:pVC animated:YES];
        }
            break;
        case 102:
        {
            DPTakePhotoController *pVC = [[DPTakePhotoController alloc]init];
            [self PushChildViewController:pVC animated:YES];
        }
            break;
        default:
            break;
    }
   
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

#pragma mark - iap
- (void)iap
{
    if ([[DPIAPManager sharedManager]isHaveReceiptInSandBox]) {
        
        [[DPIAPManager sharedManager]checkReceiptIsValid:SANDBOX firstBuy:^{
            ///第一次购买
            [[DPIAPManager sharedManager]requestProductWithProductId:ProductID_IAP01];
        } outDate:^{
            ///过期
            [[DPIAPManager sharedManager]requestProductWithProductId:ProductID_IAP01];
            
        } inDate:^{
            ///没过期
            [self GetResult];
        }];
        
    }else{
        [[DPIAPManager sharedManager]requestProductWithProductId:ProductID_IAP01];
    }
    
}

- (void)GetResult
{
    DPPalmResultController *pVC = [[DPPalmResultController alloc]init];
    pVC.dpResultType = DPResultConstellation;
    [self PushChildViewController:pVC animated:YES];
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
