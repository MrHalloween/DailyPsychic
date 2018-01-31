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
    // 背景
    UIImageView *pBgImg = [[UIImageView alloc]initWithFrame:self.frame];
    pBgImg.image = [UIImage imageNamed:@"homepage_bg"];
    pBgImg.userInteractionEnabled = YES;
    [self addSubview:pBgImg];
    
    //title
    UILabel *m_pTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 36 * AdaptRate, self.width, 36 * AdaptRate)];
    [m_pTitleLabel SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager RegularFont] FontSize:18 Placehoder:@"Palm analysis"];
    m_pTitleLabel.textAlignment = NSTextAlignmentCenter;
    [pBgImg addSubview:m_pTitleLabel];
    
    //返回按钮
    UIButton *pBackaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pBackaBtn.frame = CGRectMake(0, 35 * AdaptRate, 40 * AdaptRate, 35 * AdaptRate);
    [pBackaBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [pBgImg addSubview:pBackaBtn];
    
    //返回图片
    UIImageView *pBackImg = [[UIImageView alloc]initWithFrame:CGRectMake(16 * AdaptRate, 13 * AdaptRate, 8 *AdaptRate, 14 * AdaptRate)];
    pBackImg.userInteractionEnabled = YES;
    pBackImg.image = [UIImage imageNamed:@"constellation_back"];
    [pBackaBtn addSubview:pBackImg];
    
    //主图形
    UIImageView *pMainImg = [[UIImageView alloc]initWithFrame:CGRectMake(21 * AdaptRate, 102 * AdaptRate, 335 * AdaptRate, 409 * AdaptRate)];
    pMainImg.image = [UIImage imageNamed:@"palm_main"];
    [pBgImg addSubview:pMainImg];
    
    //get to result
    UIButton *pGetResultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pGetResultBtn.bounds = CGRectMake(0, 0, 282 * AdaptRate, 63 * AdaptRate);
    pGetResultBtn.center = CGPointMake(self.width/2, self.height - 42 * AdaptRate - 63 * 0.5 * AdaptRate);
    [pGetResultBtn setBackgroundImage:[UIImage imageNamed:@"constellation_start"] forState:UIControlStateNormal];
    [pBgImg addSubview:pGetResultBtn];
}

//返回
- (void)backBtnClick
{
    if (self.palmAnalysisDel != nil && [self.palmAnalysisDel respondsToSelector:@selector(BackTo)])
    {
        [self.palmAnalysisDel BackTo];
    }
}
@end
