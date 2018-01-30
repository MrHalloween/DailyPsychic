//
//  SCHCricleViewCell.m
//  SCHCricleView
//
//  Created by 魏巍 on 12-11-10.
//  Copyright (c) 2012年 sch. All rights reserved.
//

#import "SCHCircleViewCell.h"

@interface SCHCircleViewCell(private)


@end

@implementation SCHCircleViewCell
@synthesize delete_button            = _delete_button;

@synthesize view_rect                = _view_rect;
@synthesize scale                    = _scale;
@synthesize view_point               = _view_point;
@synthesize radian                   = _radian;
@synthesize animation_radian         = _animation_radian;

@synthesize current_radian           = _current_radian;
@synthesize current_animation_radian = _current_animation_radian;
@synthesize current_scale            = _current_scale;

@synthesize delegate                 = _delegate;
#pragma mark -
#pragma mark - 初始化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        
    }
    return self;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    if(nil !=  _delete_button)
    {
        
    }
    
    /*增加长点击事件*/
    UILongPressGestureRecognizer *long_press = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pressedLong:)];
    [self addGestureRecognizer:long_press];
    [long_press release],long_press = nil;
    
    /*增加单击事件*/
    UITapGestureRecognizer *single_tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleSingleTap:)] ;
    single_tap.numberOfTapsRequired    = 1;
    single_tap.cancelsTouchesInView    = NO;
    single_tap.numberOfTouchesRequired = 1;
    single_tap.delegate                = self;
    [self addGestureRecognizer: single_tap];
    [single_tap release], single_tap = nil;
    
    /*增加拖动事件*/
    UIPanGestureRecognizer *single_pan = [[UIPanGestureRecognizer alloc] initWithTarget: self action: @selector(handleSinglePan:)] ;
    single_pan.cancelsTouchesInView    = NO;
    single_pan.delegate                = self;
    [self addGestureRecognizer: single_pan];
    [single_pan release], single_pan = nil;
    
}


#pragma mark -
#pragma mark - 长按
- (void) pressedLong:(UILongPressGestureRecognizer *) gestureRecognizer
{
    
    CGPoint point;
    switch (gestureRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:
            point = [gestureRecognizer locationInView:self];
            // [_delegate gridDidEnterMoveMode:self withLocation:point moveGestureRecognizer:gestureRecognizer];
            //放大这个item
            // NSLog(@"press long began");
            break;
        case UIGestureRecognizerStateEnded:
            point = [gestureRecognizer locationInView:self];
            // [_delegate gridDidEndMoved:self withLocation:point moveGestureRecognizer:gestureRecognizer];
            //变回原来大小
            //NSLog(@"press long ended");
            
            break;
        case UIGestureRecognizerStateFailed:
            //NSLog(@"press long failed");
            
            break;
        case UIGestureRecognizerStateCancelled:
            
            point = [gestureRecognizer locationInView:self];
            // [_delegate gridDidEndMoved:self withLocation:point moveGestureRecognizer:gestureRecognizer];
            break;
        case UIGestureRecognizerStateChanged:
            //移动
            point = [gestureRecognizer locationInView:self];
            //   [_delegate gridDidMoved:self withLocation:point moveGestureRecognizer:gestureRecognizer];
            //NSLog(@"press long changed");
            break;
        default:
            //NSLog(@"press long else");
            break;
    }
    
    //CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    
}

#pragma mark -
#pragma mark - 单击
- (void)handleSingleTap:(UITapGestureRecognizer *)gestureRecognizer
{
    
    switch (gestureRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:
            
            [_delegate cellTouchBegin:self];
            break;
        case UIGestureRecognizerStateEnded:
            [_delegate cellTouchEnd:self];
            break;
        case UIGestureRecognizerStateFailed:
            [_delegate cellTouchFailed:self];
            break;
        case UIGestureRecognizerStateCancelled:
            [_delegate cellTouchCancelled:self];
            break;
        case UIGestureRecognizerStateChanged:

            break;
        default:

            break;
    }
    
}

#pragma mark - 
#pragma mark - 拖动
- (void)handleSinglePan:(UIPanGestureRecognizer *)gestureRecognizer
{
    
    CGPoint point;
    switch (gestureRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:
            point = [gestureRecognizer locationInView:self];
            [_delegate cellDidEnterMoveMode:self withLocation:point moveGestureRecognizer:gestureRecognizer];

            break;
        case UIGestureRecognizerStateEnded:
            point = [gestureRecognizer locationInView:self];
            [_delegate cellDidEndMoved:self withLocation:point moveGestureRecognizer:gestureRecognizer];
            
            break;
        case UIGestureRecognizerStateFailed:

            point = [gestureRecognizer locationInView:self];
            [_delegate cellDidFailMoved:self withLocation:point moveGestureRecognizer:gestureRecognizer];
            break;
        case UIGestureRecognizerStateCancelled:
            point = [gestureRecognizer locationInView:self];
            [_delegate cellDidCancelMoved:self withLocation:point moveGestureRecognizer:gestureRecognizer];
            break;
        case UIGestureRecognizerStateChanged:
            //移动
            point = [gestureRecognizer locationInView:self];
            [_delegate cellDidMoved:self withLocation:point moveGestureRecognizer:gestureRecognizer];
            break;
        default:
          
            break;
    }
    
}

#pragma mark -
#pragma mark - dealloc 
- (void)dealloc
{
    [_delete_button release], _delete_button = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 过滤掉UIButton，也可以是其他类型
    if ( [touch.view isKindOfClass:[UIButton class]])
    {
        return NO;
    }
    
    return YES;
}

@end
