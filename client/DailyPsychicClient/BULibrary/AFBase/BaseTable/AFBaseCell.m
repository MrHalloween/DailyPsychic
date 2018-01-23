//
//  SXBaseCommentCell.m
//  pbuShanXiSecurityTrafficClient
//
//  Created by  on 15/12/16.
//  Copyright © 2015年 . All rights reserved.
//

#import "AFBaseCell.h"

@implementation AFBaseCell

+ (instancetype)CellWithTableView:(UITableView *)argTableView
{
    NSString *strIdentify = NSStringFromClass([self class]);
    AFBaseCell *pCell = [argTableView dequeueReusableCellWithIdentifier:strIdentify];
    if (pCell == nil)
    {
        pCell = [[[self class] alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strIdentify];
    }
    pCell.backgroundColor = [UIColor whiteColor];
    pCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return pCell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self AddSubViews];
    }
    return self;
}

- (void)AddSubViews
{

}

- (void)ClearData
{

}

- (void)SetCellData:(id)argData
{

}

- (void)layoutSubviews
{
    [super layoutSubviews];

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
