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
    [m_pBgImg setImage:[UIImage imageNamed:@"palm_resultbg.png"]];
    [self.contentView addSubview:m_pBgImg];
    
    //标题
    m_pTitle = [[UILabel alloc]init];
    m_pTitle.textAlignment = NSTextAlignmentCenter;
    [m_pTitle SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager HelveticaNeueFont] FontSize:20 Placehoder:@"Hand"];
    [m_pBgImg addSubview:m_pTitle];
    
    //横线
    m_PlineView = [[UILabel alloc]init];
    m_PlineView.backgroundColor = [UIColor whiteColor];
    m_PlineView.alpha = 0.5;
    [m_pBgImg addSubview:m_PlineView];
    
    //内容
    m_pContent = [[UILabel alloc]init];
    [m_pContent SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager HelveticaFont] FontSize:12 Placehoder:@"Your test data will be deleted automatically after the detection process Your test data will be deleted automatically after the detection process Your test data will be deleted automatically after the detection process"];
    m_pContent.numberOfLines = 0;
    [m_pBgImg addSubview:m_pContent];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    m_pBgImg.frame = CGRectMake(18 * AdaptRate, 0, self.width - 36 * AdaptRate, 234 * AdaptRate);
    m_pTitle.frame = CGRectMake(0, 22 * AdaptRate, m_pBgImg.width, SIZE_HEIGHT(20));
    m_PlineView.frame = CGRectMake(40 * AdaptRate, m_pTitle.bottom + 18 *AdaptRate, m_pBgImg.width - 80 * AdaptRate, 1 * AdaptRate);
    CGSize contentSize = [m_pContent.text boundingRectWithSize:CGSizeMake(m_pBgImg.width - 80 * AdaptRate, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:12]} context:nil].size;
    m_pContent.frame = CGRectMake(40 * AdaptRate,m_PlineView.bottom + 10 * AdaptRate, m_pBgImg.width - 80 * AdaptRate, contentSize.height);
    m_pBgImg.height = m_pContent.bottom + 35 * AdaptRate;
    
}
- (CGFloat)GetCellHeight{
    [self layoutSubviews];
    return m_pBgImg.bottom;
}


- (void)SetCellData:(id)argData
{
    NSDictionary *dict = argData;
    m_pTitle.text = dict[@"title"];
    m_pContent.text = dict[@"content"];
}

@end
