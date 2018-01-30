//
//  DPSelectConstellationView.m
//  DailyPsychicClient
//
//  Created by 李少艳 on 2018/1/29.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPSelectConstellationView.h"

@implementation DPSelectConstellationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}
- (void)addSubViews{
    // 背景
    UIImageView *bgImg = [[UIImageView alloc]initWithFrame:self.frame];
    bgImg.image = [UIImage imageNamed:@""];
    [self addSubview:bgImg];
}


@end
