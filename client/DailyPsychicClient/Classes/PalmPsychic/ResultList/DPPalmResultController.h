//
//  DPPalmResultController.h
//  DailyPsychicClient
//
//  Created by lsy on 2018/2/1.
//  Copyright © 2018年 h. All rights reserved.
//

#import "BUCustomViewController.h"

typedef enum
{
    DPResultPalm = 1,//首相分析结果
    DPResultConstellation,//星座分析结果
    DPResultTest//每日日测试结果
}DPResultType;

@interface DPPalmResultController : BUCustomViewController

@property (nonatomic, assign) DPResultType dpResultType; /// < 结果页类型

@end
