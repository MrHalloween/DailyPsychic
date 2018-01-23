//
//  DPHomePageView.m
//  DailyPsychicClient
//
//  Created by zhanghe on 2018/1/23.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPHomePageView.h"
#import "DPHomePageCell.h"

@implementation DPHomePageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        m_arrData = [NSMutableArray arrayWithObjects:@{@"id":@0,@"title":@"手相分析",@"image":@""},
                                                     @{@"id":@1,@"title":@"星座",@"image":@""},
                                                     @{@"id":@2,@"title":@"测试",@"image":@""}, nil];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return m_arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DPHomePageCell *pCell = [DPHomePageCell CellWithTableView:tableView];
    [pCell ClearData];
    [pCell SetCellData:m_arrData[indexPath.row]];
    return pCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200 * [AppConfigure GetLengthAdaptRate];
}
@end
