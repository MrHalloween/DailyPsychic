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
//        m_arrData = [NSMutableArray arrayWithObjects:@{@"id":@0,@"title":@"手相分析",@"image":@"homepage_card_hand.png"},
//                     @{@"id":@1,@"title":@"星座",@"image":@"homepage_card_star.png"},
//                     @{@"id":@2,@"title":@"测试",@"image":@"homepage_card_test.png"}, nil];
        [self addSubViews];
    }
    return self;
}
- (void)addSubViews
{
    // 背景
    UIImageView *pbgImg = [[UIImageView alloc]initWithFrame:self.frame];
    pbgImg.image = [UIImage imageNamed:@"homepage_bg"];
    pbgImg.userInteractionEnabled = YES;
    [self addSubview:pbgImg];
    
    //主图-底背景
    UIImageView *pmainImg = [[UIImageView alloc]initWithFrame:CGRectMake(17 * AdaptRate, 102 * AdaptRate, 342 * AdaptRate, 409 * AdaptRate)];
    pmainImg.image = [UIImage imageNamed:@"constellation_main"];
    [pbgImg addSubview:pmainImg];
    
    //旋转的星座
    m_pCircle_view = [[SCHCircleView alloc]initWithFrame:CGRectMake(0, 0, pmainImg.width, pmainImg.height)];
    m_pCircle_view.circle_view_data_source = self;
    m_pCircle_view.circle_view_delegate    = self;
    m_pCircle_view.show_circle_style       = SCHShowCircleDefault;
    m_pCircle_view.circle_layout_style     = SChCircleLayoutNormal;
    [m_pCircle_view reloadData];
    [pmainImg addSubview:m_pCircle_view];
    
    //六芒星
    UIImageView *phexaganalImg = [[UIImageView alloc]initWithFrame:CGRectMake(88 * AdaptRate, 123 * AdaptRate, 168 * AdaptRate, 168 * AdaptRate)];
    phexaganalImg.image = [UIImage imageNamed:@"constellation_hexagonal"];
    [pmainImg addSubview:phexaganalImg];
    
    //星座名称
    UILabel *pnameLabel = [[UILabel alloc]init];
    [pnameLabel SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager RegularFont] FontSize:20 Placehoder:@"Aries"];
    pnameLabel.frame = CGRectMake(0, 50 * AdaptRate, phexaganalImg.width, SIZE_HEIGHT(20));
    pnameLabel.textAlignment = NSTextAlignmentCenter;
    [phexaganalImg addSubview:pnameLabel];
    
    //星座日期
    UILabel *pdateLable = [[UILabel alloc]init];
    [pdateLable SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager RegularFont] FontSize:11 Placehoder:@"03.21 - 04.20"];
    pdateLable.frame = CGRectMake(0, pnameLabel.bottom + 10 * AdaptRate, phexaganalImg.width, SIZE_HEIGHT(11));
    pdateLable.textAlignment = NSTextAlignmentCenter;
    [phexaganalImg addSubview:pdateLable];
    
    //start按钮
    UIButton *pstartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pstartBtn.bounds = CGRectMake(0, 0, 282 * AdaptRate, 63 * AdaptRate);
    pstartBtn.center = CGPointMake(self.width/2, self.height - 42 * AdaptRate - 63 * 0.5 * AdaptRate);
    [pstartBtn setBackgroundImage:[UIImage imageNamed:@"constellation_start"] forState:UIControlStateNormal];
    [pbgImg addSubview:pstartBtn];
    
    
}


@end
