//
//  DPPalmAnalysisView.h
//  DailyPsychicClient
//
//  Created by 李少艳 on 2018/1/31.
//  Copyright © 2018年 h. All rights reserved.
//

#import "AFBaseTableView.h"

@protocol PalmAnalysisDelegate<NSObject>

@end

@interface DPPalmAnalysisView : AFBaseTableView
@property (nonatomic ,weak)id<PalmAnalysisDelegate>palmAnalysisDel;
@end
