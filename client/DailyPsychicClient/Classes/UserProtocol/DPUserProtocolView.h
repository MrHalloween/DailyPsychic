//
//  DPUserProtocolView.h
//  DailyPsychicClient
//
//  Created by zhanghe on 2018/2/12.
//  Copyright © 2018年 h. All rights reserved.
//

#import "AFBaseTableView.h"

@protocol DPUserProtocolViewDelegate <NSObject>

@optional
///重新购买
- (void)RestorePurchase;
///用户协议
- (void)UserProtocolWithTitle:(NSString *)title;

@end

@interface DPUserProtocolView : AFBaseTableView

@property (nonatomic,weak)id <DPUserProtocolViewDelegate>userDelegate;

@end
