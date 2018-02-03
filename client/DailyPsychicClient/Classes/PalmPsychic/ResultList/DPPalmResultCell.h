//
//  DPPalmResultCell.h
//  DailyPsychicClient
//
//  Created by lsy on 2018/2/1.
//  Copyright © 2018年 h. All rights reserved.
//

#import "AFBaseCell.h"

@interface DPPalmResultCell : AFBaseCell
{
    UIImageView *m_pBgImg;    ///背景
    UILabel *m_pTitle;        ///标题
    UIView *m_PlineView;      ///横线
    UILabel *m_pContent;      ///内容
}
- (CGFloat)GetCellHeight;
@end
