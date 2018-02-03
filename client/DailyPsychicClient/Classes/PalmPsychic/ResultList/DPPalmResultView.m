//
//  DPPalmResultView.m
//  DailyPsychicClient
//
//  Created by lsy on 2018/2/1.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPPalmResultView.h"
#import "DPPalmResultCell.h"

@implementation DPPalmResultView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        m_pTitleLabel.text = @"Palm analysis";
        m_pBaseTable.showsVerticalScrollIndicator = NO;
        
        //给tableView添加header
        UIView *pHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 20 * AdaptRate)];
        pHeaderView.backgroundColor = [UIColor clearColor];
        m_pBaseTable.tableHeaderView = pHeaderView;
        
        NSArray *plistData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"resultAnalysis" ofType:@"plist"]];
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
    DPPalmResultCell *pCell = [DPPalmResultCell CellWithTableView:tableView];
    pCell.backgroundColor = [UIColor clearColor];
    [pCell ClearData];
    [pCell SetCellData:m_arrData[indexPath.row]];
    return pCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DPPalmResultCell *pCell = [DPPalmResultCell CellWithTableView:tableView];
    [pCell ClearData];
    [pCell SetCellData:m_arrData[indexPath.row]];
    return [pCell GetCellHeight];
}

@end