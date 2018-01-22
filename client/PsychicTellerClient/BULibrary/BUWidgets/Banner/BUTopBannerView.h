//
//  BHTBannerView.h
//  pbuWanHuaTong
//
//  Created by Xue Yan on 15/8/24.
//  Copyright (c) 2015年   MultiMedia Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BUTopBannerViewDelegate <NSObject>

- (void)ToViewDetails:(id)argData;    ///查看详细情况

@end

@interface BUTopBannerView : UIView <UIScrollViewDelegate>
{
    @public
    UIPageControl *m_pPageControl;
    @private
    UIScrollView *m_pScrollView;
    UIScrollView* m_pScrollLabel;
    UIView *m_pTitleBg;
    UILabel *m_pTitleLable;
    NSMutableArray* m_arrData;
    NSMutableArray *m_arrTitle;
    NSTimer* m_pTimer;
}
@property(nonatomic,weak)id<BUTopBannerViewDelegate> propDel;

-(void)SetData:(NSArray*)arrData andImageUrls:(NSArray*)argImageUrls andTitle:(NSArray *)argTitle;

-(void)RefreshAnimation;

- (void)StopTimer;
@end
