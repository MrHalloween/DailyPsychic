//
//  DPPalmAnaylyingView.m
//  DailyPsychicClient
//
//  Created by 李少艳 on 2018/2/1.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPPalmAnaylyingView.h"
#import "UILable+TextEffect.h"

@interface DPPalmAnaylyingView()
{
    UIImageView *m_pMainImg;
    UILabel *m_pProcessLabel;
    NSTimer *m_pTimer;
    NSInteger processNum;
    UILabel *m_pFatelineLabel;
}
@end

@implementation DPPalmAnaylyingView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews
{
    pBackImg.hidden = YES;
    m_pTitleLabel.text =@"Palm analysis";
    
    //主图形
    m_pMainImg = [[UIImageView alloc]initWithFrame:CGRectMake(0 , 0, 295 * AdaptRate, 295 * AdaptRate)];
    m_pMainImg.center = CGPointMake(self.width/2, self.height/2 - 30 * AdaptRate);
    m_pMainImg.image = [UIImage imageNamed:@"palm_analying_one"];
    [self addSubview:m_pMainImg];
    
    //进度
    m_pProcessLabel = [[UILabel alloc]init];
    [m_pProcessLabel SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager HelveticaNeueFont] FontSize:25 Placehoder:@"1%"];
    m_pProcessLabel.frame = CGRectMake(0, 0, m_pMainImg.width, SIZE_HEIGHT(25));
    m_pProcessLabel.center = CGPointMake(295 * AdaptRate * 0.5, 295 * AdaptRate * 0.5);
    m_pProcessLabel.textAlignment = NSTextAlignmentCenter;
    [m_pMainImg addSubview:m_pProcessLabel];
    
    //Result processing
    UILabel *pResultProcess = [[UILabel alloc]init];
    [pResultProcess SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager HelveticaNeueFont] FontSize:20 Placehoder:@"Result processing"];
    pResultProcess.frame = CGRectMake(0, m_pMainImg.bottom + 15 * AdaptRate, self.width, SIZE_HEIGHT(20));
    pResultProcess.textAlignment = NSTextAlignmentCenter;
    [self addSubview:pResultProcess];
    
    //Analysis of the fate line
    m_pFatelineLabel = [[UILabel alloc]init];
    [m_pFatelineLabel SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager HelveticaNeueFont] FontSize:12 Placehoder:@"Analysis of life line"];
    m_pFatelineLabel.frame = CGRectMake(0, pResultProcess.bottom + 10 * AdaptRate, self.width, SIZE_HEIGHT(12));
    m_pFatelineLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:m_pFatelineLabel];
    
    [self fireTimer];
}
- (void)fireTimer{
    processNum = 1;
    m_pTimer =  [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateProcess) userInfo:nil repeats:YES];
    [m_pTimer fire];
}
- (void)updateProcess{
    processNum ++ ;
    m_pProcessLabel.text = [NSString stringWithFormat:@"%ld%%",processNum];
    NSString * strFiteLine;
    if (processNum < 30) {//生命线
        strFiteLine = @"Analysis of life line";
    }else if (processNum < 50){//智慧线
        strFiteLine = @"Analysis of head line";
    }else if (processNum < 70){//心脏线
        strFiteLine = @"Analysis of heart line";
    }else if (processNum < 90){//结婚线
        strFiteLine = @"Analysis of marrige line";
    }else{//命运线
        strFiteLine = @"Analysis of fate line";
    }
    m_pFatelineLabel.text = strFiteLine;
    if (processNum == 100) {
        [m_pTimer invalidate];
        m_pTimer = nil;
        [self performSelector:@selector(delayPush) withObject:nil afterDelay:0.5f];
    }
}

- (void)delayPush{
    
    if (self.proDelegate != nil && [self.proDelegate respondsToSelector:@selector(PushToNextPage:)]) {
        [self.proDelegate PushToNextPage:nil];
    }
}

@end
