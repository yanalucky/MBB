//
//  Fcgo_StoreManagerVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/11/24.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_StoreManagerVC.h"
#import "Fcgo_StoreManagerCell.h"

#import "Fcgo_AddStoreVC.h"

@interface Fcgo_StoreManagerVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView    *table;
@property (nonatomic,strong) NSMutableArray *storeArray;
@property (nonatomic,strong) UIButton       *addStoreBtn;
@end

@implementation Fcgo_StoreManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"门店管理"];
    
    [self setupUI];
}


- (void)setupUI
{
    WEAKSELF(weakSelf)
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.userInteractionEnabled = 1;
    imageView.image = [UIImage imageNamed:@"ico_chuizi@2x"];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(100);
        make.height.width.mas_offset(kAutoWidth6(120));
        make.centerX.mas_equalTo(weakSelf.view);
    }];
    
    UILabel *midleLabel = [[UILabel alloc]init];
    midleLabel.font = UIFontSize(14);
    midleLabel.text = @"功能开发中,敬请等待";
    midleLabel.textColor = UIFontSortGrayColor;
    midleLabel.numberOfLines = 1;
    midleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:midleLabel];
    [midleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom).mas_offset(35);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
    }];
}
/*
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
    [self.navigationView setupTitleLabelWithTitle:@"门店管理"];
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_StoreManagerCell class]) bundle:nil] forCellReuseIdentifier:@"storeManagerCell"];
    self.table.mj_header = [Fcgo_RefreshNormalHeader headerRefreshBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.table.mj_header endRefreshing];
            [weakSelf.table reloadData];
        });
    }];
    [self.view insertSubview:self.table belowSubview:self.navigationView];
    
    [self.addStoreBtn addTarget:self action:@selector(addStoreClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addStoreBtn];
    [self.addStoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(kAutoWidth6(50));
    }];
}

- (void)addStoreClick
{
    Fcgo_AddStoreVC *vc = [[Fcgo_AddStoreVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark table delegate datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return self.storeArray.count;
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Fcgo_StoreManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"storeManagerCell"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   return 84;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Lazy method

- (UITableView *)table
{
    if (!_table) {
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight - kNavigationHeight-kAutoWidth6(50)) style:UITableViewStylePlain];
        table.delegate = self;
        table.dataSource = self;
        table.backgroundColor = UIBackGroundColor;
        table.separatorStyle = UITableViewCellSeparatorStyleNone;
         table.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _table = table;
        if (@available(iOS 11.0, *)) {
            table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _table;
}

- (UIButton *)addStoreBtn
{
    if (!_addStoreBtn) {
        _addStoreBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _addStoreBtn.titleLabel.font = UIFontSize(16);
        [_addStoreBtn setTitle:@"添加新门店" forState:UIControlStateNormal];
        [_addStoreBtn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
        [_addStoreBtn setBackgroundColor:UIFontRedColor];
    }
    return _addStoreBtn;
}

- (NSMutableArray *)storeArray
{
    if (!_storeArray) {
        _storeArray = [[NSMutableArray alloc]init];
    }
    return _storeArray;
}
*/
@end

