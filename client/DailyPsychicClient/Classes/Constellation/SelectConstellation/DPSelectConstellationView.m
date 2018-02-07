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
    UILabel *m_pNameLabel;//星座名称
    UILabel *m_pDateLable;//星座日期
}
@end

@implementation DPSelectConstellationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSUserDefaults standardUserDefaults]setObject:@(0) forKey:@"selectConstalletion"];
        [[NSUserDefaults standardUserDefaults]synchronize];
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
    m_pNameLabel = [[UILabel alloc]init];
    [m_pNameLabel SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager HelveticaNeueFont] FontSize:20 Placehoder:@"Aries"];
    m_pNameLabel.frame = CGRectMake(0, 60 * AdaptRate, pHexaganalImg.width, SIZE_HEIGHT(20));
    m_pNameLabel.textAlignment = NSTextAlignmentCenter;
    [pHexaganalImg addSubview:m_pNameLabel];
    
    //星座日期
    m_pDateLable = [[UILabel alloc]init];
    [m_pDateLable SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager HelveticaNeueFont] FontSize:11 Placehoder:@"03.21 - 04.20"];
    m_pDateLable.frame = CGRectMake(0, m_pNameLabel.bottom + 10 * AdaptRate, pHexaganalImg.width, SIZE_HEIGHT(11));
    m_pDateLable.textAlignment = NSTextAlignmentCenter;
    [pHexaganalImg addSubview:m_pDateLable];
    
    //旋转的星座
    m_pCircle_view = [[SCHCircleView alloc]initWithFrame:CGRectMake(0, 0, 296 * AdaptRate, 296 * AdaptRate)];
    m_pCircle_view.center = m_pMainImg.center;
    m_pCircle_view.circle_view_data_source = self;
    m_pCircle_view.circle_view_delegate    = self;
    m_pCircle_view.touch_circle_style = SCHTouchCircleDefault;
    m_pCircle_view.show_circle_style       = SCHShowCircleDefault;
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
    DPImageViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"DPImageViewCell" owner:nil options:nil] lastObject];
    DPConstellationModel * model = [DPConstellationModel ModelWithDictionary:m_arrData[index_circle_cell]];
    cell.model = model;
    return cell;
}

/*返回 圆的半径*/
- (CGFloat)radiusOfCircleView:(SCHCircleView *)circle_view
{
    return 251 * AdaptRate * 0.5;
}

/*返回中心点*/
- (CGPoint)centerOfCircleView:(SCHCircleView *)circle_view
{
    return CGPointMake(m_pCircle_view.width * 0.5, m_pCircle_view.height * 0.5);
}

/*点击结束*/
- (void)touchEndCircleViewCell:(SCHCircleViewCell *)cell indexOfCircleViewCell:(NSInteger)index{
    DPConstellationModel * model = [DPConstellationModel ModelWithDictionary:m_arrData[index]];
    m_pNameLabel.text = model.nameEn;
    m_pDateLable.text = model.date;
    [[NSUserDefaults standardUserDefaults]setObject:@(index) forKey:@"selectConstalletion"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

/*拖动结束*/
- (void)dragEndCircleViewCell:(SCHCircleViewCell *)cell indexOfCircleViewCell:(NSInteger)index andCurrentIndex:(NSInteger)currentIndex{
    if (currentIndex == 12) {
        currentIndex = 0;
    }
    DPConstellationModel * model = [DPConstellationModel ModelWithDictionary:m_arrData[currentIndex]];
    m_pNameLabel.text = model.nameEn;
    m_pDateLable.text = model.date;
    [[NSUserDefaults standardUserDefaults]setObject:@(currentIndex) forKey:@"selectConstalletion"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


- (void)setIsPresent:(BOOL)isPresent
{
    _isPresent = isPresent;
    m_pTitleLabel.hidden = isPresent;
    pBackImg.hidden = isPresent;
}

@end
