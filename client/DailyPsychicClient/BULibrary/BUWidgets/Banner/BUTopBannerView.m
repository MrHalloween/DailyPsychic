//
//  BHTBannerView.m
//  pbuWanHuaTong
//
//  Created by Xue Yan on 15/8/24.
//  Copyright (c) 2015年   MultiMedia Lab. All rights reserved.
//

#import "BUTopBannerView.h"

@implementation BUTopBannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self.backgroundColor = [UIColor whiteColor];
    
    self= [super initWithFrame:frame];
    m_arrData = [[NSMutableArray alloc] init];
    m_arrTitle = [NSMutableArray array];
    m_pScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [m_pScrollView setScrollEnabled:YES];
    m_pScrollView.showsHorizontalScrollIndicator = NO;
    m_pScrollView.showsVerticalScrollIndicator = NO;
    [m_pScrollView setDelegate:self];
    [m_pScrollView setBackgroundColor:[UIColor clearColor]];
    [m_pScrollView setPagingEnabled:YES];
    
    [self addSubview:m_pScrollView];
    
    m_pTitleBg = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 30 * [AppConfigure GetLengthAdaptRate], self.width, 30 * [AppConfigure GetLengthAdaptRate])];
    m_pTitleBg.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3f];
    //m_pTitleBg.alpha = 0.3f;
    m_pTitleBg.hidden = YES;
    [self addSubview:m_pTitleBg];
    

    m_pScrollLabel = [[UIScrollView alloc] initWithFrame:CGRectMake(10 * [AppConfigure GetLengthAdaptRate], 0, self.width - 20 * [AppConfigure GetLengthAdaptRate], m_pTitleBg.height)];
    [m_pTitleBg addSubview:m_pScrollLabel];
    
    m_pTitleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, self.width - 20 * [AppConfigure GetLengthAdaptRate], m_pTitleBg.height)];
    m_pTitleLable.textColor = [UIColor whiteColor];
    m_pTitleLable.font = [UIFont fontWithName:[TextManager RegularFont] size:15];
    [m_pScrollLabel addSubview:m_pTitleLable];
    
    m_pPageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
//    m_pPageControl.pageIndicatorTintColor = [AppConfigure TopNavBgColor];
//    m_pPageControl.currentPageIndicatorTintColor = [UIColor yellowColor];
    [m_pPageControl addTarget:self action:@selector(HandlePageCotrollerChangeAction:) forControlEvents:UIControlEventValueChanged];
    m_pPageControl.hidden = NO;
    [self addSubview:m_pPageControl];
    
    return self;
}

- (void)StopTimer
{
    [m_pTimer invalidate];
    m_pTimer = nil;
}

-(void)dealloc
{
    [m_pTimer invalidate];
    m_pTimer = nil;
}

-(void)RefreshAnimation
{
    if(m_pTitleLable.width > m_pScrollLabel.width )
    {
        m_pScrollLabel.contentSize = CGSizeMake(m_pTitleLable.width+m_pScrollLabel.width, m_pTitleLable.height);
        m_pScrollLabel.contentOffset = CGPointMake(0-self.width*0.8, 0);
        
        [UIView animateKeyframesWithDuration:m_pTitleLable.text.length*0.2+0.2*20 delay:0 options:UIViewKeyframeAnimationOptionRepeat|UIViewAnimationOptionCurveLinear animations:^{
            m_pScrollLabel.contentOffset = CGPointMake(m_pTitleLable.width, 0);
            
        } completion:^(BOOL finished) {
            nil;
        }];
    }
}

#pragma mark - private methods
-(void)SetData:(NSArray*)arrData andImageUrls:(NSArray*)argImageUrls andTitle:(NSArray *)argTitle
{
    [m_pTimer invalidate];
    m_pTimer = nil;
    [m_arrData removeAllObjects];
    [m_arrData addObjectsFromArray:arrData];
    [m_arrTitle removeAllObjects];
    [m_arrTitle addObjectsFromArray:argTitle];
    [m_pScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (arrData.count <= 0){
        return;
    }
    if (argTitle.count > 0)
    {
        m_pTitleBg.hidden = NO;
    }

    // set new data
    NSInteger iCount = [m_arrData count];
    m_pPageControl.numberOfPages = iCount;
    m_pScrollView.contentSize = CGSizeMake(m_pScrollView.frame.size.width*(iCount+1), m_pScrollView.frame.size.height);
    CGSize sPageSize = [m_pPageControl sizeForNumberOfPages:iCount];
    if (argTitle.count > 0) {
        m_pPageControl.frame = CGRectMake(self.width - 10 * [AppConfigure GetLengthAdaptRate] - sPageSize.width, self.height - 30 * [AppConfigure GetLengthAdaptRate] + (30 * [AppConfigure GetLengthAdaptRate] - sPageSize.height) / 2.0f, sPageSize.width, sPageSize.height);
    }else{
        m_pPageControl.frame = CGRectMake(0, self.height - 30 * [AppConfigure GetLengthAdaptRate] + (30 * [AppConfigure GetLengthAdaptRate] - sPageSize.height) / 2.0f, self.width, sPageSize.height);
    }
    
    // add the images to the scorll view
    // why iCount+1? because we will make the last page looks same as the first page
    for(NSInteger i=0; i<iCount+1; i++)
    {
        NSInteger iIndex = (i==iCount)? 0:i ;
        NSString* strUrl = [argImageUrls objectAtIndex:iIndex];
        NSURL* pURL = [NSURL URLWithString:strUrl];
        UIImageView* pImageView = [[UIImageView alloc] initWithFrame:CGRectMake(m_pScrollView.frame.size.width * i, 0, m_pScrollView.frame.size.width, m_pScrollView.frame.size.height)];
        pImageView.contentMode = UIViewContentModeScaleAspectFill;
        pImageView.clipsToBounds = YES;
//        [pImageView setImageWithURL:pURL placeholderImage:[UIImage imageNamed:@"homepage_banner.png"]];
//        [pImageView setImageWithURL:pURL placeholderImage:[UIImage imageNamed:@"banner_placeholder.png"]];
        
//        __weak typeof(pImageView) weakView = pImageView;
//        [pImageView setImageWithURLRequest:[NSURLRequest requestWithURL:pURL] placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
//            weakView.image = image;
//        } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
//            [AppConfigure LoadImageWithImageView:pImageView ImageViewUrl:strUrl PlaceHoldImage:[UIImage imageNamed:@"default_banner_new.png"]];
//        }];

        pImageView.tag = iIndex + 100;
        [pImageView setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *pTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapBannerImageAction:)];
        [pImageView addGestureRecognizer:pTapGesture];
        [m_pScrollView addSubview:pImageView];
        
        if (i == 0 && m_arrTitle.count != 0)
        {
            m_pTitleLable.text = m_arrTitle[0];
            [m_pTitleLable sizeToFit];
        }
    }
    
    [m_pTimer invalidate];
    m_pTimer = nil;
    if (arrData.count == 1)
    {
        m_pScrollView.scrollEnabled = NO;
        m_pPageControl.hidden = YES;
    }
    else
    {
        m_pScrollView.scrollEnabled = YES;
        m_pPageControl.hidden = NO;
        m_pTimer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(ScrollToNextPage) userInfo:nil repeats:YES];
    }
}

///点击轮播图事件
- (void)TapBannerImageAction:(UITapGestureRecognizer *)argGesture
{
    UIImageView *pImage = (UIImageView *)argGesture.view;
    if (self.propDel != nil && [self.propDel respondsToSelector:@selector(ToViewDetails:)])
    {
        [self.propDel ToViewDetails:m_arrData[pImage.tag - 100]];
    }
    
}

-(void)ScrollToNextPage
{
    NSInteger page = m_pPageControl.currentPage;

    CGFloat offsetsX = (page+1) * m_pScrollView.frame.size.width;
    __weak UIScrollView *weakScrollView = m_pScrollView;
    __weak UIPageControl *weakPageControl = m_pPageControl;
    __weak UILabel *weakTitle = m_pTitleLable;
    NSArray *arrTitle =m_arrTitle;
    
    [UIView animateWithDuration:0.3 animations:^{
        [weakScrollView setContentOffset:CGPointMake(offsetsX, 0)];
    } completion:^(BOOL finished)
    {
        if(page == weakPageControl.numberOfPages - 1)
        {
            [weakScrollView setContentOffset:CGPointMake(0, 0) ];
        }
        weakPageControl.currentPage = (weakScrollView.contentOffset.x/weakScrollView.frame.size.width);
        if (arrTitle.count > 0)
        {
            weakTitle.text = arrTitle[weakPageControl.currentPage];
        }
    }];
}

- (void)HandlePageCotrollerChangeAction:(id)sender
{
    CGFloat offsetx = m_pPageControl.currentPage * m_pScrollView.frame.size.width;
    [m_pScrollView setContentOffset:CGPointMake(offsetx, 0) animated:YES];
}

/**
 *  开始拖拽的时候调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 停止定时器(一旦定时器停止了,就不能再使用)
    [m_pTimer invalidate];
    m_pTimer = nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x < 0)
    {
        [scrollView setContentOffset:CGPointMake((m_pPageControl.numberOfPages) * scrollView.frame.size.width, 0)];
    }
    else if (scrollView.contentOffset.x > m_pPageControl.numberOfPages * scrollView.frame.size.width)
    {
        [scrollView setContentOffset:CGPointMake(0, 0)];
    }
}

/**
 *  停止拖拽的时候调用
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // 开启定时器
    m_pTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(ScrollToNextPage) userInfo:nil repeats:YES];
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat fOffsetX = m_pScrollView.contentOffset.x;
    if((NSInteger)round(fOffsetX / m_pScrollView.frame.size.width) == m_pPageControl.numberOfPages)
    {
        [m_pScrollView setContentOffset:CGPointMake(0, 0) ];
    }
    m_pPageControl.currentPage = (m_pScrollView.contentOffset.x/m_pScrollView.frame.size.width);
    if (m_arrTitle.count != 0)
    {
        m_pTitleLable.text = m_arrTitle[m_pPageControl.currentPage];
    }
}


@end
