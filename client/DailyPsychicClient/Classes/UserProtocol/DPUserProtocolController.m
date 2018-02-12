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
        pVC.propContent = @"THIS SERVICE \"DAILY PSYCHIC\" IS PROVIDED FOR ENTERTAINMENT PURPOSES ONLY. YOU MUST BE EIGHTEEN YEARS OF AGE OR OLDER TO USE THIS SERVICE. HOWEVER, THIS INFORMATION SHOULD NOT BE USED IN PLACE OF ANY RECOMMENDATIONS BY MEDICAL, LEGAL, OR FINANCIAL PROFESSIONALS OR OTHER PROFESSIONAL COUNSELORS. IT IS YOUR RESPONSIBILITY TO EVALUATE ANY INFORMATION, OPINION, ADVICE OR OTHER CONTENT AVAILABLE THROUGH \"Daily Psychic\" .\n\nThe use of the \"Daily Psychic\" app is governed by these Terms of Use. By using \"Daily Psychic\", you acknowledge that you have read the Terms of Use and the disclaimers contained therein and that you accept and agree to be bound by the terms thereof.\n\nBy accessing materials on \"Daily Psychic\" app, you agree with these Terms of Use. \"Daily Psychic\" reserves the right, at its sole discretion, to change these Terms of Use from time to time, and your access to the app will be deemed to be your acceptance of, and agreement, to any such changed terms and conditions.\n\nTERMS OF SERVICE\n\nThe Services and information in the app are provided for entertainment purposes only and do not constitute legal, financial, medical or any other sort of professional advice of any kind.\n\nYour use of any information or materials on this app is entirely at your own risk, for which we shall not be liable. It shall be your own responsibility to ensure that any products, services or information available through this app meet your specific requirements.\n\nThis app contains material which is owned by or licensed to us. This material includes, but is not limited to, the design, layout, look, appearance and graphics. Reproduction is prohibited other than in accordance with the copyright notice, which forms part of these terms and conditions.\n\nAll trade marks reproduced in this app which are not the property of, or licensed to, the operator are acknowledged on the app.\n\nUnauthorised use of this app may give rise to a claim for damages and/or be a criminal offence.";
    }else{
        NSLog(@"Privacy policy");
        pVC.propTitle = @"Privacy policy";
        pVC.propContent = @"We take the privacy of all visitors to this application very seriously and therefore set out in this privacy policy our position regarding certain privacy matters.\n\nThis privacy policy covers all data that is shared by a visitor with us, via our app.\n\nThis app privacy policy has been is occasionally updated by us so please do re-review from time to time.\n\nOur Privacy Policy provides an explanation as to what happens to any personal data that you share with us, or that we collect from you either directly via this application or via email support.\n\nInformation We Collect\n\nIn operating our app we may collect and process the following data about you:\n\nDetails of your visits to our app and the resources that you access, including, but not limited to, traffic data, location data, interactions with the our App or other.";

    }
    [self PushChildViewController:pVC animated:YES];
}
@end
