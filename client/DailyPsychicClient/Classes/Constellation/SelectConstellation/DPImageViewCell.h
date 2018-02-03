//
//  DPImageViewCell.h
//  DailyPsychicClient
//
//  Created by lsy on 2018/1/30.
//  Copyright © 2018年 h. All rights reserved.
//

#import "SCHCircleViewCell.h"
#import "DPConstellationModel.h"

@interface DPImageViewCell : SCHCircleViewCell

@property (weak, nonatomic) IBOutlet UIImageView *constellImage;
@property (nonatomic,strong) DPConstellationModel *model;

@end
