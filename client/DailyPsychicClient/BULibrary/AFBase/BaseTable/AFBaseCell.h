//
//  SXBaseCommentCell.h
//  pbuShanXiSecurityTrafficClient
//
//  Created by  on 15/12/16.
//  Copyright © 2015年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFBaseCell : UITableViewCell

/**
 *  创建或重用一个单元格
 *
 *  @param argTableView 单元格所属表格
 *
 *  @return 单元格
 */
+ (instancetype)CellWithTableView:(UITableView *)argTableView;

#pragma mark -- 以下方法需要在子类中继承实现
/**
 *  设置单元格数据
 */
- (void)SetCellData:(id)argData;
/**
 *  设置添加控件
 */
-(void)AddSubViews;
/**
 *  清空控件数据
 */
- (void)ClearData;

@end
