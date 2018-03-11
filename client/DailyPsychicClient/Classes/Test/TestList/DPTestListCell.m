//
//  DPTestListCell.m
//  DailyPsychicClient
//
//  Created by zhanghe on 2018/1/31.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPTestListCell.h"
#import "UILable+TextEffect.h"
#import "NSString+IntValue.h"

@implementation DPTestListCell

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
    m_pContentImg = [[UIImageView alloc]init];
    [m_pContentImg setImage:[UIImage imageNamed:@"test_list_bg.png"]];
    m_pContentImg.bounds = CGRectMake(0, 0, 359 * [AppConfigure GetLengthAdaptRate], 105 * [AppConfigure GetLengthAdaptRate]);
    [self.contentView addSubview:m_pContentImg];
    
    ///缩略图
    m_pThumbnail = [[UIImageView alloc]init];
    [m_pThumbnail setImage:[UIImage imageNamed:@"test_pic.png"]];
    m_pThumbnail.layer.masksToBounds = YES;
    m_pThumbnail.layer.cornerRadius = 5;
    m_pThumbnail.contentMode = UIViewContentModeScaleAspectFill;
    m_pThumbnail.bounds = CGRectMake(0, 0, 95 * [AppConfigure GetLengthAdaptRate], 67 * [AppConfigure GetLengthAdaptRate]);
    [m_pContentImg addSubview:m_pThumbnail];
    
    ///眼睛
    m_pEye = [[UIImageView alloc]init];
    [m_pEye setImage:[UIImage imageNamed:@"test_list_eye.png"]];
    m_pEye.bounds = CGRectMake(0, 0, 17 * [AppConfigure GetLengthAdaptRate], 17 * [AppConfigure GetLengthAdaptRate]);
    [m_pContentImg addSubview:m_pEye];
    
    m_pTitle = [[UILabel alloc]init];
    m_pTitle.numberOfLines = 2;
    [m_pTitle SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager RegularFont] FontSize:14 Placehoder:@"Who is your soul mate?"];
    [m_pContentImg addSubview:m_pTitle];
    
    m_pCount = [[UILabel alloc]init];
    [m_pCount SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager RegularFont] FontSize:14 Placehoder:@"1300"];
    [m_pContentImg addSubview:m_pCount];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    m_pContentImg.center = CGPointMake(self.contentView.width * 0.5, self.contentView.height * 0.5);
    m_pThumbnail.center = CGPointMake(18 * AdaptRate + m_pThumbnail.width * 0.5, m_pContentImg.height * 0.5 - 3 *AdaptRate);
    m_pTitle.frame = CGRectMake(m_pThumbnail.right + 10 * AdaptRate, m_pThumbnail.top, m_pContentImg.width - m_pThumbnail.width - 35 * AdaptRate, 47 * AdaptRate);
    m_pEye.center = CGPointMake(m_pThumbnail.right + 10 * AdaptRate + m_pEye.width * 0.5, m_pTitle.bottom + m_pEye.height * 0.5);
    [m_pCount sizeToFit];
    m_pCount.center = CGPointMake(m_pEye.right + 5 * AdaptRate + m_pCount.width * 0.5, m_pEye.center.y);

}

- (void)ClearData
{
    
}

- (void)SetCellData:(id)argData
{
    NSDictionary *dict = argData;
    [m_pThumbnail setImage:[UIImage imageNamed:dict[@"headImage"]]];
//    [m_pThumbnail setImage:[UIImage imageNamed:@"9"]];

    m_pTitle.text = dict[@"title"];
    int x = arc4random() % 50;
    NSString *num = dict[@"watchNum"];
    int intnum = [num intValue] + x;
    m_pCount.text = [NSString IntString:intnum];
    [m_pCount sizeToFit];
}

//- (void)setFrame:(CGRect)frame
//{
//    frame.origin.y += 15 * AdaptRate;
//    [super setFrame:frame];
//}

@end
