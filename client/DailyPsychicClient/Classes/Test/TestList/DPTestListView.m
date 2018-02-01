//
//  DPTestListView.m
//  DailyPsychicClient
//
//  Created by zhanghe on 2018/1/31.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPTestListView.h"
#import "DPTestListCell.h"
#import "UILable+TextEffect.h"

@implementation DPTestListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        m_pTitleLabel.text = @"Test";
        NSArray *plistData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"testList1" ofType:@"plist"]];
        m_arrData = [NSMutableArray arrayWithArray:plistData];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return m_arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DPTestListCell *pCell = [DPTestListCell CellWithTableView:tableView];
    pCell.backgroundColor = [UIColor clearColor];
    [pCell ClearData];
    [pCell SetCellData:m_arrData[indexPath.row]];
    return pCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105 * AdaptRate;
}
@end
