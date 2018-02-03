//
//  DPImageViewCell.m
//  DailyPsychicClient
//
//  Created by lsy on 2018/1/30.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPImageViewCell.h"

@implementation DPImageViewCell

- (void)setModel:(DPConstellationModel *)model{
    NSString *imgStr = [NSString stringWithFormat:@"constellation_%@",model.image];
    self.constellImage.image = [UIImage imageNamed:imgStr];
}
@end
