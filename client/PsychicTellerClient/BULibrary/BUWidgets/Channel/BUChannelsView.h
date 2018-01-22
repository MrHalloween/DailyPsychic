//
//  BUChannelsView.h
//  pbuSymbolTechPaiPaiJing
//
//  Created by Xue Yan on 15/8/9.
//  Copyright (c) 2015年 周杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUChannelNameCell.h"


@protocol BUChannelsViewDelegate <NSObject>

@optional

@end


/// BUChannelsView defines a kind of view which is a channle bar
/// and channle content below. When user select the channel name or image
/// in the channle bar, the channel content will changed to that
/// content belonging to the channel.
/// like the 网易新闻 channel page.

@interface BUChannelsView : UIView <UIScrollViewDelegate>
{
    UIView* m_pChannelBar;          /// the channle bar. The channel buttons are located here.
    UIScrollView* m_pScrollView;    /// the channel content
    UIView* m_pChannelIndicator;    /// the scroll indicator below channle bar to tell which channel is it now
    NSMutableArray* m_arrChannelButtons;    /// store all the buttons, each of which is a channel button
    NSInteger m_iPage;              /// record the current channel page
    NSInteger m_iPageCount;         /// record the total page count
}

@property (assign) CGFloat propChannelNameViewStartPos;         /// the position where the channel button start to located
@property (assign) CGFloat propChannelNameViewWidth;            /// the width of the channel button
@property (readonly, nonatomic) UIView* propChannelBar;         /// readonly, the channel bar
@property (readonly)UIScrollView* propScrollView;


/// set the channel bar's height
/// this will affect the position of the scrollview
-(void)SetChannelBarHeight:(CGFloat)argHeight;

/// set the channel indicator view
-(void)SetChannelIndicatorView:(UIView*)argIndicatorView;

/// Add a channel.
/// @param argChannelNameView The view that dislay the channel name or channel image
/// @param argPage The view to display the content of this channel
-(void)AddChannel:(BUChannelNameCell*)argChannelNameView withPage:(UIView*)argPage;

/// Set the default page
/// @param argIndex The default page index
-(void)SetDefaultPage:(NSInteger)argIndex;

-(NSInteger)GetCurPage;
@end
