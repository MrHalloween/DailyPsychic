//
//  DPTestListView.m
//  DailyPsychicClient
//
//  Created by zhanghe on 2018/1/31.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPTestListView.h"
#import "DPTestListCell.h"
#import "UILable+TextEffect.h"

@implementation DPTestListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
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
    
    m_pBaseTable.frame = CGRectMake(0, 70 * AdaptRate, self.width, self.height - 70 * AdaptRate);
    [self bringSubviewToFront:m_pBaseTable];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DPTestListCell *pCell = [DPTestListCell CellWithTableView:tableView];
    pCell.backgroundColor = [UIColor clearColor];

//    [pCell ClearData];
//    [pCell SetCellData:m_arrData[indexPath.row]];
    return pCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 102 * AdaptRate;
}

//返回
- (void)backBtnClick
{

}
@end
