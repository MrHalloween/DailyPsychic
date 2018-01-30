//
//  DPHomePageView.h
//  DailyPsychicClient
//
//  Created by zhanghe on 2018/1/23.
//  Copyright © 2018年 h. All rights reserved.
//

#import "AFBaseTableView.h"

@protocol DPHomePageViewDelegate<NSObject>

- (void)PushToDetailByPageNumber:(long)pageNumber;

@end

@interface DPHomePageView : AFBaseTableView

@property (nonatomic ,weak)id<DPHomePageViewDelegate>homePageDel;

@end
