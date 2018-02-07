//
//  DPPalmResultView.m
//  DailyPsychicClient
//
//  Created by lsy on 2018/2/1.
//  Copyright © 2018年 h. All rights reserved.
//

#import "DPPalmResultView.h"
#import "DPPalmResultCell.h"

@interface DPPalmResultView()
{
    NSArray *m_arrAlternative;
}
@end

@implementation DPPalmResultView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        m_pBaseTable.showsVerticalScrollIndicator = NO;
        //给tableView添加header
        UIView *pHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 20 * AdaptRate)];
        pHeaderView.backgroundColor = [UIColor clearColor];
        m_pBaseTable.tableHeaderView = pHeaderView;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)setResultType:(int)resultType{
    if (resultType== 1) {
        m_pTitleLabel.text = @"Palm analysis";
    }else if (resultType == 2){
        m_pTitleLabel.text = @"Constellation analysis";
    }else if (resultType == 3){
        m_pTitleLabel.text = @"Test analysis";
    }
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


- (void)setTestId:(NSString *)testId
{
    _testId = testId;
    NSArray *plistData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"testResult" ofType:@"plist"]];
    for (int i = 0; i < plistData.count; i ++) {
        NSDictionary *dict = plistData[i];
        NSString *strTestId = dict[@"testId"];
        if ([strTestId isEqualToString:testId]) {
            m_arrAlternative = dict[@"result"];
            break;
        }
    }
    int x = arc4random() % m_arrAlternative.count;
    m_arrData = [NSMutableArray arrayWithArray:m_arrAlternative[x]];
    [m_pBaseTable reloadData];
}

@end
