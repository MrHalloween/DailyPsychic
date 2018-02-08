//
//  DPTakePhotoView.h
//  DailyPsychicClient
//
//  Created by zhanghe on 2018/2/1.
//  Copyright © 2018年 h. All rights reserved.
//

#import "AFBaseTableView.h"

@protocol DPTakePhotoViewDelegate <NSObject>

@optional
- (void)TakePhoto;

@end

@interface DPTakePhotoView : AFBaseTableView

@property (nonatomic,weak) id<DPTakePhotoViewDelegate>takePhotoDelegate;

@property (nonatomic,assign) int righthand;

@end
