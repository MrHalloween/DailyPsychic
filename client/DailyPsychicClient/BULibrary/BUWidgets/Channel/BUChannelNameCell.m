//
//  BUChannelNameCell.m
//  pbuSymbolTechPaiPaiJing
//
//  Created by Xue Yan on 15/8/9.
//  Copyright (c) 2015年 周杰. All rights reserved.
//

#import "BUChannelNameCell.h"

@implementation BUChannelNameCell

@synthesize propHighlightColor;
@synthesize propHighlightImage;
@synthesize propNormalColor;
@synthesize propNormalImage;
@synthesize propTitle;
@synthesize propImageView;
@synthesize propLabel;

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    m_pImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:m_pImageView];
    
    m_pLabel = [[UILabel alloc] initWithFrame:self.bounds];
    [self addSubview:m_pLabel];
    m_pLabel.backgroundColor = [UIColor clearColor];
    m_pLabel.textAlignment = NSTextAlignmentCenter;
    
    self.userInteractionEnabled = NO;
    return self;
}

#pragma mark - public methods

-(void)SetToHightlight
{
    m_pImageView.image = self.propHighlightImage;
    m_pLabel.text = self.propTitle;
    m_pLabel.textColor = self.propHighlightColor;
}

-(void)SetToNormal
{
    m_pImageView.image = propNormalImage;
    m_pLabel.text = self.propTitle;
    m_pLabel.textColor = self.propNormalColor;
}

@end
