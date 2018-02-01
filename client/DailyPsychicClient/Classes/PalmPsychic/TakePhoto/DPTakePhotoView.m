//
//  DPTakePhotoView.m
//  DailyPsychicClient
//
//  Created by zhanghe on 2018/2/1.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPTakePhotoView.h"
#import "UILable+TextEffect.h"

@interface DPTakePhotoView ()
{
    UIImageView *m_pMainImg;
    UILabel *m_pDesc2;
    UILabel *m_pDesc3;
}
@end

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
    m_pMainImg = [[UIImageView alloc]init];
    m_pMainImg.bounds = CGRectMake(0, 0, 339 * AdaptRate, 417.5 * AdaptRate);
    m_pMainImg.center = CGPointMake(self.width * 0.5, 81 * AdaptRate + m_pMainImg.height * 0.5);
    m_pMainImg.image = [UIImage imageNamed:@"palm_left"];
    [self addSubview:m_pMainImg];
    
    //标题
    UILabel *pDesc1 = [[UILabel alloc]init];
    [pDesc1 SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager RegularFont] FontSize:20 Placehoder:@"Take a picture of"];
    pDesc1.textAlignment = NSTextAlignmentCenter;
    pDesc1.frame = CGRectMake(0, 270 * AdaptRate, m_pMainImg.width, SIZE_HEIGHT(20));
    [m_pMainImg addSubview:pDesc1];
    
    //标题
    m_pDesc2 = [[UILabel alloc]init];
    [m_pDesc2 SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager RegularFont] FontSize:20 Placehoder:@"the left hand"];
    m_pDesc2.textAlignment = NSTextAlignmentCenter;
    m_pDesc2.frame = CGRectMake(0, pDesc1.bottom, m_pMainImg.width, SIZE_HEIGHT(20));
    [m_pMainImg addSubview:m_pDesc2];
    
    //标题
    m_pDesc3 = [[UILabel alloc]init];
    [m_pDesc3 SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager RegularFont] FontSize:15 Placehoder:@"Your left hand represents your life"];
    m_pDesc3.textAlignment = NSTextAlignmentCenter;
    m_pDesc3.frame = CGRectMake(0, m_pDesc2.bottom + 20 * AdaptRate, m_pMainImg.width, SIZE_HEIGHT(15));
    [m_pMainImg addSubview:m_pDesc3];
    
    //get to result563126
    UIButton *pCamera = [UIButton buttonWithType:UIButtonTypeCustom];
    [pCamera addTarget:self action:@selector(TakePhotos) forControlEvents:UIControlEventTouchUpInside];
    pCamera.bounds = CGRectMake(0, 0, 281.5 * AdaptRate, 63 * AdaptRate);
    pCamera.center = CGPointMake(self.width * 0.5, m_pMainImg.bottom + 25 * AdaptRate + pCamera.height * 0.5);
    [pCamera setBackgroundImage:[UIImage imageNamed:@"palm_camera.png"] forState:UIControlStateNormal];
    [self addSubview:pCamera];
    
    //标题
    UILabel *pDesc4 = [[UILabel alloc]init];
    [pDesc4 SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager RegularFont] FontSize:12 Placehoder:@"Your test data will be deleted automatically"];
    pDesc4.textAlignment = NSTextAlignmentCenter;
    pDesc4.frame = CGRectMake(0, pCamera.bottom + 10 * AdaptRate, self.width, SIZE_HEIGHT(12));
    [self addSubview:pDesc4];
    
    //标题
    UILabel *pDesc5 = [[UILabel alloc]init];
    [pDesc5 SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager RegularFont] FontSize:12 Placehoder:@"after the detection process"];
    pDesc5.textAlignment = NSTextAlignmentCenter;
    pDesc5.frame = CGRectMake(0, pDesc4.bottom, self.width, SIZE_HEIGHT(12));
    [self addSubview:pDesc5];
    
}


#pragma maark - 拍照
- (void)TakePhotos
{
    if (self.takePhotoDelegate && [self.takePhotoDelegate respondsToSelector:@selector(TakePhoto)]) {
        [self.takePhotoDelegate TakePhoto];
    }
}

- (void)setRighthand:(int)righthand
{
    _righthand = righthand;
    m_pMainImg.image = [UIImage imageNamed:@"palm_right"];
    m_pDesc2.text = @"the right hand";
    m_pDesc3.text = @"Your right hand represents your life";
}
@end
