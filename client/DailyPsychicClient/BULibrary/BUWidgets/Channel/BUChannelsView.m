//
//  BUChannelsView.m
//  pbuSymbolTechPaiPaiJing
//
//  Created by Xue Yan on 15/8/9.
//  Copyright (c) 2015年 周杰. All rights reserved.
//

#import "BUChannelsView.h"

@implementation BUChannelsView

@synthesize propChannelNameViewStartPos;
@synthesize propChannelNameViewWidth;
@synthesize propChannelBar = m_pChannelBar;
@synthesize propScrollView = m_pScrollView;

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    m_pChannelBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.height, 50)];
    [self addSubview:m_pChannelBar];
    
    m_pChannelIndicator = [[UIView alloc] initWithFrame:CGRectMake(0, m_pChannelBar.frame.size.height-2, 80, 2)];
    [m_pChannelBar addSubview:m_pChannelIndicator];
    m_pChannelIndicator.backgroundColor = [UIColor colorWithWhite:200/255.0 alpha:1];
    
    m_pScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, m_pChannelBar.frame.size.height, self.bounds.size.width, self.bounds.size.height-m_pChannelBar.frame.size.height)];
    [self addSubview:m_pScrollView];
    m_pScrollView.delegate = self;
    m_pScrollView.pagingEnabled = YES;
    m_pScrollView.showsHorizontalScrollIndicator = NO;
    
    self.propChannelNameViewWidth = 80;
    self.propChannelNameViewStartPos = 0;
    m_iPageCount = 0;
    m_iPage = 0;
    m_arrChannelButtons = [[NSMutableArray alloc] init];
    return self;
}


#pragma mark - public methods
-(void)SetChannelBarHeight:(CGFloat)argHeight
{
    m_pChannelBar.frame = CGRectMake(0, 0, self.bounds.size.width, argHeight);
    m_pScrollView.frame = CGRectMake(0, argHeight, self.bounds.size.width, self.bounds.size.height-argHeight);
}

-(void)AddChannel:(BUChannelNameCell *)argChannelNameView withPage:(UIView *)argPage
{
    argPage.frame = CGRectMake(m_iPageCount*m_pScrollView.frame.size.width, 0, m_pScrollView.frame.size.width, m_pScrollView.frame.size.height);
    [m_pScrollView addSubview:argPage];
    NSLog(@"page frame is %@", NSStringFromCGRect(argPage.frame));
    
    UIButton* pButton = [[UIButton alloc] initWithFrame:CGRectMake(self.propChannelNameViewStartPos+m_iPageCount*self.propChannelNameViewWidth, 0, self.propChannelNameViewWidth, m_pChannelBar.frame.size.height)];
    [pButton addSubview:argChannelNameView];
    argChannelNameView.center = CGPointMake(pButton.frame.size.width/2, pButton.frame.size.height/2);
     NSLog(@"1cell rect is %@", NSStringFromCGRect(argChannelNameView.frame) );
    argChannelNameView.tag = 999;
    [m_pChannelBar addSubview:pButton];
    [pButton addTarget:self action:@selector(DisplayPage:) forControlEvents:UIControlEventTouchUpInside];
    pButton.tag = m_iPageCount;
    [m_arrChannelButtons addObject:pButton];
    
    m_iPageCount += 1;
    [m_pScrollView setContentSize:CGSizeMake(m_iPageCount*m_pScrollView.frame.size.width, m_pScrollView.frame.size.height)];
}

-(NSInteger)GetCurPage
{
    return m_iPage;
}

-(void)SetChannelIndicatorView:(UIView*)argIndicatorView
{
    [m_pChannelIndicator removeFromSuperview];
    m_pChannelIndicator = nil;
    m_pChannelIndicator = argIndicatorView;
    [m_pChannelBar addSubview:m_pChannelIndicator];
    
    m_pChannelIndicator.center = CGPointMake(self.propChannelNameViewStartPos +self.propChannelNameViewWidth/2, m_pChannelBar.frame.size.height-m_pChannelIndicator.frame.size.height/2);
}

-(void)SetDefaultPage:(NSInteger)argIndex
{
    if(argIndex<0 && argIndex>m_iPageCount)
        return;
   
    // set the previours button as normal
    UIButton* pButton = [m_arrChannelButtons objectAtIndex:m_iPage];
    BUChannelNameCell* pCell = (BUChannelNameCell*) [pButton viewWithTag:999];
    [pCell SetToNormal];
    
    // set the current button as highlight
    UIButton* pButton1 = [m_arrChannelButtons objectAtIndex:argIndex];
    BUChannelNameCell* pCell1 = (BUChannelNameCell*) [pButton1 viewWithTag:999];
    [pCell1 SetToHightlight];

    m_iPage = argIndex;
    
    CGPoint offsetPoint = CGPointMake(m_iPage*m_pScrollView.frame.size.width, 0);
    [m_pScrollView setContentOffset:offsetPoint animated:YES];

}


#pragma mark - private methods
-(void)DisplayPage:(UIButton*)argButton
{
    // set the previours button as normal
    UIButton* pButton = [m_arrChannelButtons objectAtIndex:m_iPage];
    BUChannelNameCell* pCell = (BUChannelNameCell*) [pButton viewWithTag:999];
    [pCell SetToNormal];
    
    // set the current button as highlight
    pCell = (BUChannelNameCell*) [argButton viewWithTag:999];
    [pCell SetToHightlight];
    m_iPage = argButton.tag;
    
    CGPoint offsetPoint = CGPointMake(m_iPage*m_pScrollView.frame.size.width, 0);
    [m_pScrollView setContentOffset:offsetPoint animated:YES];
}


#pragma mark - delegates
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat x = m_pScrollView.contentOffset.x;
    
    CGFloat indicatorStartPos = self.propChannelNameViewStartPos + self.propChannelNameViewWidth/2;
    CGFloat redLineX = indicatorStartPos + self.propChannelNameViewWidth*m_iPageCount*x/m_pScrollView.contentSize.width;
    m_pChannelIndicator.center = CGPointMake(redLineX, m_pChannelIndicator.center.y);
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(decelerate == NO)
    {
        UIButton* pButton = [m_arrChannelButtons objectAtIndex:m_iPage];
        BUChannelNameCell* pCell = (BUChannelNameCell*) [pButton viewWithTag:999];
        [pCell SetToNormal];
        
        CGFloat x = scrollView.contentOffset.x;
        NSInteger iPage = x/scrollView.frame.size.width;
        pButton = [m_arrChannelButtons objectAtIndex:iPage];
        pCell = (BUChannelNameCell*) [pButton viewWithTag:999];
        [pCell SetToHightlight];
        m_iPage = iPage;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    UIButton* pButton = [m_arrChannelButtons objectAtIndex:m_iPage];
    BUChannelNameCell* pCell = (BUChannelNameCell*) [pButton viewWithTag:999];
    [pCell SetToNormal];
    
    CGFloat x = scrollView.contentOffset.x;
    NSInteger iPage = x/scrollView.frame.size.width;
    pButton = [m_arrChannelButtons objectAtIndex:iPage];
    pCell = (BUChannelNameCell*) [pButton viewWithTag:999];
    [pCell SetToHightlight];
    m_iPage = iPage;
}


-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [m_pScrollView setFrame:CGRectMake(0,
                                       m_pChannelBar.frame.size.height,
                                       self.bounds.size.width,
                                       self.bounds.size.height-m_pChannelBar.frame.size.height)];
    [m_pScrollView setContentSize:CGSizeMake(self.bounds.size.width*m_iPageCount,
                                             self.bounds.size.height-m_pChannelBar.frame.size.height)];
    [m_pScrollView setContentOffset:CGPointMake(m_iPage*self.bounds.size.width, 0)];
}

@end
