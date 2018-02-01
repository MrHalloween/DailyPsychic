//
//  DPPalmAnalysisView.m
//  DailyPsychicClient
//
//  Created by 李少艳 on 2018/1/31.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPPalmAnalysisView.h"
#import "UILable+TextEffect.h"

@implementation DPPalmAnalysisView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews
{
    m_pTitleLabel.text =@"Palm analysis";
    //主图形
    UIImageView *pMainImg = [[UIImageView alloc]initWithFrame:CGRectMake(21 * AdaptRate, 102 * AdaptRate, 335 * AdaptRate, 409 * AdaptRate)];
    pMainImg.image = [UIImage imageNamed:@"palm_main"];
    [self addSubview:pMainImg];
    
    //get to result
    UIButton *pGetResultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pGetResultBtn.bounds = CGRectMake(0, 0, 282 * AdaptRate, 63 * AdaptRate);
    pGetResultBtn.center = CGPointMake(self.width/2, self.height - 42 * AdaptRate - 63 * 0.5 * AdaptRate);
    [pGetResultBtn setBackgroundImage:[UIImage imageNamed:@"palm_getresult"] forState:UIControlStateNormal];
    [self addSubview:pGetResultBtn];
}

@end
