//
//  AFYearSelectedView.m
//  pbuTRYYClient
//
//  Created by zhanghe on 2017/5/5.
//  Copyright © 2017年 李鑫浩. All rights reserved.
//

#import "AFYearSelectedView.h"

@implementation AFYearSelectedView

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

    UILabel *pFlag = [[UILabel alloc] initWithFrame:CGRectMake(width * 2 + 15.0f, (m_pPickView.frame.size.height-40)/2.0, 20, 40)];
    pFlag.textColor = [UIColor grayColor];
    pFlag.font = [UIFont systemFontOfSize:16];
    pFlag.textAlignment = NSTextAlignmentCenter;
    pFlag.text = @"年";
    [m_pPickView addSubview:pFlag];
    
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
    NSString *strBirthday = [NSString stringWithFormat:@"%ld",(long)yearInt];
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
    
    [m_pPickView selectRow:iYearRow inComponent:0 animated:NO];
}


-(void)SetDefaultTime:(NSString *)argTime
{
    NSDateFormatter *pDF = [[NSDateFormatter alloc]init];
    [pDF setDateFormat:@"yyyy"];
    NSDate *pDate = [pDF dateFromString:argTime];
    if (pDate == nil)
    {
        return;
    }
    NSCalendar *pCalendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour;
    NSDateComponents *pDateComponents = [pCalendar components:unitFlags fromDate:pDate];
    yearInt =  [pDateComponents year];

}

-(NSTimeInterval)GetSelectTimeInterval
{
    NSString *strBirthday = [NSString stringWithFormat:@"%ld",(long)yearInt];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSDate* pDate = [formatter dateFromString:strBirthday];
    NSTimeInterval timeIntervalbirthday = pDate.timeIntervalSince1970;
    return timeIntervalbirthday;
}

#pragma mark -- initialize data
//初始化数据
- (void)InitializeTimeData
{
    m_pYearArr = [[NSMutableArray alloc] init];
    
    NSDate *pCurrentDate = [NSDate date];
    NSCalendar *pCalendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour;
    NSDateComponents *pDateComponents = [pCalendar components:unitFlags fromDate:pCurrentDate];
    yearInt =  yearnow =  [pDateComponents year];
    
    for (NSInteger i=yearnow - 100; i<= yearnow; i++)
    {
        [m_pYearArr addObject:[NSString stringWithFormat:@"%li",i]];
    }
    
}

#pragma mark UIPickerViewDelegate,UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return m_pYearArr.count;
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

    return [m_pYearArr objectAtIndex:row];
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
        default:
            break;
    }
}

@end
