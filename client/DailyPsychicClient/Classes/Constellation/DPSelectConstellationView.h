//
//  DPSelectConstellationView.h
//  DailyPsychicClient
//
//  Created by 李少艳 on 2018/1/29.
//  Copyright © 2018年 h. All rights reserved.
//

#import "AFBaseTableView.h"

@protocol SelectConstellationDelegate<NSObject>

- (void)BackTo;

@end

@interface DPSelectConstellationView : AFBaseTableView

@property (nonatomic ,weak)id<SelectConstellationDelegate>selectConstellationDel;

@end
