//
//  DPTakePhotoView.m
//  DailyPsychicClient
//
//  Created by zhanghe on 2018/2/1.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPTakePhotoView.h"
#import "UILable+TextEffect.h"

@implementation DPTakePhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        m_pTitleLabel.text = @"Palm analysis";
        [self AddSubViews];
    }
    return self;
}

- (void)AddSubViews
{
    //主图形
    UIImageView *pMainImg = [[UIImageView alloc]init];
    pMainImg.bounds = CGRectMake(0, 0, 339 * AdaptRate, 417.5 * AdaptRate);
    pMainImg.center = CGPointMake(self.width * 0.5, m_pTitleLabel.bottom + 25 * AdaptRate + pMainImg.height * 0.5);
    pMainImg.image = [UIImage imageNamed:@"palm_left"];
    [self addSubview:pMainImg];
    
    //标题
    UILabel *pDesc1 = [[UILabel alloc]init];
    [pDesc1 SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager RegularFont] FontSize:20 Placehoder:@"Take a picture of"];
    pDesc1.textAlignment = NSTextAlignmentCenter;
    pDesc1.frame = CGRectMake(0, 270 * AdaptRate, pMainImg.width, SIZE_HEIGHT(20));
    [pMainImg addSubview:pDesc1];
    
    //标题
    UILabel *pDesc2 = [[UILabel alloc]init];
    [pDesc2 SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager RegularFont] FontSize:20 Placehoder:@"the right hand"];
    pDesc2.textAlignment = NSTextAlignmentCenter;
    pDesc2.frame = CGRectMake(0, pDesc1.bottom, pMainImg.width, SIZE_HEIGHT(20));
    [pMainImg addSubview:pDesc2];
    
    //标题
    UILabel *pDesc3 = [[UILabel alloc]init];
    [pDesc3 SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager RegularFont] FontSize:16 Placehoder:@"Your right hand represents your life"];
    pDesc3.textAlignment = NSTextAlignmentCenter;
    pDesc3.frame = CGRectMake(0, pDesc2.bottom + 20 * AdaptRate, pMainImg.width, SIZE_HEIGHT(16));
    [pMainImg addSubview:pDesc3];
    
    //get to result563126
    UIButton *pCamera = [UIButton buttonWithType:UIButtonTypeCustom];
    [pCamera addTarget:self action:@selector(TakePhotos) forControlEvents:UIControlEventTouchUpInside];
    pCamera.bounds = CGRectMake(0, 0, 281.5 * AdaptRate, 63 * AdaptRate);
    pCamera.center = CGPointMake(self.width * 0.5, pMainImg.bottom + 35 * AdaptRate + pCamera.height * 0.5);
    [pCamera setBackgroundImage:[UIImage imageNamed:@"palm_camera.png"] forState:UIControlStateNormal];
    [self addSubview:pCamera];
    
}


#pragma maark - 拍照
- (void)TakePhotos
{
    if (self.takePhotoDelegate && [self.takePhotoDelegate respondsToSelector:@selector(TakePhoto)]) {
        [self.takePhotoDelegate TakePhoto];
    }
}
@end
