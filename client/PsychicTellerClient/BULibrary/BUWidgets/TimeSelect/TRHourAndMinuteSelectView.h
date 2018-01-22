//
//  TRHourAndMinuteSelectView.h
//  pbuTRYYClient
//
//  Created by 李鑫浩 on 2017/5/7.
//  Copyright © 2017年 李鑫浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRHourAndMinuteSelectView : UIView <UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, copy) void (^SureSelectedDate) (NSString *strDate);

/**
 *  显示时间选取页面
 */
-(void)ShowPickerView;

@end
