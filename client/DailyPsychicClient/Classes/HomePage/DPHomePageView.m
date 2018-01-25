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
        self.backgroundColor = [UIColor whiteColor];
        m_arrData = [NSMutableArray arrayWithObjects:@{@"id":@0,@"title":@"手相分析",@"image":@""},
                                                     @{@"id":@1,@"title":@"星座",@"image":@""},
                                                     @{@"id":@2,@"title":@"测试",@"image":@""}, nil];
    }
    return self;
}

- (void)SetupBaseTableView
{
    [super SetupBaseTableView];
    m_pCircleView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 50, self.width, 300 * [AppConfigure GetLengthAdaptRate])];
    m_pCircleView.backgroundColor = [UIColor whiteColor];
    m_pCircleView.delegate = self;
    m_pCircleView.dataSource = self;
    m_pCircleView.minimumPageAlpha = 0.1;
    m_pCircleView.topBottomMargin = 40 * [AppConfigure GetLengthAdaptRate];
    m_pCircleView.leftRightMargin = 40 * [AppConfigure GetLengthAdaptRate];
    m_pCircleView.isOpenAutoScroll = NO;
    [m_pCircleView reloadData];
    [self addSubview:m_pCircleView];
}

#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(300 * [AppConfigure GetLengthAdaptRate], 300 * [AppConfigure GetLengthAdaptRate]);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    NSLog(@"ViewController 滚动到了第%zd页",pageNumber);
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    return 3;
}

- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = [flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] init];
        bannerView.tag = index;
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:@"https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=3893925858,3218784110&fm=173&s=5C4AB2550217546D0282AE42030060FD&w=500&h=341&img.JPEG"] placeholderImage:[UIImage imageNamed:@"homepage_top_banner.png"]];
    
    return bannerView;
}

@end
