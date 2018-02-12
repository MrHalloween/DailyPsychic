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
#import "DPUserProtocolController.h"


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
    BOOL m_bIsShow;
}
@end

@implementation DPConstellationDetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    m_pConstellDetail = [[DPConstellationDetailView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    m_pConstellDetail.proDelegate = self;
    m_pConstellDetail.conDetailDel = self;
    [self.view addSubview:m_pConstellDetail];
    
    //NOTICE
    UIButton *pNotice = [UIButton buttonWithType:UIButtonTypeCustom];
    [pNotice addTarget:self action:@selector(Notice:) forControlEvents:UIControlEventTouchUpInside];
    [pNotice setTitle:@"NOTICE" forState:0];
    pNotice.titleLabel.font = [UIFont fontWithName:[TextManager RegularFont] size:15];
    pNotice.titleLabel.textColor = [UIColor whiteColor];
    pNotice.bounds = CGRectMake(0, 0, 100 * AdaptRate, 44);
    pNotice.center = CGPointMake(self.view.width - pNotice.width * 0.5, NAVIGATION_BAR_Y + pNotice.height * 0.5);
    [self.view addSubview:pNotice];
    
    [DPIAPManager sharedManager].propCheckReceipt = ^(id object) {
        [[DPIAPManager sharedManager]checkReceiptIsValid:AppStore firstBuy:^{
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
            if (m_bIsShow) {
                return;
            }
            [AlertManager ShowProgressHUDWithMessage:@""];
            m_bIsShow = YES;
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
        
        [[DPIAPManager sharedManager]checkReceiptIsValid:AppStore firstBuy:^{
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
    m_bIsShow = NO;
    [AlertManager HideProgressHUD];
    DPPalmResultController *pVC = [[DPPalmResultController alloc]init];
    pVC.dpResultType = DPResultConstellation;
    [self PushChildViewController:pVC animated:YES];
}

- (void)Notice:(UIButton *)argButton
{
    DPUserProtocolController *pVC = [[DPUserProtocolController alloc]init];
    [self PushChildViewController:pVC animated:YES];
}
@end
