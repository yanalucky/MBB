//
//  Fcgo_Market_CustomerManngerDetailVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/8/3.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_Market_CustomerManngerDetailVC.h"
#import "Fcgo_Market_CustomerManngerDetailCell.h"

@interface Fcgo_Market_CustomerManngerDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView    *table;

@property (weak, nonatomic) IBOutlet UIImageView *bgImg;
@property (weak, nonatomic) IBOutlet UILabel *registTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyNumLabel;



@end

@implementation Fcgo_Market_CustomerManngerDetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI;
{
    
    self.view.backgroundColor = UIBackGroundColor;
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"客户详情"];
    
    [self.bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_offset(kNavigationHeight);
        make.height.mas_offset(108);
    }];
    
    [self.registTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.mas_offset(kNavigationSubY(79));
    }];
    self.registTimeLabel.textColor = UIFontWhiteColor;
    
    [self.headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_equalTo(weakSelf.registTimeLabel.mas_bottom).mas_offset(10);
        make.height.width.mas_offset(56);
    }];
    self.headerImg.layer.cornerRadius = 28;
    self.headerImg.layer.masksToBounds = YES;
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.headerImg.mas_right).mas_offset(kAutoWidth6(20));
        make.top.mas_equalTo(weakSelf.headerImg.mas_top);
    }];
    self.nameLabel.textColor = UIFontWhiteColor;
                             
    [self.telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.headerImg.mas_right).mas_offset(kAutoWidth6(20));
        make.top.mas_equalTo(weakSelf.headerImg.mas_centerY);
    }];
    self.telLabel.textColor = UIFontWhiteColor;
    
    [self.buyNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.telLabel.mas_right).mas_offset(kAutoWidth6(20));
        make.centerY.mas_equalTo(weakSelf.telLabel.mas_centerY);
    }];
    self.buyNumLabel.textColor = UIFontWhiteColor;
    self.buyNumLabel.backgroundColor = UIFontClearColor;
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_Market_CustomerManngerDetailCell class]) bundle:nil] forCellReuseIdentifier:@"market_CustomerManngerDetailCell"];
    
    self.table.mj_header = [Fcgo_RefreshNormalHeader headerRefreshBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.table.mj_header endRefreshing];
            [weakSelf.table reloadData];
        });
    }];
    [self.view insertSubview:self.table belowSubview:self.navigationView];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.top.mas_equalTo(weakSelf.bgImg.mas_bottom);
    }];
}

#pragma mark table delegate datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Fcgo_Market_CustomerManngerDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"market_CustomerManngerDetailCell"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
 }

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView  =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    headerView.backgroundColor = UIBackGroundColor;
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, kScreenWidth - 30, 30)];
    title.textColor = UIFontMiddleGrayColor;
    title.font = UIFontSize(13);
    title.text = @"消费记录";
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
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
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


