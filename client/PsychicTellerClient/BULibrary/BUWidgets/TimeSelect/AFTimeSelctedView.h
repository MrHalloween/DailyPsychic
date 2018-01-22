//
//  YLTimeSelctedView.h
//  pbuYaLianWuYeClient
//
//  Created by   on 16/5/17.
//  Copyright © 2016年  . All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AFTimeSelctedViewDelegate <NSObject>

@optional
/**
 *  确定选择的时间
 *
 *  @param argDate 时间
 */
-(void)SureSelectedTime:(NSString*)argDate;

@end

@interface AFTimeSelctedView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIPickerView *m_pPickView;  ///时间拾取器
    UIView *m_pBg;   ///背景
    
    NSMutableArray *m_pYearArr;       ///年
    NSMutableArray *m_pMonthArr;    ///月
    NSMutableArray *m_pDayArr;        ///日
    
    NSInteger yearnow;    ///当前年份
    NSInteger monthnow;     ///当前月份
    NSInteger daynow;    ///当前天
    
    NSInteger yearInt;      ///临时年份
    NSInteger monthInt;     ///临时月份
    NSInteger dayInt;       ///临时天
}

@property(nonatomic,weak)id<AFTimeSelctedViewDelegate> propDelegate;

@property (nonatomic, copy) void (^SureSelectedDate) (NSString *strDate);

/**
 *  设置默认时间
 *
 *  @param argTime  默认时间字符串
 */
-(void)SetDefaultTime:(NSString *)argTime;

/**
 *  显示时间选取页面
 */
-(void)ShowPickerView;

/**
 *  获取选定的时间的时间挫
 *
 *  @return 时间挫
 */
-(NSTimeInterval)GetSelectTimeInterval;

@end
