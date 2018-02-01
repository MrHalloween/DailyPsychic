//
//  DPTakePhotoController.h
//  DailyPsychicClient
//
//  Created by zhanghe on 2018/2/1.
//  Copyright © 2018年 h. All rights reserved.
//

#import "BUCustomViewController.h"

typedef NS_ENUM(NSInteger, UserHand) {
    UserHandTypeLeft = 0,
    UserHandTypeRight = 1,
};

@interface DPTakePhotoController : BUCustomViewController

@property(nonatomic) UserHand userHandType;

@end
