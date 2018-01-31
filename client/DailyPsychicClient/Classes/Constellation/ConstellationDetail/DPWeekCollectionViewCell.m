//
//  DPWeekCollectionViewCell.m
//  DailyPsychicClient
//
//  Created by lsy on 2018/1/31.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPWeekCollectionViewCell.h"
#import "UILable+TextEffect.h"

@implementation DPWeekCollectionViewCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView identifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath
{
    DPWeekCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews{
    
    // 星期
    UILabel *weekLabel = [[UILabel alloc]init];
    [weekLabel SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager RegularFont] FontSize:12 Placehoder:@"MON"];
    weekLabel.frame = CGRectMake(0, 0, self.width, SIZE_HEIGHT(12));
    weekLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:weekLabel];
    self.weekLabel = weekLabel;
    
    //背景圆
    UIImageView *circleBgImg = [[UIImageView alloc]initWithFrame:CGRectMake((self.width - 46 * AdaptRate) * 0.5, weekLabel.bottom + 12 * AdaptRate, 46 *AdaptRate, 46 * AdaptRate)];
    circleBgImg.image = [UIImage imageNamed:@"constellation_detail_selectdate"];
    [self.contentView addSubview:circleBgImg];
    self.circleBgImg = circleBgImg;
    
    //选中的圆点
    UIImageView *pointImg = [[UIImageView alloc]initWithFrame:CGRectMake(21 * AdaptRate, 33 * AdaptRate, 5 *AdaptRate, 5 * AdaptRate)];
    pointImg.image = [UIImage imageNamed:@"constellation_detail_selectpoint"];
    [self.circleBgImg addSubview:pointImg];
    self.pointImg = pointImg;
    
    //日期
    UILabel *dateLabel = [[UILabel alloc]init];
    [dateLabel SetTextColor:UIColorFromHex(0xffffff) FontName:[TextManager RegularFont] FontSize:12 Placehoder:@"14"];
    dateLabel.frame = CGRectMake(0, 13 * AdaptRate, self.circleBgImg.width, SIZE_HEIGHT(14));
    dateLabel.textAlignment = NSTextAlignmentCenter;
    [self.circleBgImg addSubview:dateLabel];
    self.dateLabel = dateLabel;
    
}

@end
