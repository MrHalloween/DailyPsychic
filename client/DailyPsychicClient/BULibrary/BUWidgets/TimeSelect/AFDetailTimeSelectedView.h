//
//  AFDetailTimeSelectedView.h
//  pbuYaLianWuYeClient
//
//  Created by 1bu2bu on 16/8/24.
//  Copyright © 2016年 1bu2bu. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  时间选取页面
 */
@protocol AFDetailTimeSelectedViewDelegate <NSObject>

@optional
/**
 *  确认选择
 *
 *  @param argDate 选取的时间对应的字符串
 */
-(void)SureSelectedTime:(NSString*)argDate;

@end

@interface AFDetailTimeSelectedView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIPickerView *m_pPickView;    ///拾取器
    UIView *m_pBg;   ///页面背景
    
    NSMutableArray *m_pYearArr;       ///年
    NSMutableArray *m_pMonthArr;    ///月
    NSMutableArray *m_pDayArr;        ///日
    NSMutableArray *m_pHourArr;      ///时
    NSMutableArray *m_pMinuteArr;   ///分
    
    NSInteger yearnow;    ///当前年份
    NSInteger monthnow;     ///当前月份
    NSInteger daynow;    ///当前天
    NSInteger hournow;    ///当前时
    NSInteger minutenow;    ///当前分
    
    NSInteger yearInt;      ///临时年份
    NSInteger monthInt;     ///临时月份
    NSInteger dayInt;       ///临时天
    NSInteger hourInt;     ///临时时
    NSInteger minuteInt;     ///临时分
}

@property(nonatomic,weak)id<AFDetailTimeSelectedViewDelegate> propDelegate;

/**
 *  设置默认时间
 *
 *  @param argTime  默认时间字符串
 */
-(void)SetDefaultTime:(NSString *)argTime;

/**
 *  页面显示
 */
-(void)ShowPickerView;

/**
 *  获取选中的时间的时间挫
 *
 *  @return 时间挫
 */
-(NSTimeInterval)GetSelectTimeInterval;

@end
