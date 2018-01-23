//
//  AFFutureTimeSelectedView.m
//  pbuTRYYClient
//
//  Created by 李鑫浩 on 2017/4/13.
//  Copyright © 2017年 李鑫浩. All rights reserved.
//

#import "AFFutureTimeSelectedView.h"

@interface AFFutureTimeSelectedView ()
{
    UIPickerView *m_pPickView;  ///时间拾取器
    UIView *m_pBg;   ///背景
    
    NSMutableArray *m_pYearArr;       ///年
    NSMutableArray *m_pMonthArr;    ///月
    NSMutableArray *m_pDayArr;        ///日
    
    NSInteger m_iCrrentYear;    ///当前年份
    NSInteger m_iCrrentMonth;     ///当前月份
    NSInteger m_iCrrentDay;    ///当前天
    
    NSInteger m_iTempYear;      ///临时年份
    NSInteger m_iTempMonth;     ///临时月份
    NSInteger m_iTempDay;       ///临时天
}

@end

@implementation AFFutureTimeSelectedView

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3f];
        self.alpha = 0;
        [self InitializeTimeData];    ///初始化数据
        [self CreatePickerView];
        [self MakeYearMonthDayLabel];
    }
    return self;
}

#pragma mark -- DataManage method
//初始化数据
- (void)InitializeTimeData
{
    NSDate *pCurrentDate = [NSDate date];
    NSCalendar *pCalendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour;
    NSDateComponents *pDateComponents = [pCalendar components:unitFlags fromDate:pCurrentDate];
    m_iTempYear =  m_iCrrentYear =  [pDateComponents year];
    m_iTempMonth = m_iCrrentMonth = [pDateComponents month];
    m_iTempDay = m_iCrrentDay = [pDateComponents day];
    
    m_pYearArr = [[NSMutableArray alloc] init];
    m_pMonthArr = [[NSMutableArray alloc] init];
    m_pDayArr = [[NSMutableArray alloc] init];
    
    for (NSInteger i=m_iCrrentYear; i<= m_iCrrentYear + 100; i++)
    {
        [m_pYearArr addObject:[NSString stringWithFormat:@"%li",i]];
    }
    
    [self InitializeMonthArr];
    [self InitializeDayArr];
}

- (void)InitializeMonthArr
{
    [m_pMonthArr removeAllObjects];
    NSInteger iStartMonth = 1;
    if (m_iTempYear == m_iCrrentYear)
    {
        iStartMonth = m_iCrrentMonth;
    }
    for (NSInteger i = iStartMonth; i <= 12; i++)
    {
        [m_pMonthArr addObject:[NSString stringWithFormat:@"%02ld",i]];
    }
}


//根据当前年月刷新self.dayArr数据源
- (void)InitializeDayArr
{
    [m_pDayArr removeAllObjects];
    NSInteger iEndDay = 31;
    if(m_iTempMonth == 4 || m_iTempMonth == 6 || m_iTempMonth == 9 || m_iTempMonth == 11)
    {
        iEndDay = 30;
    }
    else if(m_iTempMonth == 2)
    {
        if(((m_iTempYear % 4 == 0) && (m_iTempYear % 100 != 0)) || (m_iTempYear % 400 == 0))
        {
            iEndDay = 29;
        }
        else
        {
            iEndDay = 28;
        }
    }
    
    NSInteger iStartDay = m_iCrrentDay;
    if (m_iTempYear != m_iCrrentYear || m_iTempMonth != m_iCrrentMonth)
    {
        iStartDay = 1;
    }
    
    for (NSInteger i = iStartDay; i <= iEndDay; i++)
    {
        [m_pDayArr addObject:[NSString stringWithFormat:@"%02ld",i]];
    }
}

#pragma mark -- add subviews
//UIPickerView
- (void)CreatePickerView
{
    UIButton *pCancelV = [UIButton buttonWithType:UIButtonTypeCustom];
    pCancelV.frame = CGRectMake(0, 0, self.width, self.height - 300 * [AppConfigure GetLengthAdaptRate]);
    [pCancelV addTarget:self action:@selector(ClosePickerView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:pCancelV];
    
    m_pBg = [[UIView alloc]initWithFrame:CGRectMake(0, self.height, self.width, 300 * [AppConfigure GetLengthAdaptRate])];
    m_pBg.backgroundColor = [UIColor whiteColor];
    [self addSubview:m_pBg];
    
    m_pPickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 30.0f, self.width, 300 * [AppConfigure GetLengthAdaptRate] - 30 * [AppConfigure GetLengthAdaptRate])];
    m_pPickView.showsSelectionIndicator = YES;
    m_pPickView.backgroundColor = [UIColor clearColor];
    m_pPickView.delegate = self;
    m_pPickView.dataSource = self;
    [m_pBg addSubview:m_pPickView];
    
    UIButton *pCloseButton = [[UIButton alloc] initWithFrame:CGRectMake(10 * [AppConfigure GetLengthAdaptRate], 0 , 40 * [AppConfigure GetLengthAdaptRate], 50 * [AppConfigure GetLengthAdaptRate])];
    [pCloseButton setTitle:@"关闭" forState:UIControlStateNormal];
    [pCloseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    pCloseButton.titleLabel.font = [UIFont fontWithName:[TextManager RegularFont] size:14];
    [pCloseButton addTarget:self action:@selector(ClosePickerView) forControlEvents:UIControlEventTouchUpInside];
    [m_pBg addSubview:pCloseButton];
    
    UIButton *pSendButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width - 50 * [AppConfigure GetLengthAdaptRate], 0 , 40 * [AppConfigure GetLengthAdaptRate], 50 * [AppConfigure GetLengthAdaptRate])];
    [pSendButton setTitle:@"确定" forState:UIControlStateNormal];
    [pSendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    pSendButton.titleLabel.font = [UIFont fontWithName:[TextManager RegularFont] size:14];
    [pSendButton addTarget:self action:@selector(SureSelectedTime) forControlEvents:UIControlEventTouchUpInside];
    [m_pBg addSubview:pSendButton];
}
- (void)MakeYearMonthDayLabel{
    
    CGFloat width = (m_pPickView.width - 50.0f)/3.0f;
    NSArray *arrFlag = @[@"年",@"月",@"日"];
    
    for (NSInteger i = 0; i < 3; i ++)
    {
        UILabel *pFlag = [[UILabel alloc] initWithFrame:CGRectMake(width * (i + 1) + 15.0f, (m_pPickView.frame.size.height-40)/2.0, 20, 40)];
        pFlag.textColor = [UIColor grayColor];
        pFlag.font = [UIFont systemFontOfSize:16];
        pFlag.textAlignment = NSTextAlignmentCenter;
        pFlag.text = arrFlag[i];
        [m_pPickView addSubview:pFlag];
    }
}

#pragma mark -- private method
-(void)ClosePickerView
{
    __weak typeof(self) weakSelf = self;
    __weak typeof(m_pBg) weakBg = m_pBg;
    [UIView animateWithDuration:0.35f animations:^{
        weakBg.transform = CGAffineTransformMakeTranslation(0, weakBg.height);
        weakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)SureSelectedTime
{
    NSString *strBirthday = [NSString stringWithFormat:@"%ld-%02ld-%02ld",(long)m_iTempYear,(long)m_iTempMonth,(long)m_iTempDay];
    
    if (self.SureSelectedDate) {
        self.SureSelectedDate(strBirthday);
    }
    [self ClosePickerView];
}

#pragma mark - public methods
- (void)ShowPickerView
{
    __weak typeof(self) weakSelf = self;
    __weak typeof(m_pBg) weakBg = m_pBg;
    [UIView animateWithDuration:0.35f animations:^{
        weakBg.transform = CGAffineTransformMakeTranslation(0, -weakBg.height);
        weakSelf.alpha = 1.0;
    }];
    
    NSInteger iYearRow = [m_pYearArr indexOfObject:[NSString stringWithFormat:@"%04li",m_iTempYear]];
    NSInteger iMonthRow = [m_pMonthArr indexOfObject:[NSString stringWithFormat:@"%02li",m_iTempMonth]];
    NSInteger iDayRow = [m_pDayArr indexOfObject:[NSString stringWithFormat:@"%02li",m_iTempDay]];
    
    [m_pPickView selectRow:iYearRow inComponent:0 animated:NO];
    [m_pPickView selectRow:iMonthRow inComponent:1 animated:NO];
    [m_pPickView selectRow:iDayRow inComponent:2 animated:NO];
}

-(void)SetDefaultTime:(NSString *)argTime
{
    NSDateFormatter *pDF = [[NSDateFormatter alloc]init];
    [pDF setDateFormat:@"yyyy-MM-dd"];
    NSDate *pDate = [pDF dateFromString:argTime];
    if (pDate == nil)
    {
        return;
    }
    NSCalendar *pCalendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour;
    NSDateComponents *pDateComponents = [pCalendar components:unitFlags fromDate:pDate];
    m_iTempYear =  [pDateComponents year];
    m_iTempMonth = [pDateComponents month];
    m_iTempDay = [pDateComponents day];
    
    [self InitializeMonthArr];
    [self InitializeDayArr];
}

-(NSTimeInterval)GetSelectTimeInterval
{
    NSString *strBirthday = [NSString stringWithFormat:@"%ld-%02ld-%02ld",(long)m_iTempYear,(long)m_iTempMonth,(long)m_iTempDay];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate* pDate = [formatter dateFromString:strBirthday];
    NSTimeInterval timeIntervalbirthday = pDate.timeIntervalSince1970;
    return timeIntervalbirthday;
}

#pragma mark UIPickerViewDelegate,UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0)
    {
        return m_pYearArr.count;
    }
    else if (component == 1)
    {
        return m_pMonthArr.count;
    }
    else
    {
        return m_pDayArr.count;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0f;
}

// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return (self.width - 50)/3.0f;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == 0)
    {
        return [m_pYearArr objectAtIndex:row];
    }
    else if (component == 1)
    {
        return [m_pMonthArr objectAtIndex:row];
    }
    else
    {
        return [m_pDayArr objectAtIndex:row];
    }
}

//重写方法
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont fontWithName:[TextManager RegularFont] size:20]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    [self changeSpearatorLineColor];
    return pickerLabel;
}

#pragma mark - 改变分割线的颜色
- (void)changeSpearatorLineColor
{
    for(UIView *speartorView in m_pPickView.subviews)
    {
        if (speartorView.frame.size.height < 1)//取出分割线view
        {
            speartorView.backgroundColor = UIColorFromHex(0xe1e1e1);//隐藏分割线
        }
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            m_iTempYear = [[m_pYearArr objectAtIndex:row] integerValue];
            break;
        case 1:
            m_iTempMonth = [[m_pMonthArr objectAtIndex:row] integerValue];
            break;
        case 2:
            m_iTempDay = [[m_pDayArr objectAtIndex:row] integerValue];
            break;
        default:
            break;
    }
    
    [self InitializeMonthArr];
    [pickerView reloadComponent:1];
    NSInteger iRow1 = [pickerView selectedRowInComponent:1];
    m_iTempMonth = [[m_pMonthArr objectAtIndex:iRow1] integerValue];
    [self InitializeDayArr];
    [m_pPickView reloadComponent:2];
    NSInteger iRow2 = [pickerView selectedRowInComponent:2];
    m_iTempDay = [[m_pDayArr objectAtIndex:iRow2] integerValue];
}

@end
