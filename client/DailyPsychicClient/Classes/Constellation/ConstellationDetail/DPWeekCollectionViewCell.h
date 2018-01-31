//
//  DPWeekCollectionViewCell.h
//  DailyPsychicClient
//
//  Created by lsy on 2018/1/31.
//  Copyright © 2018年 h. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DPWeekCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) UILabel *weekLabel; /// < 周几
@property (nonatomic, weak) UIImageView *circleBgImg; /// < 背景小圆圈
@property (nonatomic, weak) UIImageView *pointImg; /// < 圆点
@property (nonatomic, weak) UILabel *dateLabel; /// < 日期
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView identifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath;

@end
