//
//  SCHCricleView.h
//  SCHCricleView
//
//  Created by 魏巍 on 12-11-10.
//  Copyright (c) 2012年 sch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCHCircleViewCell.h"


#define CENTER_POINT     self.center //中心点
#define RADIUS           126 * AdaptRate       //半径
#define DEVIATION_RAIAN  M_PI        //偏移弧度
#define IS_CAN_EDIT      NO          //是否可以编辑
#define SCAlE            1.0f        //比例
#define DRAG_SENSITIVITY 1.0f        //灵敏度

/*弧度偏移的点定义为 👇 为初始点*/

@class SCHCircleView;

/*cricle 出现的方式*/
typedef enum
{
    /*简单的 出现 (没有动画效果)*/
    SCHShowCircleDefault = 1,      //默认
    
    /*发散的 出现*/
    SCHShowCircleDiffuse = 1 << 1,
    
    /*递增发散的 出现 (发条)*/
    SChShowCircleWinding = 1 << 2
}SCHShowCircleStyle;


/*cricel 点击移动的方式*/
typedef enum
{
    /*线性的 滚动*/
    SCHTouchCircleDefault    = 1,     //默认
    
    /*延迟的 滚动*/
    SCHTouchCricleDelayRoll  = 1 << 1,
    
    /*不滚动*/
    SCHTouchCircleNoRoll     = 1 << 2
    
}SCHTouchCircleStyle;

/*cricle 排列的方式*/
typedef enum
{
    /*简单的 图标线性大小改变*/
    SCHCircleLayoutDefault   = 1,     //默认
    
    /*图标的 大小不改变*/
    SChCircleLayoutNormal    = 1 << 1,
    
}SCHCircleLayoutStyle;

/*插入图标的方式*/
typedef enum
{
    /*简单的 插入*/
    SCHCircleInsertDefault   = 1,     //默认
    
    /*闪烁的 插入*/
    SCHCircleInsertTwinkle   = 1 << 1
    
}SCHCircleInsertStyle;

/*删除图标的方式*/
typedef enum
{
    /*简单的 删除*/
    SCHCircleDeleteDefault   = 1,      //默认
    
    /*闪烁的 删除*/
    SCHCircleDeleteTwinkle   = 1 << 1
    
}SCHCircleDeleteStyle;


/*数据源*/
@protocol  SCHCircleViewDataSource<NSObject>
@optional

/*返回 多少图标*/
- (NSInteger)numberOfCellInCircleView:(SCHCircleView *)circle_view;

/*返回 圆的半径*/
- (CGFloat)radiusOfCircleView:(SCHCircleView *)circle_view;

/*返回中心点*/
- (CGPoint)centerOfCircleView:(SCHCircleView *)circle_view;

/*返回 schcricleview cell*/
- (SCHCircleViewCell *)circleView:(SCHCircleView *)circle_view cellAtIndex:(NSInteger)index_circle_cell;

/*返回 偏移的弧度*/
- (CGFloat)deviationRadianOfCircleView:(SCHCircleView *)circle_view;

/*比例改变量*/
- (CGFloat)scaleOfCircleViewCell:(SCHCircleView *)circle_view;

/*拖拽的的灵敏度*/
- (CGFloat)dragSensitivityOfCircleViewCell:(SCHCircleView *)circle_view;


/*是否 允许编辑(默认不允许编辑)*/
- (BOOL)circleViewCanEdit:(SCHCircleView *)circle_view;

@end

/*委托事件*/
@protocol SCHCircleViewDelegate <NSObject>
@optional
/*cricleview cell 的 单击事件*/
/*开始单击*/
- (void)touchBeginCircleViewCell:(SCHCircleViewCell *)cell indexOfCircleViewCell:(NSInteger)index;
/*单击结束*/
- (void)touchEndCircleViewCell:(SCHCircleViewCell *)cell indexOfCircleViewCell:(NSInteger)index;
/*单击取消*/
- (void)touchCancelCircleViewCell:(SCHCircleViewCell *)cell indexOfCircleViewCell:(NSInteger)index;
/*单击失败*/
- (void)touchFailCircleViewCell:(SCHCircleViewCell *)cell indexOfCircleViewCell:(NSInteger)index;

/*拖动*/
/*开始拖动*/
- (void)dragBeginCircleViewCell:(SCHCircleViewCell *)cell indexOfCircleViewCell:(NSInteger)index;
/*拖动中*/
- (void)dragingCircleViewCell:(SCHCircleViewCell *)cell indexOfCircleViewCell:(NSInteger)index;
/*结束拖动*/
- (void)dragEndCircleViewCell:(SCHCircleViewCell *)cell indexOfCircleViewCell:(NSInteger)index;
/*拖动失败*/
- (void)dragFailCircleViewCell:(SCHCircleViewCell *)cell indexOfCircleViewCell:(NSInteger)index;
/*拖动取消*/
- (void)dragCancelCircleViewCell:(SCHCircleViewCell *)cell indexOfCircleViewCell:(NSInteger)index;

/*进入编辑状态*/
/*开始编辑*/
- (void)circleViewBeginEdit:(SCHCircleView *)circle_view;
/*结束编辑*/
- (void)circleViewEndEdit:(SCHCircleView *)circle_view;

/*删除全部*/
/*开始删除*/
- (void)circleViewBeginDelete:(SCHCircleView *)circle_view;
/*结束删除*/
- (void)circleViewEndDelete:(SCHCircleView *)circle_view;

@end


@interface SCHCircleView : UIView<SCHCircleViewCellDelegate>
{
    SCHShowCircleStyle    _show_circle_style;     //显示方式
    
    SCHTouchCircleStyle   _touch_circle_style;    //点击移动方式
    
    SCHCircleLayoutStyle  _circle_layout_style;   //布局方式
    
    SCHCircleInsertStyle  _circle_insert_style;   //插入方式
    
    SCHCircleDeleteStyle  _circle_delete_style;   //移除方式
    
    /*是否在编辑中*/
    BOOL                  _is_edit;
    /*是否 在拖动 中*/
    BOOL                  _is_draging;
    /*是否 在删除中*/
    BOOL                  _is_deleting;
    /*是否 在单击动画中*/
    BOOL                  _is_single_tap_animation;
    /*是否 在拖动动画中*/
    BOOL                  _is_drag_animation;
    
    /*cell 的数组*/
    NSMutableArray       *_circle_cell_array;
    
    /*当前选择到的cell*/
    NSInteger             _current_index;
    /*是否是顺时针旋转*/
    BOOL                  _is_clockwise;
    
    /*拖拽的的cell*/
    NSInteger             _drag_index;
    /*拖拽的坐标*/
    CGPoint               _drag_point;
    
    
    
    /*基础属性*/
    NSInteger             _number_of_circle_cell; //图标数量
    CGPoint               _center_point;          //中心点
    CGFloat               _radius;                //半径长度
    CGFloat               _deviation_Radian;      //偏移弧度
    CGFloat               _scale;                 //最小的改变
    CGFloat               _normal_scale;          //正常的大小
    CGFloat               _drag_sensitivity;      //拖拽灵敏度
    CGFloat               _average_radina;        //平均弧度
    BOOL                  _is_can_edit;           //是否可编辑
    
    
    
    id<SCHCircleViewDataSource> _circle_view_data_source;
    id<SCHCircleViewDelegate>   _circle_view_delegate;
    
}
@property (nonatomic,assign)   SCHShowCircleStyle          show_circle_style;
@property (nonatomic,assign)   SCHTouchCircleStyle         touch_circle_style;
@property (nonatomic,assign)   SCHCircleLayoutStyle        circle_layout_style;
@property (nonatomic,assign)   SCHCircleInsertStyle        circle_insert_style;
@property (nonatomic,assign)   SCHCircleDeleteStyle        circle_delete_style;

@property (nonatomic,assign)   id<SCHCircleViewDataSource> circle_view_data_source;
@property (nonatomic,assign)   id<SCHCircleViewDelegate>   circle_view_delegate;

@property (nonatomic,readonly) BOOL                        is_edit;

/*重新加载数据*/
- (void)reloadData;
@end
