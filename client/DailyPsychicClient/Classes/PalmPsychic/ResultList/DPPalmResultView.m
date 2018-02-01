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
//        NSArray *plistData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"testList1" ofType:@"plist"]];
//        m_arrData = [NSMutableArray arrayWithArray:plistData];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
      return 3;
//    return m_arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DPPalmResultCell *pCell = [DPPalmResultCell CellWithTableView:tableView];
    pCell.backgroundColor = [UIColor clearColor];
//    [pCell ClearData];
//    [pCell SetCellData:m_arrData[indexPath.row]];
    return pCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 243 * AdaptRate;
}

@end
