//
//  AFButton.m
//  TabBarController
//
//  Created by 李鑫浩 on 16/6/1.
//  Copyright © 2016年 李鑫浩. All rights reserved.
//

#import "AFTabBarItem.h"

@implementation AFTabBarItem

- (id)init
{
    if ([super init])
    {
        m_pBadge = [[UILabel alloc]init];
        m_pBadge.backgroundColor = [UIColor redColor];
        m_pBadge.textColor = [UIColor whiteColor];
        m_pBadge.font = [UIFont systemFontOfSize:10.0f];
        m_pBadge.textAlignment = NSTextAlignmentCenter;
        m_pBadge.hidden = YES;
        [self addSubview:m_pBadge];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat w = contentRect.size.width;
    if (self.fHeightScale == 1.0f){
        return CGRectMake(0, 0, w, contentRect.size.height);
    } else {
        return CGRectMake(0, 12, w, (contentRect.size.height - 12) * self.fHeightScale);
    }
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat w = contentRect.size.width;
    CGFloat h = (contentRect.size.height - 12) * (1 - self.fHeightScale);
    CGFloat y = contentRect.size.height - h;
    return CGRectMake(0, y, w, h);
}

- (void)SetBadgeNum:(NSInteger)argNum withType:(AFBadgeShowType)argType
{
    if (argNum <= 0)
    {
        m_pBadge.hidden = YES;
        return;
    }
    if (argType == AFBadgeShowTypeNum)
    {
        if (argNum > 99)
        {
            m_pBadge.frame = CGRectMake(0, 0, 25, 15);
            m_pBadge.text = @"99+";
        }
        else
        {
            m_pBadge.frame = CGRectMake(0, 0, 15, 15);
            m_pBadge.text = [NSString stringWithFormat:@"%i",(int)argNum];
        }
    }
    else
    {
        m_pBadge.frame = CGRectMake(0, 0, 8.0f, 8.0f);
        m_pBadge.text = @"";
    }
    m_pBadge.hidden = NO;
    m_pBadge.layer.cornerRadius = m_pBadge.frame.size.height / 2.0f;
    m_pBadge.layer.masksToBounds = YES;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;

    m_pBadge.center = CGPointMake(self.frame.size.width / 2.0 + self.frame.size.height / 4.0f, self.frame.size.height / 4.0f);
}

@end
