//
//  SXBaseTableView.h
//  pbuShanXiSecurityTrafficClient
//
//  Created by  on 15/12/16.
//  Copyright © 2015年 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@protocol AFBaseTableViewDelegate <NSObject>

@optional
/**
 *  代理方法，用于请求刷新数据
 *
 *  @param argStartId 开始
 */
- (void)RefreshDataWithStartId:(NSInteger)argStartId;

/**
 *  从当前表格push进入下一页面
 *
 *  @param argData 需要传递的model数据
 */
- (void)PushToNextPage:(id)argData;

@end


/**
 *  基本表格页面
 */
@interface AFBaseTableView : UIView<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    UITableView *m_pBaseTable;      ///列表
    NSMutableArray *m_arrData;      ///评论数据
    UIView *m_pNoDataView;          ///没有匹配内容
    BOOL m_bHeaderRefresh;          ///是否在刷新
}

@property(nonatomic,weak)id<AFBaseTableViewDelegate> proDelegate;

/**
 *  初始化
 *
 *  @param argStyle 表格风格
 */
- (id)initWithFrame:(CGRect)frame withTableViewStyle:(UITableViewStyle)argStyle;

/**
 *  设定评论列表，可以继承该方法，给表格添加新的属性
 */
- (void)SetupBaseTableView;

/**
 *  创建没有数据时的背景视图
 *
 *  @param argText 没有数据时的提示语
 *   @param argImage 没有数据时的提示图片
 */
- (void)CreatNoDataViewWithFlagText:(NSString *)argText FlagImage:(UIImage *)argImage;

/**
 *  传入评论数据，用于初始化表格
 *
 *  @param argData 存放评论数据的数组
 */
- (void)SetTableViewData:(NSArray *)argData;

/**
 *  获取表视图中的数据源
 *
 *  @return 数据源
 */
- (NSArray *)GetTableViewData;

/**
 *  是否已经加载过数据
 *
 *  @return YES 或 NO
 */
- (BOOL)HadLoadData;

/**
 *  添加下拉刷新事件
 */
- (void)AddRefreshHeader;

/**
 *  添加上拉加载事件
 */
- (void)AddRefreshFooter;

/**
 *  开始下拉刷新
 */
- (void)StartRefresh;

/**
 *  停止刷新
 */
- (void)StopRefresh;

@end
