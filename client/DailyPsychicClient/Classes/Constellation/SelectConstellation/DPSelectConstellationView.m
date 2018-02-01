//
//  DPSelectConstellationView.m
//  DailyPsychicClient
//
//  Created by 李少艳 on 2018/1/29.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPSelectConstellationView.h"
#import "UILable+TextEffect.h"
#import "SCHCircleView.h"

@interface DPSelectConstellationView()<SCHCircleViewDataSource,SCHCircleViewDelegate>
{
    SCHCircleView *m_pCircle_view;
}
@end

@implementation DPSelectConstellationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"constellation" ofType:@"plist"];
        NSArray *m_arrConstel = [NSArray arrayWithContentsOfFile: plistPath];
        m_arrData = [NSMutableArray arrayWithArray:m_arrConstel];
        [self addSubViews];
    }
    return self;
}
- (void)addSubViews
{
    // 背景
    UIImageView *pBgImg = [[UIImageView alloc]initWithFrame:self.frame];
    pBgImg.image = [UIImage imageNamed:@"homepage_bg"];
    pBgImg.userInteractionEnabled = YES;
    [self addSubview:pBgImg];
    
    //title
    UILabel *m_pTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 36 * AdaptRate, self.width, 36 * AdaptRate)];
    [m_pTitleLabel SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager RegularFont] FontSize:18 Placehoder:@"Choose your constellation"];
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
    
    //主图-底背景
    UIImageView *pMainImg = [[UIImageView alloc]initWithFrame:CGRectMake(17 * AdaptRate, 102 * AdaptRate, 342 * AdaptRate, 409 * AdaptRate)];
    pMainImg.image = [UIImage imageNamed:@"constellation_main"];
    [pBgImg addSubview:pMainImg];
    
    //旋转的星座
    m_pCircle_view = [[SCHCircleView alloc]initWithFrame:CGRectMake(0, 0, pMainImg.width, pMainImg.height)];
    m_pCircle_view.circle_view_data_source = self;
    m_pCircle_view.circle_view_delegate    = self;
    m_pCircle_view.show_circle_style       = SCHShowCircleDefault;
    m_pCircle_view.circle_layout_style     = SChCircleLayoutNormal;
    [m_pCircle_view reloadData];
    [pMainImg addSubview:m_pCircle_view];
    
    //六芒星
    UIImageView *pHexaganalImg = [[UIImageView alloc]initWithFrame:CGRectMake(88 * AdaptRate, 123 * AdaptRate, 168 * AdaptRate, 168 * AdaptRate)];
    pHexaganalImg.image = [UIImage imageNamed:@"constellation_hexagonal"];
    [pMainImg addSubview:pHexaganalImg];
    
    //星座名称
    UILabel *pNameLabel = [[UILabel alloc]init];
    [pNameLabel SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager HelveticaNeueFont] FontSize:20 Placehoder:@"Aries"];
    pNameLabel.frame = CGRectMake(0, 50 * AdaptRate, pHexaganalImg.width, SIZE_HEIGHT(20));
    pNameLabel.textAlignment = NSTextAlignmentCenter;
    [pHexaganalImg addSubview:pNameLabel];
    
    //星座日期
    UILabel *pDateLable = [[UILabel alloc]init];
    [pDateLable SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager HelveticaNeueFont] FontSize:11 Placehoder:@"03.21 - 04.20"];
    pDateLable.frame = CGRectMake(0, pNameLabel.bottom + 10 * AdaptRate, pHexaganalImg.width, SIZE_HEIGHT(11));
    pDateLable.textAlignment = NSTextAlignmentCenter;
    [pHexaganalImg addSubview:pDateLable];
    
    //start按钮
    UIButton *pStartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pStartBtn.bounds = CGRectMake(0, 0, 282 * AdaptRate, 63 * AdaptRate);
    pStartBtn.center = CGPointMake(self.width/2, self.height - 42 * AdaptRate - 63 * 0.5 * AdaptRate);
    [pStartBtn setBackgroundImage:[UIImage imageNamed:@"constellation_start"] forState:UIControlStateNormal];
    [pStartBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [pBgImg addSubview:pStartBtn];
}
//返回
- (void)backBtnClick
{
    if (self.selectConstellationDel != nil && [self.selectConstellationDel respondsToSelector:@selector(BackTo)])
    {
        [self.selectConstellationDel BackTo];
    }
}
//开始进入下一页
- (void)startBtnClick
{
    if (self.selectConstellationDel != nil && [self.selectConstellationDel respondsToSelector:@selector(StartToNextPage)])
    {
        [self.selectConstellationDel StartToNextPage];
    }
}

@end
