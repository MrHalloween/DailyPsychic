//
//  DPHomePageView.m
//  DailyPsychicClient
//
//  Created by zhanghe on 2018/1/23.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPHomePageView.h"
#import "NewPagedFlowView.h"
#import "UIImageView+WebCache.h"
#import "UILable+TextEffect.h"

@interface DPHomePageView ()<NewPagedFlowViewDelegate, NewPagedFlowViewDataSource>
{
    NewPagedFlowView *m_pCircleView;
}
@end

@implementation DPHomePageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        m_arrData = [NSMutableArray arrayWithObjects:@{@"id":@0,@"title":@"手相分析",@"image":@"homepage_card_hand.png"},
                                                     @{@"id":@1,@"title":@"星座",@"image":@"homepage_card_star.png"},
                                                     @{@"id":@2,@"title":@"测试",@"image":@"homepage_card_test.png"}, nil];
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
    
    //标题
    UILabel *pTitle = [[UILabel alloc]init];
    [pTitle SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager RegularFont] FontSize:17 Placehoder:@"Daily Psychic"];
    pTitle.textAlignment = NSTextAlignmentCenter;
    pTitle.frame = CGRectMake(0, 36 * [AppConfigure GetLengthAdaptRate], self.width, SIZE_HEIGHT(17));
    [pContentView addSubview:pTitle];

    m_pCircleView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, pTitle.bottom + 41 * [AppConfigure GetLengthAdaptRate], self.width, 300 * [AppConfigure GetLengthAdaptRate])];
//    m_pCircleView.backgroundColor = [UIColor whiteColor];
    m_pCircleView.delegate = self;
    m_pCircleView.dataSource = self;
    m_pCircleView.minimumPageAlpha = 0.1;
    m_pCircleView.topBottomMargin = 50 * [AppConfigure GetLengthAdaptRate];
    m_pCircleView.leftRightMargin = 0 * [AppConfigure GetLengthAdaptRate];
    m_pCircleView.isOpenAutoScroll = NO;
    [m_pCircleView reloadData];
    [pContentView addSubview:m_pCircleView];
    
    //三角
    UIImageView *pTriangle = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15 * [AppConfigure GetLengthAdaptRate], 7.5 * [AppConfigure GetLengthAdaptRate])];
    pTriangle.center = CGPointMake(self.width * 0.5, m_pCircleView.bottom + pTriangle.height * 0.5);
    pTriangle.image = [UIImage imageNamed:@"homepage_triangle.png"];
    [self addSubview:pTriangle];
    
    //标题
    UILabel *pDesc1 = [[UILabel alloc]init];
    [pDesc1 SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager RegularFont] FontSize:14 Placehoder:@"Please select the mode first"];
    pDesc1.textAlignment = NSTextAlignmentCenter;
    pDesc1.frame = CGRectMake(0, pTriangle.bottom + 10 * [AppConfigure GetLengthAdaptRate], self.width, SIZE_HEIGHT(14));
    [pContentView addSubview:pDesc1];
    
    //标题
    UILabel *pDesc2 = [[UILabel alloc]init];
    [pDesc2 SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager RegularFont] FontSize:18 Placehoder:@"Daily Psychic"];
    pDesc2.textAlignment = NSTextAlignmentCenter;
    pDesc2.frame = CGRectMake(0, pDesc1.bottom + 45 * [AppConfigure GetLengthAdaptRate], self.width, SIZE_HEIGHT(18));
    [pContentView addSubview:pDesc2];
    
    //标题
    UILabel *pDesc3 = [[UILabel alloc]init];
    [pDesc3 SetTextColor:UIColorFromHex(0xD2DEE6) FontName:[TextManager RegularFont] FontSize:8 Placehoder:@"WELCOME TO THE DAILY PSYCHIC"];
    pDesc3.textAlignment = NSTextAlignmentCenter;
    pDesc3.frame = CGRectMake(0, pDesc2.bottom + 8 * [AppConfigure GetLengthAdaptRate], self.width, SIZE_HEIGHT(8));
    [pContentView addSubview:pDesc3];
    
    
    //ok
    UIButton *pOk = [UIButton buttonWithType:UIButtonTypeCustom];
    pOk.bounds = CGRectMake(0, 0, 281.5 * [AppConfigure GetLengthAdaptRate], 63 * [AppConfigure GetLengthAdaptRate]);
    pOk.center = CGPointMake(self.width * 0.5, pDesc3.bottom + 33 * [AppConfigure GetLengthAdaptRate] + pOk.height * 0.5);
    [pOk setBackgroundImage:[UIImage imageNamed:@"homepage_ok.png"] forState:0];
    [pContentView addSubview:pOk];
    
}

#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(316 * [AppConfigure GetLengthAdaptRate], 339 * [AppConfigure GetLengthAdaptRate]);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    NSLog(@"ViewController 滚动到了第%zd页",pageNumber);
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    return m_arrData.count;
}

- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = [flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] init];
        bannerView.tag = index;
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    NSDictionary *dict = m_arrData[index];
    [bannerView.mainImageView setImage:[UIImage imageNamed:dict[@"image"]]];
    
    return bannerView;
}

@end
