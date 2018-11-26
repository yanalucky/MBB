//
//  Fcgo_Market_CustomerManngerVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/8/2.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_Market_CustomerManngerVC.h"
#import "Fcgo_Market_CustomerManngerCell.h"
#import "Fcgo_Market_CustomerManngerDetailVC.h"

@interface Fcgo_Market_CustomerManngerVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *table;

@end

@implementation Fcgo_Market_CustomerManngerVC

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
    [self.navigationView setupTitleLabelWithTitle:@"客户管理"];
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_Market_CustomerManngerCell class]) bundle:nil] forCellReuseIdentifier:@"market_CustomerManngerCell"];
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
    if (section == 0) {
        return 1;
    }
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:@"cell"];
            cell.backgroundColor = UIBackGroundColor;
        }
        return cell;
    }
    Fcgo_Market_CustomerManngerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"market_CustomerManngerCell"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 5;
    }
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Fcgo_Market_CustomerManngerDetailVC *vc = [[Fcgo_Market_CustomerManngerDetailVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

