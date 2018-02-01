//
//  DPImageViewCell.m
//  DailyPsychicClient
//
//  Created by lsy on 2018/1/30.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPImageViewCell.h"

@implementation DPImageViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //星座图片
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 46 * AdaptRate, 46 * AdaptRate)];
        [self addSubview:imageView];
        self.imageView = imageView;
    }
    return self;
}
- (void)setModel:(DPConstellationModel *)model{
    NSString *imgStr = [NSString stringWithFormat:@"constellation_%@",model.image];
    self.imageView.image = [UIImage imageNamed:imgStr];
}
@end
