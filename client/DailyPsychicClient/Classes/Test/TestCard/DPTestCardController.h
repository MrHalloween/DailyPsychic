//
//  DPTestCardController.h
//  DailyPsychicClient
//
//  Created by zhanghe on 2018/1/30.
//  Copyright © 2018年 h. All rights reserved.
//

#import "BUCustomViewController.h"

@interface DPTestCardController : BUCustomViewController

@property (nonatomic,copy) NSString *testId;    ///测试题目id

@property (nonatomic,copy) NSDictionary *dictTest;

@end
