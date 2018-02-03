//
//  DPBasicInforView.m
//  DailyPsychicClient
//
//  Created by lsy on 2018/2/2.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPBasicInforView.h"
#import "UILable+TextEffect.h"
#import "AFTimeSelctedView.h"

@interface DPBasicInforView()<UITextFieldDelegate>
{
    AFTimeSelctedView *m_pTimeSelect;
    UITextField *m_pBirthText;
    UITextField *m_pNameText;
}
@end

@implementation DPBasicInforView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews{
    
     m_pTitleLabel.text = @"Basic Information";
    NSDictionary *dicInfor = [[NSUserDefaults standardUserDefaults]objectForKey:@"basicInfor"];
    //背景图
    UIImageView *pMainImg = [[UIImageView alloc]initWithFrame:CGRectMake(15 * AdaptRate, 82 * AdaptRate, self.width - 30 * AdaptRate, 322 * AdaptRate)];
    pMainImg.userInteractionEnabled = YES;
    pMainImg.image = [UIImage imageNamed:@"basic_bg"];
    [self addSubview:pMainImg];
    
    //Full name
    UILabel *pfullName = [[UILabel alloc]init];
    [pfullName SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager HelveticaNeueFont] FontSize:16 Placehoder:@"Full name"];
    pfullName.alpha = 0.6;
    pfullName.frame = CGRectMake(40 * AdaptRate, 30 * AdaptRate, 100 * AdaptRate, SIZE_HEIGHT(16));
    [pfullName sizeToFit];
    pfullName.textAlignment = NSTextAlignmentLeft;
    [pMainImg addSubview:pfullName];
    
    //name TextField
    m_pNameText = [[UITextField alloc]init];
    m_pNameText.frame = CGRectMake(40 * AdaptRate, pfullName.bottom + 10 * AdaptRate, pMainImg.width - 80 * AdaptRate, 42 * AdaptRate);
    m_pNameText.textColor = [UIColor whiteColor];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    m_pNameText.leftView = paddingView;
    m_pNameText.leftViewMode = UITextFieldViewModeAlways;
    m_pNameText.font = [UIFont systemFontOfSize:16];
    m_pNameText.background = [UIImage imageNamed:@"basic_inputbg"];
    m_pNameText.text = dicInfor[@"name"];
    [pMainImg addSubview:m_pNameText];
    
    //Your birthday
    UILabel *pBirthdayLabel = [[UILabel alloc]init];
    pBirthdayLabel.alpha = 0.6;
    [pBirthdayLabel SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager HelveticaNeueFont] FontSize:16 Placehoder:@"Your birthday"];
    pBirthdayLabel.frame = CGRectMake(40 * AdaptRate,m_pNameText.bottom + 18 * AdaptRate, 100 * AdaptRate, SIZE_HEIGHT(16));
    [pBirthdayLabel sizeToFit];
    pBirthdayLabel.textAlignment = NSTextAlignmentLeft;
    [pMainImg addSubview:pBirthdayLabel];
    
    //birth TextField
    m_pBirthText = [[UITextField alloc]init];
    m_pBirthText.frame = CGRectMake(40 * AdaptRate, pBirthdayLabel.bottom + 10 * AdaptRate, pMainImg.width - 80 * AdaptRate, 42 * AdaptRate);
    m_pBirthText.textColor = [UIColor whiteColor];
    UIView *paddingViewB = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    m_pBirthText.leftView = paddingViewB;
    m_pBirthText.leftViewMode = UITextFieldViewModeAlways;
    m_pBirthText.font = [UIFont systemFontOfSize:16];
    m_pBirthText.background = [UIImage imageNamed:@"basic_inputbg"];
    m_pBirthText.delegate = self;
    m_pBirthText.text = dicInfor[@"birth"];
    [pMainImg addSubview:m_pBirthText];

    
    //tipText
    UILabel *pTipText = [[UILabel alloc]init];
    [pTipText SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager HelveticaNeueFont] FontSize:12 Placehoder:@"The constellation is based on your name and birthday, which is very important for astrology."];
    pTipText.frame = CGRectMake(30 * AdaptRate, pMainImg.bottom + 30 * AdaptRate, self.width - 60 * AdaptRate, SIZE_HEIGHT(12) * 2);
    pTipText.numberOfLines = 2;
    pTipText.alpha = 0.6;
    pTipText.textAlignment = NSTextAlignmentCenter;
    [self addSubview:pTipText];
    
    //ok
    UIButton *pGetResultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pGetResultBtn.frame = CGRectMake((self.width - 282 * AdaptRate)/2, pTipText.bottom + 70 * AdaptRate, 282 * AdaptRate, 63 * AdaptRate);
    [pGetResultBtn setBackgroundImage:[UIImage imageNamed:@"basic_ok"] forState:UIControlStateNormal];
    [pGetResultBtn addTarget:self action:@selector(pushToNext) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:pGetResultBtn];
}

- (void)selcteTime{
    
    if (m_pTimeSelect == nil)
    {
        m_pTimeSelect = [[AFTimeSelctedView        alloc]initWithFrame:SCREEN_BOUNDS];
        if (m_pBirthText.text.length != 0) {
             [m_pTimeSelect SetDefaultTime:m_pBirthText.text];
        }
        __weak typeof(m_pBirthText) weakBirthTest = m_pBirthText;
        m_pTimeSelect.SureSelectedDate = ^(NSString *strDate){
            weakBirthTest.text = strDate;
        };
        [self.window addSubview:m_pTimeSelect];
    }
    [m_pTimeSelect ShowPickerView];
}
//进入下一页
- (void)pushToNext{
    if (m_pNameText.text.length == 0 && m_pBirthText.text.length == 0) {
        [AlertManager ShowRelutWithMessage:@"请将信息填写完整！" Dismiss:^{
            
        }];
    }else{
        NSMutableDictionary * dicInfo = [NSMutableDictionary dictionary];
        [dicInfo setValue:m_pNameText.text forKey:@"name"];
        [dicInfo setValue:m_pBirthText.text forKey:@"birth"];
        [[NSUserDefaults standardUserDefaults]setObject:dicInfo forKey:@"basicInfor"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        if (self.proDelegate != nil && [self.proDelegate respondsToSelector:@selector(PushToNextPage:)]) {
            [self.proDelegate PushToNextPage:nil];
        }
    }
}

#pragma mark - textField delagate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == m_pBirthText) {
        [self selcteTime];
        return NO;
    }else{
        return YES;
    }
}
@end
