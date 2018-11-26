//
//  Fcgo_Market_DataStatisticsVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/8/2.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_Market_DataStatisticsVC.h"
#import "Fcgo_Market_DataStatisticsCell.h"
@interface Fcgo_Market_DataStatisticsVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView    *table;

@end

@implementation Fcgo_Market_DataStatisticsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI;
{
    
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"账单流水"];
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_Market_DataStatisticsCell class]) bundle:nil] forCellReuseIdentifier:@"market_DataStatisticsCell"];
    
    self.table.mj_header = [Fcgo_RefreshNormalHeader headerRefreshBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.table.mj_header endRefreshing];
            [weakSelf.table reloadData];
        });
    }];
    [self.view insertSubview:self.table belowSubview:self.navigationView];
}




#pragma mark table delegate datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Fcgo_Market_DataStatisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"market_DataStatisticsCell"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView  =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    headerView.backgroundColor = UIBackGroundColor;
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, kScreenWidth - 30, 30)];
    title.textColor = UIFontMainGrayColor;
    title.font = UIFontSize(15);
    title.text = @"八月";
    [headerView addSubview:title];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

#pragma mark Lazy method

- (UITableView *)table
{
    if (!_table) {
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight - kNavigationHeight) style:UITableViewStylePlain];
        table.separatorStyle = 0;
        table.delegate = self;
        table.dataSource = self;
        table.backgroundColor = UIBackGroundColor;
        table.tableFooterView = [UIView new];
        _table = table;
        if (@available(iOS 11.0, *)) {
            table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _table;
}

@end
