//
//  DPUserProtocolView.m
//  DailyPsychicClient
//
//  Created by zhanghe on 2018/2/12.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPUserProtocolView.h"

@implementation DPUserProtocolView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews
{
    m_pTitleLabel.text =@"SUBSCRIPTION INFO";
    //主图形
    UIImageView *pMainImg = [[UIImageView alloc]initWithFrame:CGRectMake(21 * AdaptRate, 102 * AdaptRate, 335 * AdaptRate, 409 * AdaptRate)];
    pMainImg.center = CGPointMake(self.width/2, self.height/2 - 30 * AdaptRate);
    pMainImg.image = [UIImage imageNamed:@"palm_main"];
    [self addSubview:pMainImg];
    
    //
    UITextView *pText = [[UITextView alloc]init];
    pText.bounds = CGRectMake(0, 0, self.width - 15 * AdaptRate, self.height - m_pTitleLabel.bottom - 125 * AdaptRate);
    pText.center = CGPointMake(self.width * 0.5, m_pTitleLabel.bottom + pText.height * 0.5);
    pText.text = @"Some items require subscription for full functionality:\n\n- If you want to receive an unlimited number of notifications on the clock from your device, then you need this subscription.\n- Title of publications or services: MEDIUM PREMIUM ACCOUNT\n- Length and prices of subscription: 3 days for free, then 0.99$ per week.\n- Payment will be charged to iTunes Account at confirmation of purchase\n- Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period\n- Account will be charged for renewal within 24-hours prior to the end of the current period, and identify the cost of the renewal.\n- Subscriptions may be managed by the user and auto-renewal may be turned off by going to the user's Account Settings after purchase.\n- No cancellation of the current subscription is allowed during active subscription period.\n- You can cancel your subscription via this url: https://support.apple.com/en-us/HT202039";
    pText.font = [UIFont fontWithName:[TextManager RegularFont] size:16];
    pText.textColor = [UIColor whiteColor];
    pText.backgroundColor = [UIColor clearColor];
    pText.editable = NO;
    [self addSubview:pText];
    
    //Try Now
    UIButton *pTryNow = [UIButton buttonWithType:UIButtonTypeCustom];
    [pTryNow addTarget:self action:@selector(Restore:) forControlEvents:UIControlEventTouchUpInside];
    pTryNow.bounds = CGRectMake(0, 0, 282 * AdaptRate, 63 * AdaptRate);
    pTryNow.center = CGPointMake(self.width * 0.5, pText.bottom + pTryNow.height * 0.5);
    [pTryNow setTitle:@"Try Now" forState:0];
    [pTryNow setBackgroundImage:[UIImage imageNamed:@"constellation_bgblue"] forState:UIControlStateNormal];
    pTryNow.titleLabel.font = [UIFont fontWithName:[TextManager RegularFont] size:18];
    pTryNow.titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:pTryNow];
    
    //恢复购买
    UIButton *pRestore = [UIButton buttonWithType:UIButtonTypeCustom];
    [pRestore addTarget:self action:@selector(Restore:) forControlEvents:UIControlEventTouchUpInside];
    pRestore.bounds = CGRectMake(0, 0, 150 * AdaptRate, 20 * AdaptRate);
    pRestore.center = CGPointMake(self.width * 0.5, pTryNow.bottom + pRestore.height * 0.5);
    [pRestore setTitle:@"Restore Purchase" forState:0];
    pRestore.titleLabel.font = [UIFont fontWithName:[TextManager RegularFont] size:14];
    pRestore.titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:pRestore];
    
    NSArray *arr = @[@"Terms of use",@"Privacy policy"];
    for (int i = 0; i < arr.count; i++) {
        UIButton *pProtocol = [UIButton buttonWithType:UIButtonTypeCustom];
        [pProtocol addTarget:self action:@selector(Protocol:) forControlEvents:UIControlEventTouchUpInside];
        if ([[UIDevice currentDevice].model isEqualToString:@"iPad"]) {
            pProtocol.bounds = CGRectMake(0, 0,  150 * AdaptRate, 30 * AdaptRate);
        }else{
            pProtocol.bounds = CGRectMake(0, 0,  100 * AdaptRate, 30 * AdaptRate);
        }
        CGFloat centerX = i == 0 ? pTryNow.left + pProtocol.width * 0.5 : pTryNow.right - pProtocol.width * 0.5;
        pProtocol.center = CGPointMake(centerX, pRestore.bottom + pProtocol.height * 0.5);
        [pProtocol setTitle:arr[i] forState:0];
        pProtocol.titleLabel.font = [UIFont fontWithName:[TextManager RegularFont] size:16];
        pProtocol.titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:pProtocol];
        
    }
}

- (void)Restore:(UIButton *)argButton
{
    if (self.userDelegate && [self.userDelegate respondsToSelector:@selector(RestorePurchase)]) {
        [self.userDelegate RestorePurchase];
    }
}

- (void)Protocol:(UIButton *)argButton
{
    if (self.userDelegate && [self.userDelegate respondsToSelector:@selector(UserProtocolWithTitle:)]) {
        [self.userDelegate UserProtocolWithTitle:[argButton titleForState:0]];
    }
}

@end
