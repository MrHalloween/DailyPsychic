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

@interface DPConstellationDetailView()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *m_pWeekCollectionView;
}
@end

@implementation DPConstellationDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTopView];
        [self addCollectionView];
        [self addlistView];
    }
    return self;
}
- (void)addTopView{
    
    // 背景
    UIImageView *pBgImg = [[UIImageView alloc]initWithFrame:self.frame];
    pBgImg.image = [UIImage imageNamed:@"homepage_bg"];
    pBgImg.userInteractionEnabled = YES;
    [self addSubview:pBgImg];
    
    //title
    UILabel *m_pTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 36 * AdaptRate, self.width, 36 * AdaptRate)];
    [m_pTitleLabel SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager RegularFont] FontSize:18 Placehoder:@"Start"];
    m_pTitleLabel.textAlignment = NSTextAlignmentCenter;
    [pBgImg addSubview:m_pTitleLabel];
    
    //返回按钮
    UIButton *pBackaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pBackaBtn.frame = CGRectMake(0, 48 * AdaptRate, 30 * AdaptRate, 35 * AdaptRate);
    [pBackaBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [pBgImg addSubview:pBackaBtn];
    
    //返回图片
    UIImageView *pBackImg = [[UIImageView alloc]initWithFrame:CGRectMake(16 * AdaptRate, 0, 8 *AdaptRate, 14 * AdaptRate)];
    pBackImg.userInteractionEnabled = YES;
    pBackImg.image = [UIImage imageNamed:@"constellation_back"];
    [pBackaBtn addSubview:pBackImg];
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

- (void)addlistView{
    
}
//返回
- (void)backBtnClick
{
    if (self.conDetailDel != nil && [self.conDetailDel respondsToSelector:@selector(BackTo)])
    {
        [self.conDetailDel BackTo];
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











@end
