//
//  DPPalmAnalysisController.h
//  DailyPsychicClient
//
//  Created by 李少艳 on 2018/1/31.
//  Copyright © 2018年 h. All rights reserved.
//

#import "BUCustomViewController.h"


@interface DPPalmAnalysisController : BUCustomViewController

@property (nonatomic, copy) NSString *analysisType; /// < 手相分析还是test分析
@property (nonatomic,strong) NSArray *profuctIdArr;

@property (nonatomic,copy) NSString *currentProId;

@property (nonatomic,copy) NSString *testId;    ///测试题目id

@end
