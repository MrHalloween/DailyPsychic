//
//  AFFutureTimeSelectedView.h
//  pbuTRYYClient
//
//  Created by 李鑫浩 on 2017/4/13.
//  Copyright © 2017年 李鑫浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFFutureTimeSelectedView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

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
