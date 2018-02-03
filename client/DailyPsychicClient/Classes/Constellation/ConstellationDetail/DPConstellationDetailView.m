//
//  DPConstellationDetailView.m
//  DailyPsychicClient
//
//  Created by lsy on 2018/1/31.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPConstellationDetailView.h"
#import "UILable+TextEffect.h"
#import "DPWeekCollectionViewCell.h"
#import "NSString+TimeFormat.h"
#import "DPConstellationModel.h"

@interface DPConstellationDetailView()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *m_pWeekCollectionView;
    UIButton *m_pDateBtn;
    UIScrollView *m_pScrollView;
}
@end

@implementation DPConstellationDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        m_pTitleLabel.text = @"Start";
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"constellation" ofType:@"plist"];
        NSArray *m_arrConstel = [NSArray arrayWithContentsOfFile: plistPath];
        m_arrData = [NSMutableArray arrayWithArray:m_arrConstel];
        [self addCollectionView];
        [self addScrolllview];
        [self addDetailView];
        [self addlistView];
    }
    return self;
}

//collection
- (void)addCollectionView
{
    CGRect rect = CGRectMake(0, 96 * AdaptRate, self.width, 74 * AdaptRate);
    UICollectionViewFlowLayout *profileLayout = [[UICollectionViewFlowLayout alloc] init];
    profileLayout.minimumLineSpacing = 0;
    profileLayout.minimumInteritemSpacing = 0;
    profileLayout.itemSize = CGSizeMake(self.width/7, 67 * AdaptRate);
    m_pWeekCollectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:profileLayout];
    [m_pWeekCollectionView registerClass:[DPWeekCollectionViewCell class] forCellWithReuseIdentifier:WeekCollectionViewCell];
    m_pWeekCollectionView.delegate = self;
    m_pWeekCollectionView.dataSource = self;
    m_pWeekCollectionView.backgroundColor = [UIColor clearColor];
    [self addSubview:m_pWeekCollectionView];
}
//Scrolllview
- (void)addScrolllview{
    m_pScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, m_pWeekCollectionView.bottom, self.width, self.height - m_pWeekCollectionView.bottom)];
    m_pScrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:m_pScrollView];
}
//日期 星座
- (void)addDetailView
{
    // 左 日期
    m_pDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    m_pDateBtn.frame = CGRectMake(0, 35 * AdaptRate, self.width/2,45 * AdaptRate);
    [m_pScrollView addSubview:m_pDateBtn];
    
    //today
    UILabel *m_pTodayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, m_pDateBtn.width, SIZE_HEIGHT(15))];
    [m_pTodayLabel SetTextColor:UIColorFromHex(0xFFFFFF) FontName:[TextManager HelveticaNeueThinFont] FontSize:15 Placehoder:@"TODAY"];
    m_pTodayLabel.textAlignment = NSTextAlignmentCenter;
    [m_pDateBtn addSubview:m_pTodayLabel];

    //日期
    UILabel *m_pDateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, m_pTodayLabel.bottom + 5 * AdaptRate, m_pDateBtn.width, SIZE_HEIGHT(20))];
    NSString *currentDate = [NSString GetCurrentTimesWithFormat:@"yyyy.MM.dd"];
    [m_pDateLabel SetTextColor:UIColorFromHex(0xFFFFFF) FontName:[TextManager HelveticaNeueFont] FontSize:20 Placehoder:currentDate];
    m_pDateLabel.textAlignment = NSTextAlignmentCenter;
    [m_pDateBtn addSubview:m_pDateLabel];
    
    // 中间 横杠
    UIView *m_pLineView = [[UIView alloc]initWithFrame:CGRectMake(self.width/2 - 2 * AdaptRate, 11 * AdaptRate, 2 * AdaptRate, 22 * AdaptRate)];
    m_pLineView.backgroundColor = [UIColor whiteColor];
    m_pLineView.alpha = 0.6;
    [m_pDateBtn addSubview:m_pLineView];
    
    // 右 星座
    UIButton *m_pConstellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    m_pConstellBtn.frame = CGRectMake(self.width/2, 35 * AdaptRate, self.width/2,45 * AdaptRate);
//    [m_pConstellBtn addTarget:self action:@selector() forControlEvents:UIControlEventTouchUpInside];
    [m_pScrollView addSubview:m_pConstellBtn];
    
    //start
    UILabel *m_pStartLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, m_pConstellBtn.width, SIZE_HEIGHT(15))];
    [m_pStartLabel SetTextColor:UIColorFromHex(0xFFFFFF) FontName:[TextManager HelveticaNeueThinFont] FontSize:15 Placehoder:@"Start"];
    m_pStartLabel.textAlignment = NSTextAlignmentCenter;
    [m_pConstellBtn addSubview:m_pStartLabel];
    
    //星座
    NSInteger m_lindex = [[[NSUserDefaults standardUserDefaults]objectForKey:@"selectConstalletion"] integerValue];
    UILabel *m_pConstellLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, m_pStartLabel.bottom + 5 * AdaptRate, 0, 0)];
    DPConstellationModel * model = [DPConstellationModel ModelWithDictionary:m_arrData[m_lindex]];
    [m_pConstellLabel SetTextColor:UIColorFromHex(0xFFFFFF) FontName:[TextManager HelveticaNeueFont] FontSize:20 Placehoder:model.nameEn];
    [m_pConstellLabel sizeToFit];
    CGPoint center = m_pConstellLabel.center;
    center.x = m_pConstellBtn.width * 0.5;
    m_pConstellLabel.center = center;
    m_pConstellLabel.textAlignment = NSTextAlignmentCenter;
    [m_pConstellBtn addSubview:m_pConstellLabel];
    
    //向下箭头
    UIImageView *m_pArrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(m_pConstellLabel.right + 10 * AdaptRate, m_pConstellLabel.top + 8 * AdaptRate, 12 * AdaptRate, 8 * AdaptRate)];
    m_pArrowImg.image = [UIImage imageNamed:@"constellation_detail_triangle"];
    [m_pConstellBtn addSubview:m_pArrowImg];
    
}
//手相分析等
- (void)addlistView
{
    NSArray *m_pBgImgArr = @[@"constellation_detail_counselor",@"constellation_detail_palma",@"constellation_detail_daytest"];
    NSArray *m_ptitleArr = @[@"Consultation",@"Palm analysis",@"Daily test"];
    
    for (int i = 0; i < 3; i ++) {
        //button背景
        UIButton *m_pConsultation = [UIButton buttonWithType:UIButtonTypeCustom];
        m_pConsultation.frame = CGRectMake(6 * AdaptRate, m_pDateBtn.bottom + 28 * AdaptRate + 169 * AdaptRate * i, self.width - 12 * AdaptRate, 169 * AdaptRate);
        m_pConsultation.tag = 100 + i;
        [m_pConsultation addTarget:self action:@selector(getRsult:) forControlEvents:UIControlEventTouchUpInside];
        [m_pConsultation setBackgroundImage:[UIImage imageNamed:m_pBgImgArr[i]] forState:UIControlStateNormal];
        [m_pScrollView addSubview:m_pConsultation];
        
        //锁的外围圆圈
        UIButton *m_pCircleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        m_pCircleBtn.bounds = CGRectMake(0,0,78 * AdaptRate, 77 * AdaptRate);
        m_pCircleBtn.center = CGPointMake(m_pConsultation.width/2, 61 * AdaptRate);
        [m_pCircleBtn setBackgroundImage:[UIImage imageNamed:@"constellation_detail_lockcircle"] forState:UIControlStateNormal];
        [m_pConsultation addSubview:m_pCircleBtn];
        
        //锁
        UIButton *m_pLockBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        m_pLockBtn.frame = CGRectMake(5 * AdaptRate,6 * AdaptRate,69 * AdaptRate, 69 * AdaptRate);
        [m_pLockBtn setBackgroundImage:[UIImage imageNamed:@"constellation_detail_lock"] forState:UIControlStateNormal];
        [m_pCircleBtn addSubview:m_pLockBtn];
        
        //标题
        UILabel *m_pTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, m_pCircleBtn.bottom + 9 * AdaptRate, m_pConsultation.width, SIZE_HEIGHT(16))];
        [m_pTitleLabel SetTextColor:UIColorFromHex(0xFFFFFF) FontName:[TextManager HelveticaNeueFont] FontSize:16 Placehoder: m_ptitleArr[i]];
        m_pTitleLabel.textAlignment = NSTextAlignmentCenter;
        [m_pConsultation addSubview:m_pTitleLabel];
        m_pScrollView.contentSize = CGSizeMake(self.width, m_pConsultation.bottom );
    }
    
}

#pragma mark -
#pragma mark - collectionView的delegate和datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DPWeekCollectionViewCell *cell = [DPWeekCollectionViewCell cellWithCollectionView:collectionView identifier:WeekCollectionViewCell indexPath:indexPath];
    return cell;
}
- (void)getRsult:(UIButton *)btn
{
    id btnTag = @(btn.tag);
    if (self.proDelegate != nil && [self.proDelegate respondsToSelector:@selector(PushToNextPage:)]) {
        [self.proDelegate PushToNextPage:btnTag];
    }
}
@end
