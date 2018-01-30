//
//  SCHCricleViewCell.h
//  SCHCricleView
//
//  Created by 魏巍 on 12-11-8.
//  Copyright (c) 2012年 sch. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCHCircleViewCell;

@protocol SCHCircleViewCellDelegate <NSObject>

/*单击*/
- (void)cellTouchBegin:(SCHCircleViewCell *)cell;

- (void)cellTouchEnd:(SCHCircleViewCell *)cell;

- (void)cellTouchFailed:(SCHCircleViewCell *)cell;

- (void)cellTouchCancelled:(SCHCircleViewCell *)cell;


/*移动*/
- (void)cellDidEnterMoveMode:(SCHCircleViewCell *)cell withLocation:(CGPoint) point moveGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer;  /*进入移动状态*/

- (void)cellDidEndMoved:(SCHCircleViewCell *)cell withLocation:(CGPoint) point moveGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer;  /*结束移动*/

- (void)cellDidFailMoved:(SCHCircleViewCell *)cell withLocation:(CGPoint) point moveGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer;  /*移动失败*/

- (void)cellDidCancelMoved:(SCHCircleViewCell *)cell withLocation:(CGPoint) point moveGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer;  /*移动取消*/

- (void)cellDidMoved:(SCHCircleViewCell *)cell withLocation:(CGPoint) point moveGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer;    /*移动中*/

/*长按*/

/*删除*/
- (void)deleteCricleCell:(SCHCircleViewCell *)cell;

@end

@interface SCHCircleViewCell : UIView<UIGestureRecognizerDelegate>
{
    
    /*删除按键*/
    UIButton                       *_delete_button;
    
    id<SCHCircleViewCellDelegate>   _delegate;
    
    /*自身view的大小*/
    CGRect                          _view_rect;
    /*大小改变比例*/
    CGFloat                         _scale;
    /*中心点*/
    CGPoint                         _view_point;
    /*自己定义坐标的 弧度*/
    CGFloat                         _radian;
    /*动画坐标的 弧度*/
    CGFloat                         _animation_radian;
    
    
    /*当前的 自己定义坐标的 弧度*/
    CGFloat                         _current_radian;
    /*当前的动画 弧度*/
    CGFloat                         _current_animation_radian;
    /*当前的比例*/
    CGFloat                         _current_scale;
}
@property (nonatomic,retain) IBOutlet UIButton                      *delete_button;

@property (nonatomic,assign)          CGRect                         view_rect;
@property (nonatomic,assign)          CGFloat                        scale;
@property (nonatomic,assign)          CGPoint                        view_point;
@property (nonatomic,assign)          CGFloat                        radian;
@property (nonatomic,assign)          CGFloat                        animation_radian;

@property (nonatomic,assign)          CGFloat                        current_radian;
@property (nonatomic,assign)          CGFloat                        current_animation_radian;
@property (nonatomic,assign)          CGFloat                        current_scale;

@property (nonatomic,assign)          id<SCHCircleViewCellDelegate>  delegate;

@end
