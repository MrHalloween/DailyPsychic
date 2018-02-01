//
//  DPConstellationDetailView.h
//  DailyPsychicClient
//
//  Created by lsy on 2018/1/31.
//  Copyright © 2018年 h. All rights reserved.
//

#import "AFBaseTableView.h"

@protocol ConstellationDetailDelegate<NSObject>


@end

@interface DPConstellationDetailView : AFBaseTableView

@property (nonatomic ,weak)id<ConstellationDetailDelegate>conDetailDel;

@end
