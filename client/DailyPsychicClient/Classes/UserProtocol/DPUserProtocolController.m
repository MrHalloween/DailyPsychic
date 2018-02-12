//
//  DPUserProtocolController.m
//  DailyPsychicClient
//
//  Created by zhanghe on 2018/2/12.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPUserProtocolController.h"
#import "DPUserProtocolView.h"
#import "DPTermsController.h"

@interface DPUserProtocolController ()<AFBaseTableViewDelegate,DPUserProtocolViewDelegate>
{
    DPUserProtocolView *m_pUserProtocolView;
}
@end

@implementation DPUserProtocolController

- (void)viewDidLoad {
    [super viewDidLoad];
    m_pUserProtocolView = [[DPUserProtocolView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    m_pUserProtocolView.proDelegate = self;
    m_pUserProtocolView.userDelegate = self;
    [self.view addSubview:m_pUserProtocolView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 返回以及跳转按钮
- (void)PopPreviousPage
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - DPUserProtocolViewDelegate
///恢复购买
- (void)RestorePurchase
{
    NSLog(@"Restore Purchase");
    [AlertManager ShowProgressHUDWithMessage:@"Restoring..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [AlertManager HideProgressHUD];
        BOOL isBuy = [mUserDefaults boolForKey:@"isbuy"];
        if (isBuy) {
            [AlertManager ShowRelutWithMessage:@"Restore Defeat !!!" Dismiss:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else{
            [AlertManager ShowRelutWithMessage:@"Please buy it first !!!" Dismiss:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }

    });
}
///用户协议
- (void)UserProtocolWithTitle:(NSString *)title
{
    DPTermsController *pVC = [[DPTermsController alloc]init];
    if ([title isEqualToString:@"Terms of use"]) {
        NSLog(@"Terms of use");
        pVC.propTitle = @"Terms of use";
        pVC.propContent = @"Terms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of useTerms of use";
    }else{
        NSLog(@"Privacy policy");
        pVC.propTitle = @"Privacy policy";
        pVC.propContent = @"Privacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policyPrivacy policy";

    }
    [self PushChildViewController:pVC animated:YES];
}
@end
