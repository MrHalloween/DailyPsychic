//
//  TRYearAndMonthSelectedView.m
//  pbuTRYYClient
//
//  Created by 果雨 on 2017/5/15.
//  Copyright © 2017年 李鑫浩. All rights reserved.
//

#import "TRYearAndMonthSelectedView.h"

@interface TRYearAndMonthSelectedView ()
{
    UIPickerView *m_pPickView;  ///时间拾取器
    UIView *m_pBg;   ///背景
    
    NSMutableArray *m_pYearArr;       ///年
    NSMutableArray *m_pMonthArr;      ///月
    
    NSInteger m_iTempYear;            ///临时年
    NSInteger m_iTempMonth;           ///临时月
    
//    NSInteger m_CurrentYear;            ///当前年
//    NSInteger m_CurrentMonth;          ///当前月
}

@end


@implementation TRYearAndMonthSelectedView

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
    m_pYearArr = [[NSMutableArray alloc] init];
    
    NSDate *pCurrentDate = [NSDate date];
    NSCalendar *pCalendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour;
    NSDateComponents *pDateComponents = [pCalendar components:unitFlags fromDate:pCurrentDate];
    NSInteger yearnow =  [pDateComponents year];
    NSInteger monthNow =  [pDateComponents month];
    m_iTempYear = yearnow;
    m_iTempMonth = monthNow;
    
    for (NSInteger i=yearnow - 50; i<= yearnow; i++)
    {
        [m_pYearArr addObject:[NSString stringWithFormat:@"%li",i]];
    }
    
    m_pMonthArr = [NSMutableArray array];
    for (NSInteger i = 1; i <= 12 ; i++) {
        [m_pMonthArr addObject:[NSString stringWithFormat:@"%ld",i]];
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
    
    NSArray *arrFlag = @[@"年",@"月"];
    for (NSInteger i = 0; i < arrFlag.count; i ++)
    {
        UILabel *pFlag = [[UILabel alloc] initWithFrame:CGRectMake(m_pPickView.width / 3.0f * (1 + i) + 20, (m_pPickView.frame.size.height-40)/2.0, 50, 40)];
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
    NSString *strYearMonth = [NSString stringWithFormat:@"%ld-%02ld",(long)m_iTempYear,(long)m_iTempMonth];
    if (self.SureSelectedYearMonth) {
        self.SureSelectedYearMonth(strYearMonth);
    }
    
    NSString *strTime = [NSString stringWithFormat:@"%ld年%02ld月",(long)m_iTempYear,(long)m_iTempMonth];
    if (self.SureSelectedDate) {
        self.SureSelectedDate(strTime);
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
    
    NSInteger yearRow = [m_pYearArr indexOfObject:[NSString stringWithFormat:@"%ld",m_iTempYear]];
    NSInteger monthRow = [m_pMonthArr indexOfObject:[NSString stringWithFormat:@"%ld",m_iTempMonth]];
    
    [m_pPickView selectRow:yearRow inComponent:0 animated:NO];
    [m_pPickView selectRow:monthRow inComponent:1 animated:NO];
}

#pragma mark UIPickerViewDelegate,UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0)
    {
        return m_pYearArr.count;
    }
    else
    {
        return m_pMonthArr.count;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0f;
}

// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return self.width / 3.0f;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == 0)
    {
        return [m_pYearArr objectAtIndex:row];
    }
    else
    {
        return [m_pMonthArr objectAtIndex:row];
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
        default:
            break;
    }
}

@end
