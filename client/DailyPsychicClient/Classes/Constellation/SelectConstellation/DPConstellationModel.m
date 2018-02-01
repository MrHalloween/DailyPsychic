//
//  DPConstellationModel.m
//  DailyPsychicClient
//
//  Created by lsy on 2018/2/1.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPConstellationModel.h"

@implementation DPConstellationModel

+ (DPConstellationModel *)ModelWithDictionary:(NSDictionary *)dict
{
    DPConstellationModel * model = [[DPConstellationModel alloc]init];
    model.nameCn = dict[@"nameCn"];
    model.nameEn = dict[@"nameEn"];
    model.image = dict[@"image"];
    model.date = dict[@"date"];
    return model;
}

@end
