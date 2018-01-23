//
//  BUCustomViewController.h
//  DaoTingTuShuo
//
//  Created by -3 on 14-7-17.
//  Copyright (c) 2014年  MultiMedia Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFTabBarViewController.h"

typedef void(^BackAction)(id object);

//Controller基类，所有Controller继承自本类
@interface BUCustomViewController : UIViewController
{
    UILabel* m_pNameLabel;               ///页面上标题
    UIButton* m_pBackButton;             ///返回按钮
    UIView* m_pTopBar;                   ///顶条
    UIView *m_pLineView;
}

@property(nonatomic,copy)BackAction propBackAction;

//返回或关闭
-(void)Back;

/**
 *  push到下一级级子控制器
 *
 *  @param pController 子控制器对象
 */
-(void)PushChildViewController:(UIViewController*)pController animated:(BOOL)animated;


@end
