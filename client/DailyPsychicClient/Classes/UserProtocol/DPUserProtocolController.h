//
//  DPUserProtocolController.h
//  DailyPsychicClient
//
//  Created by zhanghe on 2018/2/12.
//  Copyright © 2018年 h. All rights reserved.
//

#import "BUCustomViewController.h"

@interface DPUserProtocolController : BUCustomViewController

@property (nonatomic, copy) NSString *analysisType; /// < 手相分析还是test分析

@property (nonatomic,copy) NSString *testId;    ///测试题目id

@property (nonatomic,copy) NSString *notice;


@end
