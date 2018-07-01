//
//  DPPlayController.m
//  DailyPsychicClient
//
//  Created by 李少艳 on 2018/4/14.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPPlayController.h"
#import "DPIAPManager.h"
#import "DPHomePageController.h"

//内购中创建的商品
#define ProductID_IAP01 @"test.weeklysub.beer"//购买产品ID号

@interface DPPlayController ()
{
    BOOL m_bIsShow;
}
@end

@implementation DPPlayController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreatBaseView];
    [DPIAPManager sharedManager].propCheckReceipt = ^(id object) {
        [[DPIAPManager sharedManager]checkReceiptIsValid:[AppConfigure GetEnvironment] firstBuy:^{
            ///第一次购买
            [[DPIAPManager sharedManager]requestProductWithProductId:ProductID_IAP01];
        } outDate:^{
            ///过期
            [[DPIAPManager sharedManager]requestProductWithProductId:ProductID_IAP01];
            
        } inDate:^{
            
            ///从首页进入
            DPHomePageController *pVC = [[DPHomePageController alloc]init];
            UINavigationController *pNav = [[UINavigationController alloc]initWithRootViewController:pVC];
            pNav.navigationBar.hidden = YES;
            [UIApplication sharedApplication].keyWindow.rootViewController = pNav;

        }];
    };
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)CreatBaseView
{
    UIImageView *bg = [[UIImageView alloc]init];
    bg.userInteractionEnabled = YES;
    bg.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    bg.image = [UIImage imageNamed:@"bg.jpg"];
    [self.view addSubview:bg];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(Play:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:@"play.png"] forState:0];
    btn.bounds = CGRectMake(0, 0, 290 * [AppConfigure GetLengthAdaptRate], 60 * [AppConfigure GetLengthAdaptRate]);
    btn.center = CGPointMake(self.view.width * 0.5, self.view.height - 50 * [AppConfigure GetLengthAdaptRate] - btn.height * 0.5);
    [bg addSubview:btn];
}

- (void)Play:(UIButton *)argbutton
{
    [self iap];
}

- (void)iap{
    if (m_bIsShow) {
        return;
    }
    [AlertManager ShowProgressHUDWithMessage:@""];
    m_bIsShow = YES;
    [[DPIAPManager sharedManager]requestProductWithProductId:ProductID_IAP01];
}
@end
