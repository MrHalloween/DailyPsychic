//
//  DPPalmResultCell.m
//  DailyPsychicClient
//
//  Created by lsy on 2018/2/1.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPPalmResultCell.h"
#import "UILable+TextEffect.h"

@implementation DPPalmResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)AddSubViews
{
    ///背景
    m_pBgImg = [[UIImageView alloc]init];
    [m_pBgImg setImage:[UIImage imageNamed:@"test_list_bg.png"]];
    [self.contentView addSubview:m_pBgImg];
    
    //标题
    m_pTitle = [[UILabel alloc]init];
    [m_pTitle SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager HelveticaNeueFont] FontSize:20 Placehoder:@"Hand"];
    [m_pBgImg addSubview:m_pTitle];
    
    //横线
    m_PlineView = [[UILabel alloc]init];
    m_PlineView.backgroundColor = [UIColor whiteColor];
    m_PlineView.alpha = 0.5;
    [m_pBgImg addSubview:m_PlineView];
    
    //内容
    m_pContent = [[UILabel alloc]init];
    [m_pContent SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager HelveticaNeueFont] FontSize:12 Placehoder:@"Your test data will be deleted automatically after the detection process Your test data will be deleted automatically after the detection process Your test data will be deleted automatically after the detection process"];
    m_pContent.numberOfLines = 0;
    [m_pBgImg addSubview:m_pContent];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    m_pBgImg.frame = CGRectMake(18 * AdaptRate, 0, 339 * AdaptRate, 234 * AdaptRate);
    m_PlineView.frame = CGRectMake(20 * AdaptRate, 58 *AdaptRate, 281 * AdaptRate, 1 * AdaptRate);
    m_pContent.frame = CGRectMake(19 * AdaptRate,m_PlineView.bottom + 33 * AdaptRate, 273 * AdaptRate, 102 * AdaptRate);
    
}

- (void)ClearData
{
    
}

//- (void)SetCellData:(id)argData
//{
//
//}

@end
