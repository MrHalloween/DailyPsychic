//
//  DPTestCardView.m
//  DailyPsychicClient
//
//  Created by zhanghe on 2018/1/30.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPTestCardView.h"
#import "UILable+TextEffect.h"
@interface DPTestCardView()
{
//    NSInteger m_nPageNum;
    NSDictionary *m_dicData;
}
@end

@implementation DPTestCardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        m_pTitleLabel.text = @"Test";
    }
    return self;
}

- (void)AddSubViews
{
    //answer background
    UIImageView *pAnswerBg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 361 * AdaptRate, 455 * AdaptRate)];
    pAnswerBg.center = CGPointMake(self.width * 0.5, m_pTitleLabel.bottom + 130 * AdaptRate + pAnswerBg.height * 0.5);
    pAnswerBg.userInteractionEnabled = YES;
    pAnswerBg.image = [UIImage imageNamed:@"test_answer_bg.png"];
    [self addSubview:pAnswerBg];
    
    //picture background
    UIImageView *pPictureBg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 195 * AdaptRate, 230 * AdaptRate)];
    pPictureBg.center = CGPointMake(self.width * 0.5, m_pTitleLabel.bottom + 34 * AdaptRate + pPictureBg.height * 0.5);
    pPictureBg.userInteractionEnabled = YES;
    pPictureBg.layer.masksToBounds = YES;
    pPictureBg.layer.cornerRadius = 5;
    pPictureBg.contentMode = UIViewContentModeScaleAspectFill;
    pPictureBg.image = [UIImage imageNamed:m_dicData[@"headImage"]];
    [self addSubview:pPictureBg];
    
    //question
    UILabel *pQuestion = [[UILabel alloc]init];
    pQuestion.numberOfLines = 0;
    [pQuestion SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager RegularFont] FontSize:14 Placehoder:m_dicData[@"title"]];
    pQuestion.textAlignment = NSTextAlignmentCenter;
    pQuestion.frame = CGRectMake((self.width - 300 * AdaptRate) * 0.5, pPictureBg.bottom, 300 * AdaptRate, 67 * AdaptRate);
    [self addSubview:pQuestion];
    
    //answer
    NSString *strAnswers = m_dicData[@"answers"];
    NSArray *arrAnswers = [strAnswers componentsSeparatedByString:@"#"];
//    NSArray *arrAnswers = @[@"Lovely",@"Hot",@"Pretty",@"Beautiful"];
    for (int i = 0; i < arrAnswers.count; i ++) {
        UIButton *pAnswerCell = [UIButton buttonWithType:UIButtonTypeCustom];
        [pAnswerCell addTarget:self action:@selector(SelectedAnswer) forControlEvents:UIControlEventTouchUpInside];
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

#pragma mark - 选择答案
- (void)SelectedAnswer
{
    if(self.testCardDelegate && [self.testCardDelegate respondsToSelector:@selector(SelectedAnswer)])
    {
        [self.testCardDelegate SelectedAnswer];
    }
}

- (void)setTestId:(NSString *)testId
{
    _testId = testId;
    NSArray *plistData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"testCard" ofType:@"plist"]];
    for (int i = 0; i < plistData.count; i++) {
        NSDictionary *dict = plistData[i];
        NSString *testId = dict[@"testId"];
        if ([testId isEqualToString:self.testId]) {
            m_arrData = [NSMutableArray arrayWithArray:dict[@"test"]];
            m_dicData = m_arrData[0];
            [m_arrData removeObjectAtIndex:0];
            ///把该测试的所有测试题目存进沙盒
            [[NSUserDefaults standardUserDefaults]setObject:m_arrData forKey:@"questions"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            break;
        }
    }
    [self AddSubViews];
}

- (void)setDictTest:(NSDictionary *)dictTest
{
    _dictTest = dictTest;
    m_dicData = dictTest;
    [self AddSubViews];
}

@end
