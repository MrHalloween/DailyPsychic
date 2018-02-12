//
//  YLTimeSelctedView.m
//  pbuYaLianWuYeClient
//
//  Created by   on 16/5/17.
//  Copyright © 2016年  . All rights reserved.
//

#import "AFTimeSelctedView.h"

@implementation AFTimeSelctedView

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
    
    UIButton *pCloseButton = [[UIButton alloc] initWithFrame:CGRectMake(10 * [AppConfigure GetLengthAdaptRate], 0 , 50 * [AppConfigure GetLengthAdaptRate], 50 * [AppConfigure GetLengthAdaptRate])];
    [pCloseButton setTitle:@"Close" forState:UIControlStateNormal];
    [pCloseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    pCloseButton.titleLabel.font = [UIFont fontWithName:[TextManager RegularFont] size:14];
    [pCloseButton addTarget:self action:@selector(ClosePickerView) forControlEvents:UIControlEventTouchUpInside];
    [m_pBg addSubview:pCloseButton];
    
    UIButton *pSendButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width - 50 * [AppConfigure GetLengthAdaptRate], 0 , 40 * [AppConfigure GetLengthAdaptRate], 50 * [AppConfigure GetLengthAdaptRate])];
    [pSendButton setTitle:@"Ture" forState:UIControlStateNormal];
    [pSendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    pSendButton.titleLabel.font = [UIFont fontWithName:[TextManager RegularFont] size:14];
    [pSendButton addTarget:self action:@selector(SureSelectedTime) forControlEvents:UIControlEventTouchUpInside];
    [m_pBg addSubview:pSendButton];
}
- (void)MakeYearMonthDayLabel{
    
    CGFloat width = (m_pPickView.width - 50.0f)/3.0f;
    NSArray *arrFlag = @[@"Y",@"M",@"D"];
    
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
    NSString *strBirthday = [NSString stringWithFormat:@"%ld-%02ld-%02ld",(long)yearInt,(long)monthInt,(long)dayInt];
    if (self.propDelegate != nil && [self.propDelegate respondsToSelector:@selector(SureSelectedTime:)])
    {
        [self.propDelegate SureSelectedTime:strBirthday];
    }
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
    
    NSInteger iYearRow = [m_pYearArr indexOfObject:[NSString stringWithFormat:@"%04li",yearInt]];
    NSInteger iMonthRow = [m_pMonthArr indexOfObject:[NSString stringWithFormat:@"%02li",monthInt]];
    NSInteger iDayRow = [m_pDayArr indexOfObject:[NSString stringWithFormat:@"%02li",dayInt]];
    
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
    yearInt =  [pDateComponents year];
    monthInt = [pDateComponents month];
    dayInt = [pDateComponents day];
    
    [self InitializeMonthArr];
    [self InitializeDayArr];
}

-(NSTimeInterval)GetSelectTimeInterval
{
    NSString *strBirthday = [NSString stringWithFormat:@"%ld.%02ld.%02ld",(long)yearInt,(long)monthInt,(long)dayInt];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    NSDate* pDate = [formatter dateFromString:strBirthday];
    NSTimeInterval timeIntervalbirthday = pDate.timeIntervalSince1970;
    return timeIntervalbirthday;
}

#pragma mark -- initialize data
//初始化数据
- (void)InitializeTimeData
{
    m_pYearArr = [[NSMutableArray alloc] init];
    m_pMonthArr = [[NSMutableArray alloc] init];
    m_pDayArr = [[NSMutableArray alloc] init];
    
    NSDate *pCurrentDate = [NSDate date];
    NSCalendar *pCalendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour;
    NSDateComponents *pDateComponents = [pCalendar components:unitFlags fromDate:pCurrentDate];
    yearInt =  yearnow =  [pDateComponents year];
    monthInt = monthnow = [pDateComponents month];
    dayInt = daynow = [pDateComponents day];
    
    for (NSInteger i=yearnow - 100; i<= yearnow; i++)
    {
        [m_pYearArr addObject:[NSString stringWithFormat:@"%li",i]];
    }
    
    [self InitializeMonthArr];
    [self InitializeDayArr];
}

- (void)InitializeMonthArr
{
    [m_pMonthArr removeAllObjects];
    NSInteger endMonth = 12;
    if (yearInt == yearnow)
    {
        endMonth = monthnow;
    }
    for (NSInteger i=1; i <= endMonth; i++) {
        [m_pMonthArr addObject:[NSString stringWithFormat:@"%02ld",i]];
    }
}


//根据当前年月刷新self.dayArr数据源
- (void)InitializeDayArr
{
    [m_pDayArr removeAllObjects];
    NSInteger endDay = 30;
    if (yearInt == yearnow && monthInt == monthnow)
    {
        endDay = daynow;
    }
    else
    {
        if(monthInt == 1 || monthInt == 3 || monthInt == 5 || monthInt == 7 || monthInt == 8 || monthInt == 10 || monthInt == 12)
        {
            endDay = 31;
        }
        else if(monthInt == 2)
        {
            if(((yearInt%4 == 0) && (yearInt%100 != 0)) || (yearInt%400 == 0))
            {
                endDay = 29;
            }
            else
            {
                endDay = 28;
            }
        }
        else
        {
            endDay = 30;
        }
    }
    for (NSInteger i = 1; i <= endDay; i++) {
        [m_pDayArr addObject:[NSString stringWithFormat:@"%02ld",i]];
    }
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
            yearInt = [[m_pYearArr objectAtIndex:row] integerValue];
            break;
        case 1:
            monthInt = [[m_pMonthArr objectAtIndex:row] integerValue];
            break;
        case 2:
            dayInt = [[m_pDayArr objectAtIndex:row] integerValue];
            break;
        default:
            break;
    }
    
    [self InitializeMonthArr];
    [pickerView reloadComponent:1];
    NSInteger iRow1 = [pickerView selectedRowInComponent:1];
    monthInt = [[m_pMonthArr objectAtIndex:iRow1] integerValue];
    [self InitializeDayArr];
    [m_pPickView reloadComponent:2];
    NSInteger iRow2 = [pickerView selectedRowInComponent:2];
    dayInt = [[m_pDayArr objectAtIndex:iRow2] integerValue];
}

@end
