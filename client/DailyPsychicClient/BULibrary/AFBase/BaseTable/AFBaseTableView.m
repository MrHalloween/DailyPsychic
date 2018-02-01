//
//  SXBaseTableView.m
//  pbuShanXiSecurityTrafficClient
//
//  Created by  on 15/12/16.
//  Copyright © 2015年 . All rights reserved.
//

#import "AFBaseTableView.h"
#import "UILable+TextEffect.h"

@interface AFBaseTableView ()
{
    UITableViewStyle m_iTableViewStyle;
}

@end

@implementation AFBaseTableView

- (id)initWithFrame:(CGRect)frame withTableViewStyle:(UITableViewStyle)argStyle
{
    self = [super initWithFrame:frame];
    if (self)
    {
        m_iTableViewStyle = argStyle;
        self.clipsToBounds = YES;
        m_arrData = [NSMutableArray array];
        [self SetupBaseTableView];
    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        m_iTableViewStyle = UITableViewStyleGrouped;
        self.clipsToBounds = YES;
        m_arrData = [NSMutableArray array];
        [self SetupBaseTableView];
    }
    return self;
}

- (void)SetupBaseTableView
{
    //背景
    UIImageView *pContentView = [[UIImageView alloc]initWithFrame:self.bounds];
    pContentView.userInteractionEnabled = YES;
    pContentView.image = [UIImage imageNamed:@"homepage_bg.png"];
    [self addSubview:pContentView];
    
    //title
    m_pTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_Y, self.width, 44)];
    m_pTitleLabel.userInteractionEnabled = YES;
    [m_pTitleLabel SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager RegularFont] FontSize:18 Placehoder:@"Test"];
    m_pTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:m_pTitleLabel];
    
    //返回图片
    pBackImg = [[UIImageView alloc]init];
    pBackImg.userInteractionEnabled = YES;
    pBackImg.image = [UIImage imageNamed:@"constellation_back"];
    pBackImg.bounds = CGRectMake(0, 0, 7.5 * AdaptRate, 14 * AdaptRate);
    pBackImg.center = CGPointMake(16 * AdaptRate + pBackImg.width * 0.5, m_pTitleLabel.center.y);
    [self addSubview:pBackImg];
    
    //返回按钮
    UIButton *pBackaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pBackaBtn.bounds = CGRectMake(0, 0, 50, 50);
    pBackaBtn.center = CGPointMake(pBackaBtn.width * 0.5, pBackImg.center.y);
    [pBackaBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:pBackaBtn];
    
    m_pBaseTable = [[UITableView alloc]initWithFrame:CGRectMake(0, m_pTitleLabel.bottom, self.width, self.height - m_pTitleLabel.bottom) style:m_iTableViewStyle];
    m_pBaseTable.delegate = self;
    m_pBaseTable.dataSource = self;
    m_pBaseTable.backgroundColor = [UIColor clearColor];
    m_pBaseTable.rowHeight = 44;
    m_pBaseTable.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    m_pBaseTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (@available(iOS 11.0, *)) {
        m_pBaseTable.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        m_pBaseTable.estimatedRowHeight = 0;
        m_pBaseTable.estimatedSectionHeaderHeight = 0;
        m_pBaseTable.estimatedSectionFooterHeight = 0;
    }
    [self addSubview:m_pBaseTable];

}

- (void)CreatNoDataViewWithFlagText:(NSString *)argText FlagImage:(UIImage *)argImage
{
    m_pNoDataView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, argImage.size.height + 30 * [AppConfigure GetLengthAdaptRate] + SIZE_HEIGHT(14))];
    m_pNoDataView.center = CGPointMake(self.width / 2.0f, 178 * [AppConfigure GetLengthAdaptRate] + m_pNoDataView.height / 2.0f);
    m_pNoDataView.hidden = YES;
    [self addSubview:m_pNoDataView];
    
    UIImageView *pNoDataImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, argImage.size.width, argImage.size.height)];
    pNoDataImageView.center = CGPointMake(self.width / 2.0f, pNoDataImageView.size.height / 2.0f);
    pNoDataImageView.image = argImage;
    [m_pNoDataView addSubview:pNoDataImageView];
    
    UILabel *m_pNoDataFlag = [[UILabel alloc]initWithFrame:CGRectMake(0, pNoDataImageView.bottom + 30 * [AppConfigure GetLengthAdaptRate], self.width, SIZE_HEIGHT(14))];
    m_pNoDataFlag.font = [UIFont systemFontOfSize:14];
    m_pNoDataFlag.textColor = UIColorFromHex(0x999999);
    m_pNoDataFlag.textAlignment = NSTextAlignmentCenter;
    m_pNoDataFlag.text = argText;
    [m_pNoDataView addSubview:m_pNoDataFlag];
}

- (void)SetTableViewData:(NSArray *)argData
{
    if ([m_pBaseTable.mj_header isRefreshing] || m_bHeaderRefresh)
    {
        m_bHeaderRefresh = NO;
        [m_arrData removeAllObjects];
    }
    if (argData.count == 0)
    {
        [m_pBaseTable.mj_footer endRefreshingWithNoMoreData];
    }
    [m_arrData addObjectsFromArray:argData];
    [m_pBaseTable reloadData];
    [self StopRefresh];
    
    if (m_arrData.count <= 0 && m_pNoDataView != nil)
    {
        m_pNoDataView.hidden = NO;
    }
    else
    {
        m_pNoDataView.hidden = YES;
    }
    if (m_pBaseTable.hidden && m_pNoDataView.hidden) {
    }
    
}

- (NSArray *)GetTableViewData
{
    return m_arrData;
}

- (BOOL)HadLoadData
{
    if (m_arrData == nil)
    {
        return NO;
    }
    return YES;
}

#pragma mark -- Refresh method
/**
 *  添加下拉刷新事件
 */
- (void)AddRefreshHeader
{
    __weak UITableView *pTableView = m_pBaseTable;
    ///添加刷新事件
    pTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(StartRefresh)];
    pTableView.mj_header.automaticallyChangeAlpha = YES;
}

/**
 *  添加上拉加载事件
 */
- (void)AddRefreshFooter
{
    __weak UITableView *pTableView = m_pBaseTable;
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(AddMoreCommentData)];
    footer.automaticallyHidden = YES;
    pTableView.mj_footer = footer;
}

- (void)StartRefresh
{
    if (m_pBaseTable.mj_footer != nil && [m_pBaseTable.mj_footer isRefreshing])
    {
        [m_pBaseTable.mj_footer endRefreshing];
    }
    if (!m_bHeaderRefresh)
    {
        m_bHeaderRefresh = YES;
        [m_pBaseTable.mj_footer resetNoMoreData];
        if (self.proDelegate != nil && [self.proDelegate respondsToSelector:@selector(RefreshDataWithStartId:)])
        {
            [self.proDelegate RefreshDataWithStartId:1];
        }
    }
}

- (void)AddMoreCommentData
{
    if (m_pBaseTable.mj_header != nil && [m_pBaseTable.mj_header isRefreshing])
    {
        [m_pBaseTable.mj_header endRefreshing];
    }
    m_bHeaderRefresh = NO;
    if (m_arrData.count % 10 == 0 && m_arrData.count / 10 >= 1)
    {
        if (self.proDelegate != nil && [self.proDelegate respondsToSelector:@selector(RefreshDataWithStartId:)])
        {
            [self.proDelegate RefreshDataWithStartId:m_arrData.count / 10 + 1];
        }
    }
    else
    {
        [m_pBaseTable.mj_footer endRefreshingWithNoMoreData];
        [self StopRefresh];
    }
}

- (void)StopRefresh
{
    if (m_pBaseTable.mj_header != nil && [m_pBaseTable.mj_header isRefreshing])
    {
        [m_pBaseTable.mj_header endRefreshing];
    }
    if (m_pBaseTable.mj_footer != nil && [m_pBaseTable.mj_footer isRefreshing])
    {
        [m_pBaseTable.mj_footer endRefreshing];
    }
}

#pragma mark -- UITableViewDatasource method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90 * [AppConfigure GetLengthAdaptRate];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.proDelegate != nil && [self.proDelegate respondsToSelector:@selector(PushToNextPage:)])
    {
        if (m_arrData.count <= 0)
        {
             [self.proDelegate PushToNextPage:nil];
        }
        else
        {
             [self.proDelegate PushToNextPage:m_arrData[indexPath.row]];
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

#pragma mark -- 此方法加上是为了适配iOS 11出现的问题
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (void)backBtnClick
{
    if (self.proDelegate && [self.proDelegate respondsToSelector:@selector(PopPreviousPage)]) {
        [self.proDelegate PopPreviousPage];
    }
}


@end
