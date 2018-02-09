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
    UICollectionView * m_pWeekCollectionView;
    UIButton * m_pDateBtn;
    UIScrollView * m_pScrollView;
    NSArray * m_arrWeek;
    UILabel *m_pDateLabel;
    UILabel *m_pConstellLabel;//星座名称
    UIImageView *m_pArrowImg;//向下箭头
    NSArray * m_arrDate;//一周日期（几号）的数组
    NSMutableArray *m_arrTotalDate;//一周日期（年月日）的数组
    NSInteger m_ltodayDate;//今天
    
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
        m_arrTotalDate = [NSMutableArray array];
        m_arrDate = [self getcurrentWeekDate];
        m_arrWeek = @[@"MON",@"TUE",@"WED",@"THU",@"FRI",@"SAT",@"SUN"];
        [mNotificationCenter addObserver:self selector:@selector(updateConName) name:constellationChangedNotification object:nil];
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
    UILabel *pTodayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, m_pDateBtn.width, SIZE_HEIGHT(15))];
    [pTodayLabel SetTextColor:UIColorFromHex(0xFFFFFF) FontName:[TextManager HelveticaNeueThinFont] FontSize:15 Placehoder:@"DATE"];
    pTodayLabel.textAlignment = NSTextAlignmentCenter;
    [m_pDateBtn addSubview:pTodayLabel];

    //日期
    m_pDateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, pTodayLabel.bottom + 5 * AdaptRate, m_pDateBtn.width, SIZE_HEIGHT(20))];
    NSString *currentDate = [NSString GetCurrentTimesWithFormat:@"yyyy.MM.dd"];
    [m_pDateLabel SetTextColor:UIColorFromHex(0xFFFFFF) FontName:[TextManager HelveticaNeueFont] FontSize:20 Placehoder:currentDate];
    m_pDateLabel.textAlignment = NSTextAlignmentCenter;
    [m_pDateBtn addSubview:m_pDateLabel];
    
    // 中间 横杠
    UIView *pLineView = [[UIView alloc]initWithFrame:CGRectMake(self.width/2 - 2 * AdaptRate, 11 * AdaptRate, 2 * AdaptRate, 22 * AdaptRate)];
    pLineView.backgroundColor = [UIColor whiteColor];
    pLineView.alpha = 0.6;
    [m_pDateBtn addSubview:pLineView];
    
    // 右 星座
    UIButton *pConstellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pConstellBtn.frame = CGRectMake(self.width/2, 35 * AdaptRate, self.width/2,45 * AdaptRate);
    [pConstellBtn addTarget:self action:@selector(presentToNext) forControlEvents:UIControlEventTouchUpInside];
    [m_pScrollView addSubview:pConstellBtn];
    
    //start
    UILabel *pStartLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, pConstellBtn.width, SIZE_HEIGHT(15))];
    [pStartLabel SetTextColor:UIColorFromHex(0xFFFFFF) FontName:[TextManager HelveticaNeueThinFont] FontSize:15 Placehoder:@"Start"];
    pStartLabel.textAlignment = NSTextAlignmentCenter;
    [pConstellBtn addSubview:pStartLabel];
    
    //星座
    NSInteger m_lindex = [[[NSUserDefaults standardUserDefaults]objectForKey:@"selectConstalletion"] integerValue];
    m_pConstellLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, pStartLabel.bottom + 5 * AdaptRate, 0, 0)];
    DPConstellationModel * model = [DPConstellationModel ModelWithDictionary:m_arrData[m_lindex]];
    [m_pConstellLabel SetTextColor:UIColorFromHex(0xFFFFFF) FontName:[TextManager HelveticaNeueFont] FontSize:20 Placehoder:model.nameEn];
    [m_pConstellLabel sizeToFit];
    CGPoint center = m_pConstellLabel.center;
    center.x = pConstellBtn.width * 0.5;
    m_pConstellLabel.center = center;
    m_pConstellLabel.textAlignment = NSTextAlignmentCenter;
    [pConstellBtn addSubview:m_pConstellLabel];
    
    //向下箭头
    m_pArrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(m_pConstellLabel.right + 10 * AdaptRate, m_pConstellLabel.top + 8 * AdaptRate, 12 * AdaptRate, 8 * AdaptRate)];
    m_pArrowImg.image = [UIImage imageNamed:@"constellation_detail_triangle"];
    [pConstellBtn addSubview:m_pArrowImg];
    
}
//手相分析等
- (void)addlistView
{
    NSArray *pBgImgArr = @[@"constellation_detail_counselor",@"constellation_detail_daytest",@"constellation_detail_palma"];
    NSArray *ptitleArr = @[@"Consultation",@"Daily test",@"Palm analysis"];
    
    for (int i = 0; i < 3; i ++) {
        //button背景
        UIButton *pConsultation = [UIButton buttonWithType:UIButtonTypeCustom];
        pConsultation.frame = CGRectMake(6 * AdaptRate, m_pDateBtn.bottom + 28 * AdaptRate + 169 * AdaptRate * i, self.width - 12 * AdaptRate, 169 * AdaptRate);
        pConsultation.tag = 100 + i;
        [pConsultation addTarget:self action:@selector(getRsult:) forControlEvents:UIControlEventTouchUpInside];
        [pConsultation setBackgroundImage:[UIImage imageNamed:pBgImgArr[i]] forState:UIControlStateNormal];
        [m_pScrollView addSubview:pConsultation];
        
        //锁的外围圆圈
        UIButton * pCircleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        pCircleBtn.bounds = CGRectMake(0,0,78 * AdaptRate, 77 * AdaptRate);
        pCircleBtn.center = CGPointMake(pConsultation.width/2, 61 * AdaptRate);
        [pCircleBtn setBackgroundImage:[UIImage imageNamed:@"constellation_detail_lockcircle"] forState:UIControlStateNormal];
        [pConsultation addSubview:pCircleBtn];
        
        //锁
        UIButton *pLockBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        pLockBtn.bounds = CGRectMake(0, 0, 69 * AdaptRate, 69 * AdaptRate);
        [pLockBtn setBackgroundImage:[UIImage imageNamed:@"constellation_detail_lock"] forState:UIControlStateNormal];
        [pCircleBtn addSubview:pLockBtn];
        
        BOOL isBuy = [mUserDefaults boolForKey:@"isbuy"];

        
        if (i == 0 && !isBuy) {
            [pLockBtn setBackgroundImage:[UIImage imageNamed:@"constellation_detail_lock"] forState:UIControlStateNormal];
        }else{
            pLockBtn.bounds = CGRectMake(0, 0, 54 * AdaptRate, 54 * AdaptRate);
            [pLockBtn setBackgroundImage:[UIImage imageNamed:@"constellation_detail_in"] forState:UIControlStateNormal];
        }
        pLockBtn.center = CGPointMake(pCircleBtn.width * 0.5, pCircleBtn.height * 0.5);

        
        //标题
        UILabel *pTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, pCircleBtn.bottom + 9 * AdaptRate, pConsultation.width, SIZE_HEIGHT(16))];
        [pTitleLabel SetTextColor:UIColorFromHex(0xFFFFFF) FontName:[TextManager HelveticaNeueFont] FontSize:16 Placehoder: ptitleArr[i]];
        pTitleLabel.textAlignment = NSTextAlignmentCenter;
        [pConsultation addSubview:pTitleLabel];
        m_pScrollView.contentSize = CGSizeMake(self.width, pConsultation.bottom );
    }
    
}
- (void)updateConName{
    NSInteger m_lindex = [[[NSUserDefaults standardUserDefaults]objectForKey:@"selectConstalletion"] integerValue];
    DPConstellationModel * model = [DPConstellationModel ModelWithDictionary:m_arrData[m_lindex]];
    m_pConstellLabel.text = model.nameEn;
    [m_pConstellLabel sizeToFit];
    m_pArrowImg.frame = CGRectMake(m_pConstellLabel.right + 10 * AdaptRate, m_pConstellLabel.top + 8 * AdaptRate, 12 * AdaptRate, 8 * AdaptRate);
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
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DPWeekCollectionViewCell * cell = (DPWeekCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.selected = YES;
    m_pDateLabel.text = m_arrTotalDate[indexPath.item];
    
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    DPWeekCollectionViewCell * cell = (DPWeekCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.selected = NO;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DPWeekCollectionViewCell *cell = [DPWeekCollectionViewCell cellWithCollectionView:collectionView identifier:WeekCollectionViewCell indexPath:indexPath];
    cell.weekLabel.text = m_arrWeek[indexPath.item];
    cell.dateLabel.text = m_arrDate[indexPath.item];
    if (m_ltodayDate == [m_arrDate[indexPath.item] integerValue]) {//今天
        [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        cell.selected = YES;
    }else{
        cell.selected = NO;
    }
    return cell;
}
- (void)getRsult:(UIButton *)btn
{
    id btnTag = @(btn.tag);
    if (self.proDelegate != nil && [self.proDelegate respondsToSelector:@selector(PushToNextPage:)]) {
        [self.proDelegate PushToNextPage:btnTag];
    }
}

- (void)presentToNext{
    if (self.conDetailDel != nil && [self.conDetailDel respondsToSelector:@selector(PresentToselect)]) {
        [self.conDetailDel PresentToselect];
    }
}

#pragma mark - 获取一周的日期
- (NSArray *)getcurrentWeekDate{
    
    NSDate * nowDateTotal = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:nowDate];
    // 获取今天是周几
    NSInteger weekDay = [comp weekday];
    // 获取几天是几号
    NSInteger day = [comp day];
    m_ltodayDate = day;
    // 计算当前日期和本周的星期一和星期天相差天数
    long firstDiff,lastDiff;
    //    weekDay = 1;
    if (weekDay == 1)
    {
        firstDiff = -6;
        
        lastDiff = 0;
    }
    else
    {
        firstDiff = [calendar firstWeekday] - weekDay + 1;
        lastDiff = 8 - weekDay;
    }
    // 在当前日期(去掉时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:nowDate];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek = [calendar dateFromComponents:firstDayComp];
    //时间转时间戳的方法  每周的第一天
    long int timeSp = [[NSNumber numberWithDouble:[firstDayOfWeek timeIntervalSince1970]] integerValue];
    
    
    NSDateComponents *lastDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay   fromDate:nowDate];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek = [calendar dateFromComponents:lastDayComp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd"];
    NSString *firstDay = [formatter stringFromDate:firstDayOfWeek];
    NSString *lastDay = [formatter stringFromDate:lastDayOfWeek];
    int firstValue = firstDay.intValue;
    int lastValue = lastDay.intValue;
    NSMutableArray *dateArr = [[NSMutableArray alloc]init];
    if (firstValue < lastValue) {//在同一个月
        for (int j = 0; j<7; j++) {
            NSString *obj = [NSString stringWithFormat:@"%d",firstValue+j];
            [dateArr addObject:obj];
            //将完整日期添加到数组
            NSString * timeStapString = [NSString stringWithFormat:@"%ld",timeSp + (j * 86400)];
            NSString * objDate = [NSString timeWithTimeIntervalString:timeStapString];
            [m_arrTotalDate addObject:objDate];
        }
    }
    else if (firstValue > lastValue)//不在同一个月
    {
        //前一个月
        for (int j = 0; j < 7-lastValue; j++) {
            NSString *obj = [NSString stringWithFormat:@"%d",firstValue+j];
            [dateArr addObject:obj];
            NSString * timeStapString = [NSString stringWithFormat:@"%ld",timeSp + (j * 86400)];
            NSString * objDate = [NSString timeWithTimeIntervalString:timeStapString];
            [m_arrTotalDate addObject:objDate];
        }
        for (int z = 0; z<lastValue; z++) {
            NSString *obj = [NSString stringWithFormat:@"%d",z+1];
            [dateArr addObject:obj];
            NSString * timeStapString = [NSString stringWithFormat:@"%ld",timeSp + (7-lastValue + z) * 86400];
            NSString * objDate = [NSString timeWithTimeIntervalString:timeStapString];
            [m_arrTotalDate addObject:objDate];
        }
    }
    return dateArr;
}

@end
