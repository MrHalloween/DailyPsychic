//
//  AFButton.h
//  TabBarController
//
//  Created by 李鑫浩 on 16/6/1.
//  Copyright © 2016年 李鑫浩. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    AFBadgeShowTypeNum,       ///显示出数字
    AFBadgeShowTypePoint      ///不显示数字
} AFBadgeShowType;

@interface AFTabBarItem : UIButton
{
    UILabel *m_pBadge;    ///徽标
}

//上图下字   图片的高度和文字高度的比例
@property(nonatomic,assign)CGFloat fHeightScale;

//设置徽标值
- (void)SetBadgeNum:(NSInteger)argNum withType:(AFBadgeShowType)argType;

@end
