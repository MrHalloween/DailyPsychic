//
//  BUChannelNameCell.h
//  pbuSymbolTechPaiPaiJing
//
//  Created by Xue Yan on 15/8/9.
//  Copyright (c) 2015年 周杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BUChannelNameCellDelegate <NSObject>

@optional

@end


/// BUChannelNameCell difines a view which display the channel name
/// or channel image. And it should be used with BUChannelsView.

@interface BUChannelNameCell : UIView
{
    UIImageView* m_pImageView;      /// The image View. By default the image view is as big is the cell
    UILabel* m_pLabel;              /// The label. By default the label view is as big as the cell.
}

@property (retain, nonatomic) UIImage* propNormalImage;     /// Record the image displayed in the normal state
@property (retain, nonatomic) UIImage* propHighlightImage;  /// Record the image displayed in the highlight state
@property (retain, nonatomic) NSString* propTitle;          /// Record the title string
@property (retain, nonatomic) UIColor* propHighlightColor;  /// record the color of the title in the highlight state
@property (retain, nonatomic) UIColor* propNormalColor;     /// Record the color of the title in the normal state
@property (readonly, nonatomic) UILabel* propLabel;         /// Readonly. The label
@property (readonly, nonatomic) UIImageView* propImageView; /// Readonly. The image view

@property (weak, nonatomic) id<BUChannelNameCellDelegate> propDelegate; /// delegate

/// Set the cell to highlight state
-(void)SetToHightlight;

/// Set the cell to normal state
-(void)SetToNormal;


@end
