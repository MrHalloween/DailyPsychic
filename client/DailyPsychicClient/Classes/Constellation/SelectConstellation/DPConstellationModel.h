//
//  DPConstellationModel.h
//  DailyPsychicClient
//
//  Created by lsy on 2018/2/1.
//  Copyright © 2018年 h. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPConstellationModel : NSObject

@property (nonatomic, copy) NSString *nameEn; /// < 星座中文名
@property (nonatomic, copy) NSString *nameCn; /// < 星座英文名
@property (nonatomic, copy) NSString *image; /// < 星座图片
@property (nonatomic, copy) NSString *imageSelect; /// < 星座选中图片
@property (nonatomic, copy) NSString *imageCircle; /// < 星座选中外围圆圈
@property (nonatomic, copy) NSString *date; /// < 星座日期
+ (DPConstellationModel *)ModelWithDictionary:(NSDictionary *)dict;

@end
