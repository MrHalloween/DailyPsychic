//
//  DPTermsView.m
//  DailyPsychicClient
//
//  Created by zhanghe on 2018/2/12.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPTermsView.h"
@interface DPTermsView()
{
    UITextView *m_pContentView;
}
@end

@implementation DPTermsView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews
{
    //主图形
    UIImageView *pMainImg = [[UIImageView alloc]initWithFrame:CGRectMake(21 * AdaptRate, 102 * AdaptRate, 335 * AdaptRate, 409 * AdaptRate)];
    pMainImg.center = CGPointMake(self.width/2, self.height/2 - 30 * AdaptRate);
    pMainImg.image = [UIImage imageNamed:@"palm_main"];
    [self addSubview:pMainImg];
    
    m_pContentView = [[UITextView alloc]init];
    m_pContentView.backgroundColor = [UIColor clearColor];
    m_pContentView.font = [UIFont fontWithName:[TextManager RegularFont] size:16];
    m_pContentView.textColor = [UIColor whiteColor];
    m_pContentView.editable = NO;
    [self addSubview:m_pContentView];
    m_pContentView.frame = CGRectMake(10 * AdaptRate, m_pTitleLabel.bottom, self.width - 20 * AdaptRate, self.height - m_pTitleLabel.bottom - 10 * AdaptRate);
}

- (void)setPropTitle:(NSString *)propTitle
{
    _propTitle = propTitle;
    m_pTitleLabel.text = propTitle;

}

- (void)setPropContent:(NSString *)propContent
{
    _propContent = propContent;
    m_pContentView.text = propContent;
}

@end
