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
        m_arrWeek = @[@"SUN",@"MON",@"TUE",@"WED",@"THU",@"FRI",@"SAT"];
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
    [pTodayLabel SetTextColor:UIColorFromHex(0xFFFFFF) FontName:[TextManager HelveticaNeueThinFont] FontSize:15 Placehoder:@"TODAY"];
    pTodayLabel.textAlignment = NSTextAlignmentCenter;
    [m_pDateBtn addSubview:pTodayLabel];

    //日期
    UILabel *pDateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, pTodayLabel.bottom + 5 * AdaptRate, m_pDateBtn.width, SIZE_HEIGHT(20))];
    NSString *currentDate = [NSString GetCurrentTimesWithFormat:@"yyyy.MM.dd"];
    [pDateLabel SetTextColor:UIColorFromHex(0xFFFFFF) FontName:[TextManager HelveticaNeueFont] FontSize:20 Placehoder:currentDate];
    pDateLabel.textAlignment = NSTextAlignmentCenter;
    [m_pDateBtn addSubview:pDateLabel];
    
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
    
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DPWeekCollectionViewCell *cell = [DPWeekCollectionViewCell cellWithCollectionView:collectionView identifier:WeekCollectionViewCell indexPath:indexPath];
    cell.weekLabel.text = m_arrWeek[indexPath.item];
    cell.dateLabel.text = m_arrDate[indexPath.item];
    if (m_ltodayDate == [m_arrDate[indexPath.item] integerValue]) {//今天
        cell.circleBgImg.image = [UIImage imageNamed:@"constellation_detail_selectdate"];
        cell.pointImg.hidden = NO;
    }else{
        cell.circleBgImg.image = nil;
        cell.pointImg.hidden = YES;
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
    //当前时间的时间戳 *1000 是精确到毫秒，不乘就是精确到秒
    long int nowTimeSp = (long)[nowDateTotal timeIntervalSince1970];
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
    if (firstValue < lastValue) {
        for (int j = 0; j<7; j++) {
            NSString *obj = [NSString stringWithFormat:@"%d",firstValue+j];
            [dateArr addObject:obj];
            //将完整日期添加到数组
            NSString * timeStapString = [NSString stringWithFormat:@"%ld",nowTimeSp + (j * 86400)];
            NSString * objDate = [self timeWithTimeIntervalString:timeStapString];
            [m_arrTotalDate addObject:objDate];
        }
    }
    else if (firstValue > lastValue)
    {
        for (int j = 0; j < 7-lastValue; j++) {
            NSString *obj = [NSString stringWithFormat:@"%d",firstValue+j];
            [dateArr addObject:obj];
            NSString * timeStapString = [NSString stringWithFormat:@"%ld",nowTimeSp + (j * 86400)];
            NSString * objDate = [self timeWithTimeIntervalString:timeStapString];
            [m_arrTotalDate addObject:objDate];
        }
        for (int z = 0; z<lastValue; z++) {
            NSString *obj = [NSString stringWithFormat:@"%d",z+1];
            [dateArr addObject:obj];
            NSString * timeStapString = [NSString stringWithFormat:@"%ld",nowTimeSp + (z * 86400)];
            NSString * objDate = [self timeWithTimeIntervalString:timeStapString];
            [m_arrTotalDate addObject:objDate];
        }
    }
    NSLog(@"%@",m_arrTotalDate);
    return dateArr;
}
- (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

@end
