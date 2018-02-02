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
#import "DPImageViewCell.h"
#import "DPConstellationModel.h"

@interface DPSelectConstellationView()<SCHCircleViewDataSource,SCHCircleViewDelegate>
{
    SCHCircleView *m_pCircle_view;
    UIImageView *m_pMainImg;
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
        [m_pCircle_view reloadData];
    }
    return self;
}
- (void)addSubViews
{
    self.userInteractionEnabled = YES;
    
    m_pTitleLabel.text = @"Choose your constellation";
    //主图-底背景684817
    m_pMainImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 342 * AdaptRate, 408.5 * AdaptRate)];
    m_pMainImg.center = CGPointMake(self.width * 0.5, m_pTitleLabel.bottom + 38 * AdaptRate + m_pMainImg.height * 0.5);
    m_pMainImg.image = [UIImage imageNamed:@"constellation_main"];
    m_pMainImg.userInteractionEnabled = YES;
    [self addSubview:m_pMainImg];
    
    //六芒星336336
    UIImageView *pHexaganalImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 168 * AdaptRate, 168 * AdaptRate)];
    pHexaganalImg.center = CGPointMake(m_pMainImg.width * 0.5, m_pMainImg.height * 0.5);
    pHexaganalImg.userInteractionEnabled = YES;
    pHexaganalImg.image = [UIImage imageNamed:@"constellation_hexagonal"];
    [m_pMainImg addSubview:pHexaganalImg];

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
    
    //旋转的星座
    m_pCircle_view = [[SCHCircleView alloc]initWithFrame:CGRectMake(0, 0, 344 * AdaptRate, 344 * AdaptRate)];
    m_pCircle_view.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.2];
    m_pCircle_view.center = m_pMainImg.center;
    m_pCircle_view.circle_view_data_source = self;
    m_pCircle_view.circle_view_delegate    = self;
    m_pCircle_view.show_circle_style       = SChShowCircleWinding;
    m_pCircle_view.circle_layout_style = SChCircleLayoutNormal;
    [self addSubview:m_pCircle_view];
    
    //start按钮
    UIButton *pStartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pStartBtn.bounds = CGRectMake(0, 0, 282 * AdaptRate, 63 * AdaptRate);
    pStartBtn.center = CGPointMake(self.width/2, self.height - 42 * AdaptRate - 63 * 0.5 * AdaptRate);
    [pStartBtn setBackgroundImage:[UIImage imageNamed:@"constellation_start"] forState:UIControlStateNormal];
    [pStartBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:pStartBtn];
}

//开始进入下一页
- (void)startBtnClick
{
    if (self.proDelegate != nil && [self.proDelegate respondsToSelector:@selector(PushToNextPage:)])
    {
        [self.proDelegate PushToNextPage:nil];
    }
}

#pragma mark - SCHCircleViewDataSource
- (NSInteger)numberOfCellInCircleView:(SCHCircleView *)circle_view
{
    return m_arrData.count;
}

- (SCHCircleViewCell *)circleView:(SCHCircleView *)circle_view cellAtIndex:(NSInteger)index_circle_cell
{
    DPImageViewCell *cell = [[DPImageViewCell alloc]init];
    DPConstellationModel * model = [DPConstellationModel ModelWithDictionary:m_arrData[index_circle_cell]];
    cell.model = model;
    return cell;
}

/*返回 圆的半径*/
- (CGFloat)radiusOfCircleView:(SCHCircleView *)circle_view
{
    return 252 * AdaptRate * 0.5;
}

/*返回中心点*/
- (CGPoint)centerOfCircleView:(SCHCircleView *)circle_view
{
    return CGPointMake(m_pCircle_view.width * 0.5 - 23 * AdaptRate, m_pCircle_view.height * 0.5 - 23 * AdaptRate);
}



@end
