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
    pText.text = @"– The following information about the auto-renewable nature of the subscription• Title of publication or service• Length of subscription (time period and content or services provided during each subscription period)• Price of subscription, and price per unit if appropriate• Payment will be charged to iTunes Account at confirmation of purchase• Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period• Account will be charged for renewal within 24-hours prior to the end of the current period, and identify the cost of the renewal• Subscriptions may be managed by the user and auto-renewal may be turned off by going to the user's Account Settings after purchase• Any unused portion of a free trial period, if offered, will be forfeited when the user purchases a subscription to that publication, where applicable– A link to the terms of use– A link to the privacy policy– The following information about the auto-renewable nature of the subscription• Title of publication or service• Length of subscription (time period and content or services provided during each subscription period)• Price of subscription, and price per unit if appropriate• Payment will be charged to iTunes Account at confirmation of purchase• Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period• Account will be charged for renewal within 24-hours prior to the end of the current period, and identify the cost of the renewal• Subscriptions may be managed by the user and auto-renewal may be turned off by going to the user's Account Settings after purchase• Any unused portion of a free trial period, if offered, will be forfeited when the user purchases a subscription to that publication, where applicable– A link to the terms of use– A link to the privacy policy– The following information about the auto-renewable nature of the subscription• Title of publication or service• Length of subscription (time period and content or services provided during each subscription period)• Price of subscription, and price per unit if appropriate• Payment will be charged to iTunes Account at confirmation of purchase• Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period• Account will be charged for renewal within 24-hours prior to the end of the current period, and identify the cost of the renewal• Subscriptions may be managed by the user and auto-renewal may be turned off by going to the user's Account Settings after purchase• Any unused portion of a free trial period, if offered, will be forfeited when the user purchases a subscription to that publication, where applicable– A link to the terms of use– A link to the privacy policy– The following information about the auto-renewable nature of the subscription• Title of publication or service• Length of subscription (time period and content or services provided during each subscription period)• Price of subscription, and price per unit if appropriate• Payment will be charged to iTunes Account at confirmation of purchase• Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period• Account will be charged for renewal within 24-hours prior to the end of the current period, and identify the cost of the renewal• Subscriptions may be managed by the user and auto-renewal may be turned off by going to the user's Account Settings after purchase• Any unused portion of a free trial period, if offered, will be forfeited when the user purchases a subscription to that publication, where applicable– A link to the terms of use– A link to the privacy policy– The following information about the auto-renewable nature of the subscription• Title of publication or service• Length of subscription (time period and content or services provided during each subscription period)• Price of subscription, and price per unit if appropriate• Payment will be charged to iTunes Account at confirmation of purchase• Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period• Account will be charged for renewal within 24-hours prior to the end of the current period, and identify the cost of the renewal• Subscriptions may be managed by the user and auto-renewal may be turned off by going to the user's Account Settings after purchase• Any unused portion of a free trial period, if offered, will be forfeited when the user purchases a subscription to that publication, where applicable– A link to the terms of use– A link to the privacy policy";
    pText.font = [UIFont fontWithName:[TextManager RegularFont] size:16];
    pText.textColor = [UIColor whiteColor];
    pText.backgroundColor = [UIColor clearColor];
    pText.editable = NO;
    [self addSubview:pText];
    
    //恢复购买
    UIButton *pRestore = [UIButton buttonWithType:UIButtonTypeCustom];
    pRestore.layer.borderColor = [UIColor whiteColor].CGColor;
    pRestore.layer.borderWidth = 2;
    pRestore.layer.masksToBounds = YES;
    pRestore.layer.cornerRadius = 5.0;
    [pRestore addTarget:self action:@selector(Restore:) forControlEvents:UIControlEventTouchUpInside];
    pRestore.bounds = CGRectMake(0, 0, 300 * AdaptRate, 50 * AdaptRate);
    pRestore.center = CGPointMake(self.width * 0.5, pText.bottom + 15 * AdaptRate + pRestore.height * 0.5);
    [pRestore setTitle:@"Restore Purchase" forState:0];
    pRestore.titleLabel.font = [UIFont fontWithName:[TextManager RegularFont] size:18];
    pRestore.titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:pRestore];
    
    NSArray *arr = @[@"Terms of use",@"Privacy policy"];
    for (int i = 0; i < arr.count; i++) {
        UIButton *pProtocol = [UIButton buttonWithType:UIButtonTypeCustom];
        [pProtocol addTarget:self action:@selector(Protocol:) forControlEvents:UIControlEventTouchUpInside];
        pProtocol.bounds = CGRectMake(0, 0,  100 * AdaptRate, 30 * AdaptRate);
        CGFloat centerX = i == 0 ? pRestore.left + pProtocol.width * 0.5 : pRestore.right - pProtocol.width * 0.5;
        pProtocol.center = CGPointMake(centerX, pRestore.bottom + 15 * AdaptRate + pProtocol.height * 0.5);
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
