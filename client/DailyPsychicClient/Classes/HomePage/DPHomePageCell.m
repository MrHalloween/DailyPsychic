//
//  DPHomePageCell.m
//  DailyPsychicClient
//
//  Created by zhanghe on 2018/1/23.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPHomePageCell.h"
#import "UILable+TextEffect.h"

@implementation DPHomePageCell

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
    m_pContentView = [[UIImageView alloc]init];
    m_pContentView.backgroundColor = [UIColor blueColor];
    m_pContentView.bounds = CGRectMake(0, 0, SCREEN_WIDTH - 30 * [AppConfigure GetLengthAdaptRate], 150 * [AppConfigure GetLengthAdaptRate]);
    m_pContentView.layer.masksToBounds = YES;
    m_pContentView.layer.cornerRadius = 5;
    [self.contentView addSubview:m_pContentView];
    
    m_pTitle = [[UILabel alloc]init];
    [m_pTitle SetTextColor:[TextManager Color333] FontName:[TextManager RegularFont] FontSize:18 Placehoder:@"手相分析"];
    [m_pContentView addSubview:m_pTitle];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    m_pContentView.center = CGPointMake(self.contentView.width * 0.5, self.contentView.height * 0.5);
    [m_pTitle sizeToFit];
    m_pTitle.center = CGPointMake(15 * [AppConfigure GetLengthAdaptRate] + m_pTitle.width * 0.5, m_pContentView.height * 0.5);
}

- (void)ClearData
{
    
}

- (void)SetCellData:(id)argData
{
    NSDictionary *dict = argData;
    m_pTitle.text = dict[@"title"];
    [m_pTitle sizeToFit];
    
}
@end
