//
//  DPPalmResultView.h
//  DailyPsychicClient
//
//  Created by lsy on 2018/2/1.
//  Copyright © 2018年 h. All rights reserved.
//

#import "AFBaseTableView.h"

@interface DPPalmResultView : AFBaseTableView

@property (nonatomic, assign) int resultType; /// < 结果页类型

@property (nonatomic,copy) NSString *testId;    ///测试题目id

@end
