//
//  TRYearAndMonthSelectedView.h
//  pbuTRYYClient
//
//  Created by 果雨 on 2017/5/15.
//  Copyright © 2017年 李鑫浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRYearAndMonthSelectedView : UIView <UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, copy) void (^SureSelectedDate) (NSString *strDate);

@property (nonatomic, copy) void (^SureSelectedYearMonth) (NSString *strDate);


/**
 *  显示时间选取页面
 */
-(void)ShowPickerView;

@end
