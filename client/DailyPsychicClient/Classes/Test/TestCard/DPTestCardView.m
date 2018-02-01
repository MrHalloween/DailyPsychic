//
//  DPTestCardView.m
//  DailyPsychicClient
//
//  Created by zhanghe on 2018/1/30.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPTestCardView.h"
#import "UILable+TextEffect.h"

@implementation DPTestCardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self AddSubViews];
    }
    return self;
}

- (void)AddSubViews
{
    //背景
    UIImageView *pContentView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    pContentView.userInteractionEnabled = YES;
    pContentView.image = [UIImage imageNamed:@"homepage_bg.png"];
    [self addSubview:pContentView];
    
    //title
    UILabel *m_pTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 36 * AdaptRate, self.width, 36 * AdaptRate)];
    [m_pTitleLabel SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager RegularFont] FontSize:18 Placehoder:@"Test"];
    m_pTitleLabel.textAlignment = NSTextAlignmentCenter;
    [pContentView addSubview:m_pTitleLabel];
    
    //返回按钮
    UIButton *pBackaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pBackaBtn.frame = CGRectMake(0, 35 * AdaptRate, 40 * AdaptRate, 35 * AdaptRate);
    [pBackaBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [pContentView addSubview:pBackaBtn];
    
    //返回图片
    UIImageView *pBackImg = [[UIImageView alloc]initWithFrame:CGRectMake(16 * AdaptRate, 13 * AdaptRate, 8 * AdaptRate, 14 * AdaptRate)];
    pBackImg.userInteractionEnabled = YES;
    pBackImg.image = [UIImage imageNamed:@"constellation_back"];
    [pBackaBtn addSubview:pBackImg];
    
    //answer background
    UIImageView *pAnswerBg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 361 * AdaptRate, 455 * AdaptRate)];
    pAnswerBg.center = CGPointMake(self.width * 0.5, 178 * AdaptRate + pAnswerBg.height * 0.5);
    pAnswerBg.userInteractionEnabled = YES;
    pAnswerBg.image = [UIImage imageNamed:@"test_answer_bg.png"];
    [self addSubview:pAnswerBg];
    
    //picture background
    UIImageView *pPictureBg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 195 * AdaptRate, 230 * AdaptRate)];
    pPictureBg.center = CGPointMake(self.width * 0.5, 84 * AdaptRate + pPictureBg.height * 0.5);
    pPictureBg.userInteractionEnabled = YES;
    pPictureBg.image = [UIImage imageNamed:@"test_pic.png"];
    [self addSubview:pPictureBg];
    
    //question
    UILabel *pQuestion = [[UILabel alloc]init];
    pQuestion.numberOfLines = 0;
    [pQuestion SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager RegularFont] FontSize:14 Placehoder:@"What kind of temperament are you？"];
    pQuestion.textAlignment = NSTextAlignmentCenter;
    pQuestion.frame = CGRectMake((self.width - 300 * AdaptRate) * 0.5, pPictureBg.bottom, 300 * AdaptRate, 67 * AdaptRate);
    [self addSubview:pQuestion];
    
    //answer
    NSArray *arrAnswers = @[@"Lovely",@"Hot",@"Pretty",@"Beautiful"];
    for (int i = 0; i < arrAnswers.count; i ++) {
        UIButton *pAnswerCell = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:pAnswerCell];
        [pAnswerCell setBackgroundImage:[UIImage imageNamed:@"test_cell.png"] forState:0];
        pAnswerCell.bounds = CGRectMake(0, 0, 283 * AdaptRate, 40 * AdaptRate);
        pAnswerCell.center = CGPointMake(self.width * 0.5, pQuestion.bottom + pAnswerCell.height * (i + 0.5) + 9 * AdaptRate * i);
        pAnswerCell.titleLabel.font = [UIFont fontWithName:[TextManager RegularFont] size:16];
        [pAnswerCell setTitle:arrAnswers[i] forState:0];
    }
    
    //page
//    UILabel *pPage = [[UILabel alloc]init];
//    [pPage SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager RegularFont] FontSize:16 Placehoder:@"1 / 10"];
//    pPage.textAlignment = NSTextAlignmentCenter;
//    pPage.frame = CGRectMake((self.width - 300 * AdaptRate) * 0.5, pPictureBg.bottom, 300 * AdaptRate, 67 * AdaptRate);
//    [self addSubview:pPage];
    
}

//返回
- (void)backBtnClick
{
    
}

@end
