//
//  Fcgo_OrderUseCouponVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/24.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderUseCouponVC.h"
#import "Fcgo_CouponTableViewCell.h"
@interface Fcgo_OrderUseCouponVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView    *table;



@end

@implementation Fcgo_OrderUseCouponVC

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
    [self.navigationView setupTitleLabelWithTitle:@"优惠券"];
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_CouponTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"couponTableViewCell"];
    
    [self.view addSubview:self.table];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.listArray.count > 0) {
        return [self.listArray count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //WEAKSELF(weakSelf)
    Fcgo_CouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"couponTableViewCell"];
    if (self.listArray.count > 0) {
        Fcgo_CouponModel *model = self.listArray[indexPath.row];
        cell.model = model;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.listArray.count > 0) {
        Fcgo_CouponModel *model = self.listArray[indexPath.row];
        if (self.selectedBlock) {
            self.selectedBlock(model);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 102;
}

#pragma mark Lazy method

- (UITableView *)table
{
    if (!_table) {
        UITableView *table    = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight-kNavigationHeight) style:UITableViewStylePlain];
        table.backgroundColor = UIBackGroundColor;
        table.separatorStyle  = 0;
        table.delegate        = self;
        table.dataSource      = self;
        table.alpha           = 1;
        
        UIView *footerView   = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
        footerView.backgroundColor = UIBackGroundColor;
        table.tableFooterView = footerView;
        _table                = table;
        if (@available(iOS 11.0, *)) {
            table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _table;
}

@end
