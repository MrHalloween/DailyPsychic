//
//  DPTestListCell.h
//  DailyPsychicClient
//
//  Created by zhanghe on 2018/1/31.
//  Copyright © 2018年 h. All rights reserved.
//

#import "AFBaseCell.h"

@interface DPTestListCell : AFBaseCell
{
    UIImageView *m_pContentImg;    ///背景
    UIImageView *m_pThumbnail;     ///缩略图
    UIImageView *m_pEye;           ///眼睛
    UILabel *m_pTitle;
    UILabel *m_pCount;
}
@end
