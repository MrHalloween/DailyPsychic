//
//  SCHCricleView.m
//  SCHCricleView
//
//  Created by 魏巍 on 12-11-10.
//  Copyright (c) 2012年 sch. All rights reserved.
//

#import "SCHCircleView.h"
#import "SCHAnimationGroup.h"
#import <QuartzCore/QuartzCore.h>

/*单击的属性*/
static int single_animation_count      = 0;
static int repeat_animation_count      = 0;
static int repeat_animation_count_base = 0;

/*拖动的属性*/
static int drag_animation_count        = 0;

@interface SCHCircleView(private)

/*弧度计算公式*/
/*获取自定义弧度*/
- (CGFloat)getRadinaByRadian:(CGFloat)radian;

/*动画弧度计算公式*/
/*通过 自己定义坐标弧度 获取动画坐标弧度*/
- (CGFloat)getAnimationRadianByRadian:(CGFloat)radian;

/*点 计算公式*/
/*通过弧度来计算 (弧度,圆心,半径)*/
- (CGPoint)getPointByRadian:(CGFloat)radian centreOfCircle:(CGPoint)circle_point radiusOfCircle:(CGFloat)circle_radius;

/*比例 计算公式*/
/*通过弧度来计算 (弧度,最小scale,偏移弧度)*/
- (CGFloat)getScaleByRadina:(CGFloat)radian originScale:(CGFloat)origin_scale deviationRadian:(CGFloat)d_radina;

/*自己定义坐标的 计算 atan2f 返回弧度*/
- (CGFloat)schAtan2f:(CGFloat)a theB:(CGFloat)b;

/*初始化属性*/
- (void)initAttribute;

/*reload*/
/*清除*/
- (void)clean;
/*加载*/
- (void)load;
/*显示*/
- (void)show;


/*显示的效果 SCHShowCircleStyle*/
- (void)showCircleDefault:(NSMutableArray *)array;
- (void)showCircleDiffuse:(NSMutableArray *)array;
- (void)showCircleWinding:(NSMutableArray *)array;

/*单击的移动动画*/
/*是否顺时针转动*/
- (BOOL)oldIndex:(NSInteger)old_index newIndex:(NSInteger)new_index;
/*判断移动的跨度*/
- (NSInteger)getNumberOldIndex:(NSInteger)old_index newIndex:(NSInteger)new_index;

- (void)animateWithDuration:(CGFloat)time animateDelay:(CGFloat)delay changeIndex:(NSInteger)change_index toIndex:(NSInteger)to_index circleArray:(NSMutableArray*)array clockwise:(BOOL)is_clockwise;

- (void)singletTapCircleDefault:(NSMutableArray *)array touchCell:(SCHCircleViewCell *)cell touchIndex:(NSInteger)touch_index;

- (void)singleTapCircleDelayRoll:(NSMutableArray *)array touchCell:(SCHCircleViewCell *)cell touchIndex:(NSInteger)touch_index;

- (void)singleTapCircleNoRoll:(NSMutableArray *)array touchCell:(SCHCircleViewCell *)cell touchIndex:(NSInteger)touch_index;


/*拖动移动的动画*/
- (void)dragPoint:(CGPoint)drag_point movePoint:(CGPoint)move_point circleCenterPoint:(CGPoint)circle_center_point;

/*修正位置*/
- (void)reviseCirclePoint;

@end


@implementation SCHCircleView

@synthesize show_circle_style       = _show_circle_style;
@synthesize touch_circle_style      = _touch_circle_style;
@synthesize circle_layout_style     = _circle_layout_style;
@synthesize circle_insert_style     = _circle_insert_style;
@synthesize circle_delete_style     = _circle_delete_style;

@synthesize circle_view_data_source = _circle_view_data_source;
@synthesize circle_view_delegate    = _circle_view_delegate;

@synthesize is_edit                 = _is_edit;

#pragma mark -
#pragma mark - 点击移动的动画

- (BOOL)oldIndex:(NSInteger)old_index newIndex:(NSInteger)new_index
{
    NSInteger o_index    = old_index;
    NSInteger n_index    = new_index;
    
    NSInteger half_value = _number_of_circle_cell / 2;
    
    /*是否顺时针转动*/
    BOOL is_clockwise;
    
    if(n_index > o_index)
    {
        if((n_index - o_index) <= half_value)
        {
            is_clockwise = YES;
            
        }
        else
        {
            is_clockwise = NO;
        }
    }
    else
    {
        if(1 == _number_of_circle_cell % 2)
        {
            if((o_index - n_index) <= half_value)
            {
                is_clockwise = NO;
            }
            else
            {
                is_clockwise = YES;
            }
        }
        else
        {
            if((o_index - n_index) < half_value)
            {
                is_clockwise = NO;
            }
            else
            {
                is_clockwise = YES;
            }
        }
    }
    
    
    return is_clockwise;
    
}

- (NSInteger)getNumberOldIndex:(NSInteger)old_index newIndex:(NSInteger)new_index
{
    NSInteger o_index    = old_index;
    NSInteger n_index    = new_index;
    
    NSInteger half_value = _number_of_circle_cell / 2;
    
    /*是否顺时针转动*/
    NSInteger number;
    
    if(n_index > o_index)
    {
        if((n_index - o_index) <= half_value)
        {
            number = n_index - o_index;
            
        }
        else
        {
            number = _number_of_circle_cell + o_index - n_index;
        }
    }
    else
    {
        if(1 == _number_of_circle_cell % 2)
        {
            if((o_index - n_index) <= half_value)
            {
                number = o_index - n_index;
            }
            else
            {
                number = _number_of_circle_cell + n_index - o_index;
            }
        }
        else
        {
            if((o_index - n_index) < half_value)
            {
                number = o_index - n_index;
            }
            else
            {
                number = _number_of_circle_cell + n_index - o_index;
            }
        }
    }
    
    
    return number;
}

- (CGFloat)schAtan2f:(CGFloat)a theB:(CGFloat)b
{
    CGFloat rd = atan2f(a,b);
    
    if(rd < 0.0f)
        rd = M_PI * 2 + rd;
        
    return rd;
}

#pragma mark -
#pragma mark - 动画
- (void)animateWithDuration:(CGFloat)time animateDelay:(CGFloat)delay changeIndex:(NSInteger)change_index toIndex:(NSInteger)to_index circleArray:(NSMutableArray *)array clockwise:(BOOL)is_clockwise
{
   
    SCHCircleViewCell *change_cell = [array objectAtIndex:change_index];
    SCHCircleViewCell *to_cell     = [array objectAtIndex:to_index];
    
    /*圆*/
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:[NSString stringWithFormat:@"position"]];
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path, NULL,change_cell.layer.position.x,change_cell.layer.position.y);
    
    int clockwise = is_clockwise?0:1;
    
	CGPathAddArc(path,nil,
                 _center_point.x, _center_point.y, /*圆心*/
                 _radius,                          /*半径*/
                 change_cell.current_animation_radian, to_cell.animation_radian, /*弧度改变*/
                 clockwise
                 );
    
	animation.path = path;
	CGPathRelease(path);
    animation.fillMode            = kCAFillModeForwards;
	animation.repeatCount         = 1;
    animation.removedOnCompletion = NO;
 	animation.calculationMode     = @"paced";

    
   /*缩放*/

    CABasicAnimation *scale_anim   = [CABasicAnimation animationWithKeyPath:@"transform"];
    scale_anim.fromValue           = [NSValue valueWithCATransform3D:CATransform3DMakeScale(change_cell.current_scale, change_cell.current_scale,1.0f)];

    
    scale_anim.toValue             = [NSValue valueWithCATransform3D:CATransform3DMakeScale(to_cell.scale, to_cell.scale, 1.0)];
    scale_anim.fillMode            = kCAFillModeForwards;
    scale_anim.removedOnCompletion = NO;
    
    /*动画组合*/
    SCHAnimationGroup *anim_group  = [SCHAnimationGroup animation];
    anim_group.animations          = [NSArray arrayWithObjects:animation, scale_anim, nil];
    anim_group.duration            = time + delay;
    anim_group.delegate            = self;
    anim_group.fillMode            = kCAFillModeForwards;
    anim_group.removedOnCompletion = NO;
    
    anim_group.animation_tag       = change_index;

    
    [change_cell.layer addAnimation:anim_group forKey:[NSString stringWithFormat:@"anim_group_%d",change_index]];


    /*改变属性*/
    change_cell.current_animation_radian = to_cell.animation_radian;
    change_cell.current_scale            = to_cell.scale;
    change_cell.current_radian           = to_cell.radian;
}

- (void)singletTapCircleDefault:(NSMutableArray *)array touchCell:(SCHCircleViewCell *)cell touchIndex:(NSInteger)touch_index
{
    /*点击的 最前展示的*/
    if(touch_index == _current_index)
    {
        if([_circle_view_delegate respondsToSelector:@selector(touchEndCircleViewCell:indexOfCircleViewCell:)])
        {
            [_circle_view_delegate touchEndCircleViewCell:cell indexOfCircleViewCell:_current_index];
        }
        return;
    }
    
    /*开始单击动画*/
    _is_single_tap_animation    = YES;
    
    /*是否是顺时针*/
    _is_clockwise               = [self oldIndex:_current_index newIndex:touch_index];
    /*跨度*/
    NSInteger number            = [self getNumberOldIndex:_current_index newIndex:touch_index];
 
   
    /*动画循环的次数*/
    repeat_animation_count      = number;
    repeat_animation_count_base = number;
 
    _current_index              = touch_index;
    
    --repeat_animation_count;
    
    for (int i = 0; i < array.count; ++i)
    {
        ++single_animation_count;
        
        /*顺时针*/
        if(_is_clockwise)
        {
            NSInteger to_index = (repeat_animation_count + i) % array.count;
            
            [self animateWithDuration:0.25f  animateDelay:0.0f changeIndex:(_current_index + i)%array.count toIndex:to_index circleArray:array clockwise:_is_clockwise];
        }
        /*逆时针*/
        else
        {
            NSInteger to_index = (array.count - repeat_animation_count + i) % array.count;
            
            [self animateWithDuration:0.25f  animateDelay:0.0f changeIndex:(_current_index + i)%array.count toIndex:to_index circleArray:array clockwise:_is_clockwise];
        }

    }
    
    
}

/*未完成*/
- (void)singleTapCircleDelayRoll:(NSMutableArray *)array touchCell:(SCHCircleViewCell *)cell touchIndex:(NSInteger)touch_index
{
    /*点击的 最前展示的*/
    if(touch_index == _current_index)
    {
        if([_circle_view_delegate respondsToSelector:@selector(touchEndCircleViewCell:indexOfCircleViewCell:)])
        {
            [_circle_view_delegate touchEndCircleViewCell:cell indexOfCircleViewCell:_current_index];
        }
        return;
    }
    
}
- (void)singleTapCircleNoRoll:(NSMutableArray *)array touchCell:(SCHCircleViewCell *)cell touchIndex:(NSInteger)touch_index
{
    NSLog(@"ggg%ld",(long)touch_index);
    if([_circle_view_delegate respondsToSelector:@selector(touchEndCircleViewCell:indexOfCircleViewCell:)])
    {
        [_circle_view_delegate touchEndCircleViewCell:cell indexOfCircleViewCell:touch_index];
    }
}

#pragma mark - 
#pragma mark - 拖动动画

- (void)dragPoint:(CGPoint)drag_point movePoint:(CGPoint)move_point circleCenterPoint:(CGPoint)circle_center_point
{
    /*转换弧度*/
    
    CGFloat drag_radian   = [self schAtan2f:drag_point.x - circle_center_point.x theB:drag_point.y - circle_center_point.y];
    
    CGFloat move_radian   = [self schAtan2f:move_point.x - circle_center_point.x theB:move_point.y - circle_center_point.y];
    
    CGFloat change_radian = (move_radian - drag_radian) * _drag_sensitivity;
    
    /*改变位置*/
    for (int i = 0; i < _circle_cell_array.count; ++i)
    {

        SCHCircleViewCell *cell       = [_circle_cell_array objectAtIndex:i];
        cell.current_radian           = [self getRadinaByRadian:cell.current_radian + change_radian];
        
        cell.current_animation_radian = [self getAnimationRadianByRadian:cell.current_radian];;
        cell.current_scale            = [self getScaleByRadina:cell.current_radian originScale:_scale deviationRadian:_deviation_Radian];
        
       
        cell.transform                = CGAffineTransformMakeScale(cell.current_scale, cell.current_scale);
        cell.center                   = [self getPointByRadian:cell.current_radian centreOfCircle:_center_point radiusOfCircle:_radius];

    }
    
}

- (void)reviseCirclePoint
{
    SCHCircleViewCell *cell = [_circle_cell_array objectAtIndex:0];
    
    CGFloat   temp_value  = [self getRadinaByRadian:(cell.current_radian - _deviation_Radian)] / _average_radina;
    NSInteger temp_number = (NSInteger)(floorf(temp_value));
    
    temp_value            = temp_value - floorf(temp_value);
    
      /*顺时针移动*/
    if((temp_value / _average_radina) < 0.5f)
    {
       
        _is_clockwise  = YES;
        _current_index = _circle_cell_array.count - temp_number;
    }
    /*逆时针移动*/
    else
    {
  
        _is_clockwise  = NO;
        _current_index = (_circle_cell_array.count - ++temp_number)% _circle_cell_array.count;
    }
    
    /*动画*/
    _is_drag_animation = YES;

    for (int i = 0; i < _circle_cell_array.count; ++i)
    {
        ++drag_animation_count;
        
        [self animateWithDuration:0.25f * (temp_value / _average_radina)  animateDelay:0.0f changeIndex:(_current_index + i)%_circle_cell_array.count toIndex:i circleArray:_circle_cell_array clockwise:_is_clockwise];
    }
    
    
}



#pragma mark -
#pragma mark - 显示效果
- (void)showCircleDefault:(NSMutableArray *)array
{
    for (UIView *cell in array)
    {
        [self addSubview:cell];
    }
}

- (void)showCircleDiffuse:(NSMutableArray *)array
{
    for (UIView *cell in array)
    {
        cell.center = _center_point;
        [self addSubview:cell];
    }
    [UIView animateWithDuration:0.25f
                     animations:^{
                         for (SCHCircleViewCell *cell in array)
                         {
                             cell.center = cell.view_point;
                         }
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)showCircleWinding:(NSMutableArray *)array
{
    
    for (UIView *cell in array)
    {
        cell.center = _center_point;
        [self addSubview:cell];
    }
    
    
    for (int i = 0; i < _circle_cell_array.count; ++i)
    {
        SCHCircleViewCell *cell = [_circle_cell_array objectAtIndex:i];
        
        [UIView animateWithDuration:0.25f
                              delay:0.04 * i
                            options:UIViewAnimationCurveLinear
                         animations:^{
                             cell.center = cell.view_point;
                             
                         } completion:^(BOOL finished) {
                             
                         }];
    }
}

#pragma mark -
#pragma mark - 弧度， 点 ， 改变比例的计算公式

- (CGFloat)getRadinaByRadian:(CGFloat)radian
{
    if(radian > 2 * M_PI)
        return (radian - floorf(radian / (2.0f * M_PI)) * 2.0f * M_PI);
    
    if(radian < 0.0f)
        return (2.0f * M_PI + radian - ceilf(radian / (2.0f * M_PI)) * 2.0f * M_PI);
    
    
    return radian;
}

- (CGFloat)getAnimationRadianByRadian:(CGFloat)radian
{
    CGFloat an_r = 2.0f * M_PI -  radian + M_PI_2;
    
    if(an_r < 0.0f)
        an_r =  - an_r;
    
    return an_r;
}

- (CGPoint)getPointByRadian:(CGFloat)radian centreOfCircle:(CGPoint)circle_point radiusOfCircle:(CGFloat)circle_radius
{
    CGFloat c_x = sinf(radian) * circle_radius + circle_point.x;
    CGFloat c_y = cosf(radian) * circle_radius + circle_point.y;
    
    return CGPointMake(c_x, c_y);
}


- (CGFloat)getScaleByRadina:(CGFloat)radian originScale:(CGFloat)origin_scale deviationRadian:(CGFloat)d_radina
{

    /*如果比例不变*/
    if(1.0f == origin_scale)
        return 1.0f;
    
    
    /*比例改变的时候*/
    CGFloat change_radin;
    
    (radian <= M_PI)?(change_radin = fabsf(radian - d_radina)):(change_radin = fabsf(2 * M_PI - radian - d_radina));
 
    CGFloat change_scale = 1.0f - (1.0f - origin_scale) * (change_radin /  M_PI);
  //  NSLog(@"%f",change_scale);
    return change_scale;
    
}

#pragma mark -
#pragma mark - 初始化属性

- (void)initAttribute
{
    _show_circle_style       = SCHShowCircleDefault;
    
    _touch_circle_style      = SCHTouchCircleDefault;
    
    _circle_layout_style     = SCHCircleLayoutDefault;
    
    _circle_insert_style     = SCHCircleInsertDefault;
    
    _circle_delete_style     = SCHCircleDeleteDefault;
    
    _current_index           = 0;
    _normal_scale            = 1.0f;
    
    _circle_cell_array       = [[NSMutableArray alloc] init];
    
    _is_deleting             = NO;
    _is_draging              = NO;
    _is_edit                 = NO;
    _is_single_tap_animation = NO;
    
}

#pragma mark -
#pragma mark - 重新加载 reload

- (void)clean
{
    
    if(_circle_cell_array.count <= 0)
        return;
    
    for (UIView *cell in _circle_cell_array)
    {
        [cell removeFromSuperview];
    }
    
    [_circle_cell_array removeAllObjects];
}

- (void)load
{
    /*图标数量*/
    if([_circle_view_data_source respondsToSelector:@selector(numberOfCellInCircleView:)])
    {
        _number_of_circle_cell = [_circle_view_data_source numberOfCellInCircleView:self];
    }
    else
    {
        NSLog(@"必须实现(numberOfCellInCricleView:)的方法");
        return;
    }
    
    /*中心点*/
    if ([_circle_view_data_source respondsToSelector:@selector(centerOfCircleView:)])
    {
        _center_point = [_circle_view_data_source centerOfCircleView:self];
    }
    else
    {
        _center_point = CENTER_POINT;
    }
    
    /*半径长度*/
    if([_circle_view_data_source respondsToSelector:@selector(radiusOfCircleView:)])
    {
        _radius = [_circle_view_data_source radiusOfCircleView:self];
    }
    else
    {
        _radius = RADIUS;
    }
    
    /*偏移弧度*/
    if ([_circle_view_data_source respondsToSelector:@selector(deviationRadianOfCircleView:)])
    {
        _deviation_Radian = [_circle_view_data_source deviationRadianOfCircleView:self];
    }
    else
    {
        _deviation_Radian = DEVIATION_RAIAN;
    }
    
    /*最后一个或者最后2个的比例改变量*/
    if([_circle_view_data_source respondsToSelector:@selector(scaleOfCircleViewCell:)])
    {
        _scale = [_circle_view_data_source scaleOfCircleViewCell:self];
    }
    else
    {
        _scale =  SCAlE;
    }
    
    /*拖拽的灵敏度*/
    if([_circle_view_data_source respondsToSelector:@selector(dragSensitivityOfCircleViewCell:)])
    {
        _drag_sensitivity = [_circle_view_data_source dragSensitivityOfCircleViewCell:self];
    }
    else
    {
        _drag_sensitivity = DRAG_SENSITIVITY;
    }
    
    /*是否可编辑*/
    if ([_circle_view_data_source respondsToSelector:@selector(circleViewCanEdit:)])
    {
        _is_can_edit = [_circle_view_data_source circleViewCanEdit:self];
    }
    else
    {
        _is_can_edit = IS_CAN_EDIT;
    }
    
    
    /*各个cell*/
    if(_number_of_circle_cell > 0)
    {
        if(![_circle_view_data_source respondsToSelector:@selector(circleView:cellAtIndex:)])
        {
            NSLog(@"必须实现(cricleView:cellAtIndex:)的方法");
            return;
        }
        _current_index = 0;
        
        /*切分弧度 的平局弧度*/
        _average_radina = 2 * M_PI / ((CGFloat)_number_of_circle_cell);
        
        for (int i = 0; i < _number_of_circle_cell; ++i)
        {
            
            /*cell 的弧度*/
            CGFloat           cell_radina = [self getRadinaByRadian:(i * _average_radina + _deviation_Radian)];
            
            /*cell*/
            SCHCircleViewCell *cell       = [_circle_view_data_source circleView:self cellAtIndex:i];
            if (i==0) {
                cell.scale = 1.2;
            }else{
                cell.scale                    = [self getScaleByRadina:cell_radina originScale:_scale deviationRadian:_deviation_Radian];
            }
            
            cell.view_point               = [self getPointByRadian:cell_radina centreOfCircle:_center_point radiusOfCircle:_radius];
            cell.radian                   = cell_radina;
            cell.animation_radian         = [self getAnimationRadianByRadian:cell_radina];
            
            cell.current_radian           = cell.radian;
            cell.current_animation_radian = cell.animation_radian;
            cell.current_scale            = cell.scale;

            cell.transform                = CGAffineTransformMakeScale(cell.scale, cell.scale);
            cell.center                   = cell.view_point;
            
            cell.delegate                 = self;
            
            [_circle_cell_array addObject:cell];
            
    
        }
    }    
}

- (void)show
{
    if(_circle_cell_array.count <= 0)
        return;
    
    switch (_show_circle_style)
    {
        case SCHShowCircleDefault:
            [self showCircleDefault:_circle_cell_array];
            break;
            
        case SCHShowCircleDiffuse:
            [self showCircleDiffuse:_circle_cell_array];
            break;
            
        case SChShowCircleWinding:
            [self showCircleWinding:_circle_cell_array];
            break;
            
        default:
            [self showCircleDiffuse:_circle_cell_array];
            break;
    }
    
}


- (void)reloadData
{
    [self clean];
    
    [self load];
    
    [self show];
}


#pragma mark -
#pragma mark - 初始化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initAttribute];
    }
    return self;
}

/*xib*/
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initAttribute];
}


#pragma mark -
#pragma mark - SCHCircleViewCellDelegate
/*单击*/
- (void)cellTouchBegin:(SCHCircleViewCell *)cell
{
    if(_is_single_tap_animation || _is_drag_animation)
        return;
    
    if([_circle_view_delegate respondsToSelector:@selector(touchBeginCircleViewCell:indexOfCircleViewCell:)])
    {
        NSInteger index = [_circle_cell_array indexOfObject:cell];
        
        [_circle_view_delegate touchBeginCircleViewCell:cell indexOfCircleViewCell:index];
    }
}

- (void)cellTouchEnd:(SCHCircleViewCell *)cell
{
    if(_is_single_tap_animation || _is_drag_animation)
        return;
    
    NSInteger index = [_circle_cell_array indexOfObject:cell];

    /*旋转的方式*/
    switch (_touch_circle_style)
    {
        case SCHTouchCircleDefault:
            [self singletTapCircleDefault:_circle_cell_array touchCell:cell touchIndex:index];
            break;
            
        case SCHTouchCricleDelayRoll:
            [self singleTapCircleDelayRoll:_circle_cell_array touchCell:cell touchIndex:index];
            break;
            
        case SCHTouchCircleNoRoll:
            [self singleTapCircleNoRoll:_circle_cell_array touchCell:cell touchIndex:index];
            break;
            
        default:
            [self singletTapCircleDefault:_circle_cell_array touchCell:cell touchIndex:index];
            break;
    }

}

- (void)cellTouchCancelled:(SCHCircleViewCell *)cell
{
    if(_is_single_tap_animation || _is_drag_animation)
        return;
 
    if([_circle_view_delegate respondsToSelector:@selector(touchCancelCircleViewCell:indexOfCircleViewCell:)])
    {
        NSInteger index = [_circle_cell_array indexOfObject:cell];
        
        [_circle_view_delegate touchCancelCircleViewCell:cell indexOfCircleViewCell:index];
    }
}

- (void)cellTouchFailed:(SCHCircleViewCell *)cell
{
    if(_is_single_tap_animation || _is_drag_animation)
        return;

    if([_circle_view_delegate respondsToSelector:@selector(touchFailCircleViewCell:indexOfCircleViewCell:)])
    {
        NSInteger index = [_circle_cell_array indexOfObject:cell];
        
        [_circle_view_delegate touchFailCircleViewCell:cell indexOfCircleViewCell:index];
    }
    
}

/*移动*/

- (void)cellDidEnterMoveMode:(SCHCircleViewCell *)cell withLocation:(CGPoint)point moveGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer
{

    if(_is_single_tap_animation || _is_drag_animation)
        return;
    

    _is_draging = YES;
    
    /*拖动的点*/
    _drag_point = [gestureRecognizer locationInView:self];
    

    if([_circle_view_delegate respondsToSelector:@selector(dragBeginCircleViewCell:indexOfCircleViewCell:)])
    {
        NSInteger index = [_circle_cell_array indexOfObject:cell];
        
        [_circle_view_delegate dragBeginCircleViewCell:cell indexOfCircleViewCell:index];
    }
    
}

- (void)cellDidMoved:(SCHCircleViewCell *)cell withLocation:(CGPoint)point moveGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer
{
    if(_is_single_tap_animation || _is_drag_animation)
        return;
    
    CGPoint move_point = [gestureRecognizer locationInView:self];
    
    /*拖动*/
    [self dragPoint:_drag_point movePoint:move_point circleCenterPoint:_center_point];
    
    _drag_point = move_point;
    
    if([_circle_view_delegate respondsToSelector:@selector(dragingCircleViewCell:indexOfCircleViewCell:)])
    {
        NSInteger index = [_circle_cell_array indexOfObject:cell];
        
        [_circle_view_delegate dragingCircleViewCell:cell indexOfCircleViewCell:index];
    }
}

- (void)cellDidEndMoved:(SCHCircleViewCell *)cell withLocation:(CGPoint)point moveGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer
{

    
    if(_is_single_tap_animation || _is_drag_animation)
        return;
    
    CGPoint move_point = [gestureRecognizer locationInView:self];
    
    /*拖动*/
    [self dragPoint:_drag_point movePoint:move_point circleCenterPoint:_center_point];
    

    /*修正圆*/
    [self reviseCirclePoint];
    
    if([_circle_view_delegate respondsToSelector:@selector(dragEndCircleViewCell:indexOfCircleViewCell:)])
    {
        NSInteger index = [_circle_cell_array indexOfObject:cell];
        
        [_circle_view_delegate dragEndCircleViewCell:cell indexOfCircleViewCell:index];
    }
}

- (void)cellDidCancelMoved:(SCHCircleViewCell *)cell withLocation:(CGPoint)point moveGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer
{
    

    if(_is_single_tap_animation || _is_drag_animation)
        return;
    
    CGPoint move_point = [gestureRecognizer locationInView:self];
    
    /*拖动*/
    [self dragPoint:_drag_point movePoint:move_point circleCenterPoint:_center_point];
    

    /*修正圆*/
    [self reviseCirclePoint];
    
    if([_circle_view_delegate respondsToSelector:@selector(dragCancelCircleViewCell:indexOfCircleViewCell:)])
    {
        NSInteger index = [_circle_cell_array indexOfObject:cell];
        
        [_circle_view_delegate dragCancelCircleViewCell:cell indexOfCircleViewCell:index];
    }
}

- (void)cellDidFailMoved:(SCHCircleViewCell *)cell withLocation:(CGPoint)point moveGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer
{
    if(_is_single_tap_animation || _is_drag_animation)
        return;
    
    CGPoint move_point = [gestureRecognizer locationInView:self];
    
    /*拖动*/
    [self dragPoint:_drag_point movePoint:move_point circleCenterPoint:_center_point];
    

    /*修正圆*/
    [self reviseCirclePoint];
    
    if([_circle_view_delegate respondsToSelector:@selector(dragFailCircleViewCell:indexOfCircleViewCell:)])
    {
        NSInteger index = [_circle_cell_array indexOfObject:cell];
        
        [_circle_view_delegate dragFailCircleViewCell:cell indexOfCircleViewCell:index];
    }
}


/*长按*/

#pragma mark -
#pragma mark - animation delegate 

- (void)animationDidStart:(CAAnimation *)anim
{
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    /*单击动画 继续*/
    if(0 != repeat_animation_count)
    {
         --single_animation_count;
         
        if(0 == single_animation_count)
        {
            /*改变位置*/
            for (int i = 0; i < _circle_cell_array.count; ++i)
            {
                SCHCircleViewCell *change_cell = [_circle_cell_array objectAtIndex:(_current_index + i)%_circle_cell_array.count];
                
                NSInteger to_index = 0;
                
                if(_is_clockwise)
                {
                    to_index = (repeat_animation_count + i) % _circle_cell_array.count;
                }
                else
                {
                    to_index = (_circle_cell_array.count- repeat_animation_count + i) % _circle_cell_array.count;
                    
                }
                
                SCHCircleViewCell *to_cell     = [_circle_cell_array objectAtIndex:to_index];
                
                [change_cell.layer removeAllAnimations];
                change_cell.center    = to_cell.view_point;
                change_cell.transform = CGAffineTransformMakeScale(to_cell.scale, to_cell.scale);
                
                
            }
            
            /*再进行动画*/
            --repeat_animation_count;
            
            for (int i = 0; i < _circle_cell_array.count; ++i)
            {
                ++single_animation_count;
                /*顺时针*/
                if(_is_clockwise)
                {
                    NSInteger to_index = (repeat_animation_count + i) % _circle_cell_array.count;
                    
                    [self animateWithDuration:0.25f  animateDelay:0.0f changeIndex:(_current_index + i) % _circle_cell_array.count toIndex:to_index circleArray:_circle_cell_array clockwise:_is_clockwise];
                }
                /*逆时针*/
                else
                {
                    NSInteger to_index = (_circle_cell_array.count - repeat_animation_count + i) % _circle_cell_array.count;
                    
                    [self animateWithDuration:0.25f  animateDelay:0.0f changeIndex:(_current_index + i) % _circle_cell_array.count toIndex:to_index circleArray:_circle_cell_array clockwise:_is_clockwise];
                }
                
            }
        }
        
        return;
    }
    
    /*单击动画 结束*/
    if(_is_single_tap_animation)
    {
        --single_animation_count;
        
        if(0 == single_animation_count)
        {
            for (int i = 0; i < _circle_cell_array.count; ++i)
            {
                SCHCircleViewCell *change_cell = [_circle_cell_array objectAtIndex:(_current_index + i)%_circle_cell_array.count];
                
                SCHCircleViewCell *to_cell     = [_circle_cell_array objectAtIndex:i];
                
                [change_cell.layer removeAllAnimations];
                change_cell.center    = to_cell.view_point;
                change_cell.transform = CGAffineTransformMakeScale(to_cell.scale, to_cell.scale);
            }
            
            _is_single_tap_animation = NO;
        }
    }
    
    
    /*拖动动画结束*/
    if(_is_drag_animation)
    {
        --drag_animation_count;
        
        if(0 == drag_animation_count)
        {
            for (int i = 0; i < _circle_cell_array.count; ++i)
            {
                SCHCircleViewCell *change_cell = [_circle_cell_array objectAtIndex:(_current_index + i)%_circle_cell_array.count];
                
                SCHCircleViewCell *to_cell     = [_circle_cell_array objectAtIndex:i];
                
                [change_cell.layer removeAllAnimations];
                
                change_cell.center    = to_cell.view_point;
                change_cell.transform = CGAffineTransformMakeScale(to_cell.scale, to_cell.scale);
            }
            
            _is_drag_animation = NO;
            _is_draging        = NO;
         
        }
    }
}

#pragma mark -
#pragma mark - dealloc

- (void)dealloc
{
    [super dealloc];
    
    [_circle_cell_array release], _circle_cell_array = nil;
}

@end
