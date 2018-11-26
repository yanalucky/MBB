//
//  Fcgo_SafeVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/17.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_SafeVC.h"
#import "Fcgo_SetupTableViewCell.h"
#import "Fcgo_ChangePasswordVC.h"
#import "Fcgo_ChangeTelVC.h"

@interface Fcgo_SafeVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView    *table;
@property (nonatomic,strong) NSArray        *titleArray;

@end

@implementation Fcgo_SafeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI;
{
   NSString *tel = [Fcgo_UserTools shared].userDict[@"opPhone"];
    //前边三个
    NSString *tel1  = [tel substringToIndex:3];
    NSString *tel2  = [tel substringFromIndex:8];
    NSString *phone = [NSString stringWithFormat:@"%@*****%@",tel1,tel2];
    
    self.titleArray = @[@[@"修改登录绑定手机",phone],
                        @[@"修改登录密码",@""]
                       ];
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"安全中心"];
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_SetupTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"setupTableViewCell"];
    
    [self.view insertSubview:self.table belowSubview:self.navigationView];
}

#pragma mark table delegate datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Fcgo_SetupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setupTableViewCell"];
    
    cell.titleLabel.text = self.titleArray[indexPath.row][0];
    cell.cacheLabel.text = self.titleArray[indexPath.row][1];
    cell.cacheLabel.alpha = 1;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        Fcgo_ChangeTelVC *vc = [[Fcgo_ChangeTelVC alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if(indexPath.row == 1)
    {
        Fcgo_ChangePasswordVC *vc = [[Fcgo_ChangePasswordVC alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kAutoWidth6(50);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc]init];
    footerView.backgroundColor = UINavSepratorLineColor;
    return footerView;
}

#pragma mark Lazy method

- (UITableView *)table
{
    if (!_table) {
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight - kNavigationHeight) style:UITableViewStylePlain];
        table.delegate = self;
        table.dataSource = self;
        table.scrollEnabled = 0;
        table.backgroundColor = UIBackGroundColor;
        _table = table;
        if (@available(iOS 11.0, *)) {
            table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _table;
}

@end
