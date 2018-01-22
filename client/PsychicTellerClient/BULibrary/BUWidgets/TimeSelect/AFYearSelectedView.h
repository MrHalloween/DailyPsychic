//
//  AFYearSelectedView.h
//  pbuTRYYClient
//
//  Created by zhanghe on 2017/5/5.
//  Copyright © 2017年 李鑫浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AFYearSelectedViewDelegate <NSObject>

@optional
/**
 *  确定选择的时间
 *
 *  @param argDate 时间
 */
-(void)SureSelectedTime:(NSString*)argDate;

@end

@interface AFYearSelectedView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIPickerView *m_pPickView;  ///时间拾取器
    UIView *m_pBg;   ///背景
    
    NSMutableArray *m_pYearArr;       ///年
    
    NSInteger yearnow;    ///当前年份
    
    NSInteger yearInt;      ///临时年份
}

@property(nonatomic,weak)id<AFYearSelectedViewDelegate> propDelegate;

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
