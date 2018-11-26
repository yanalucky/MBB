//
//  Fcgo_MsgVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_MsgVC.h"
#import "Fcgo_MsgTableCell.h"


#import "Fcgo_MsgSystemVC.h"
#import "Fcgo_MsgActivityVC.h"
#import "Fcgo_MsgOrderVC.h"


#import "Fcgo_MsgViewModel.h"
#import "Fcgo_MsgDetailHtmlVC.h"

#import "Fcgo_MsgOrderModel.h"
#import "Fcgo_MsgSystemModel.h"


@interface Fcgo_MsgVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView    *table;

@property (nonatomic,strong) NSMutableArray *systemArray;
@property (nonatomic,strong) NSMutableArray *orderArray;
@property (nonatomic,strong) NSArray *msgArray;

@end

@implementation Fcgo_MsgVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.msgArray = @[@[@"ico_notice",@"系统消息"],@[@"ico_order",@"订单消息"],@[@"ico_activity",@"活动消息"]];
    [self setupUI];
    [self reloadRequest];
}

- (void)reloadRequest
{
    if (![Fcgo_Tools isNetworkConnected]) {
        [WSProgressHUD showImage:nil status:@"亲,没联网啊"];
        [self showUIData:NO];
        return;
    }
    WEAKSELF(weakSelf)
    [Fcgo_MsgViewModel postRequestSystemMsgListSuccess:^(NSMutableArray *mutableArray) {
        STRONGSELF(strongSelf);
        [self showUIData:YES];
        [weakSelf.table.mj_header endRefreshing];
        //判断请求回来是否有数据
        if (mutableArray &&mutableArray.count>0) {
            [strongSelf.systemArray removeAllObjects];
            [mutableArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [strongSelf.systemArray addObject:obj];
            }];
            [strongSelf.table reloadData];
        }
        
    } ofFail:^{
        [self showUIData:NO];
        [weakSelf.table.mj_header endRefreshing];
    }];
   
    [Fcgo_MsgViewModel postRequestOrderMsgListSuccess:^(NSMutableArray *mutableArray) {
        STRONGSELF(strongSelf);
       [weakSelf.table.mj_header endRefreshing];
        [self showUIData:YES];
        //判断请求回来是否有数据
        if (mutableArray &&mutableArray.count>0) {
            [strongSelf.orderArray removeAllObjects];
            [mutableArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [strongSelf.orderArray addObject:obj];
            }];
            [strongSelf.table reloadData];
        }
        [weakSelf.table.mj_header endRefreshing];
    } ofFail:^{
        [self showUIData:NO];
        [weakSelf.table.mj_header endRefreshing];
    }];
}

- (void)showUIData:(BOOL)isShow
{
    [self showNoControl:!isShow titleString:@"网络错误,点击重新加载" imageString:@"ico_no-wifi"];
    self.table.hidden = !isShow;
}

- (void)setupUI;
{
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    [self.navigationView setupTitleLabelWithTitle:@"消息中心"];
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_MsgTableCell class]) bundle:nil] forCellReuseIdentifier:@"msgTableCell"];
    self.table.mj_header = [Fcgo_RefreshNormalHeader headerRefreshBlock:^{
        [weakSelf reloadRequest];
    }];
    [self.view insertSubview:self.table belowSubview:self.navigationView];
}
#pragma mark table delegate datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section == 0) {
//        if (self.systemArray.count>0) {
//            return 1;
//        }
//        return 0;
//    }
//    if (self.orderArray.count>0) {
//        return 1;
//    }
 //   return 0;
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Fcgo_MsgTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"msgTableCell"];
    if (self.msgArray.count>0) {
        cell.msgImageView.image = [UIImage imageNamed:self.msgArray[indexPath.section][0]];
        cell.msgTitleLabel.text = self.msgArray[indexPath.section][1];
    }
    if (indexPath.section == 0) {
        if (self.systemArray.count>0) {
            Fcgo_MsgSystemModel *model = self.systemArray[0];
            cell.msgDetailLabel.text = model.title;
            cell.msgDateLabel.text   = model.created;
        }else{
            cell.msgDetailLabel.text = @"暂无消息";
            cell.msgDateLabel.text   = @"";
        }
    }
    else{
        if (self.orderArray.count>0) {
            Fcgo_MsgOrderModel *model = self.orderArray[0];
            cell.msgDetailLabel.text = model.message;
            cell.msgDateLabel.text   = model.sendTime;
        }else{
            cell.msgDetailLabel.text = @"暂无消息";
            cell.msgDateLabel.text   = @"";
        }
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (self.systemArray.count<=0) {
            [WSProgressHUD showImage:nil status:@"暂无系统类消息"];
            return;
        }
        
        Fcgo_MsgSystemVC *vc = [[Fcgo_MsgSystemVC alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
       [self.navigationController pushViewController:vc animated:YES];
        
    }
//    else if (indexPath.row == 1) {
//        Fcgo_MsgActivityVC *vc = [[Fcgo_MsgActivityVC alloc]init];
//        vc.hidesBottomBarWhenPushed = 1;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    else if (indexPath.section == 1) {
        if (self.orderArray.count<=0) {
            [WSProgressHUD showImage:nil status:@"暂无订单类消息"];
            return;
        }
        Fcgo_MsgOrderVC *vc = [[Fcgo_MsgOrderVC alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark Lazy method

- (UITableView *)table
{
    if (!_table) {
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight - kNavigationHeight) style:UITableViewStylePlain];
        table.delegate = self;
        table.dataSource = self;
        table.backgroundColor = UIBackGroundColor;
        table.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _table = table;
        if (@available(iOS 11.0, *)) {
            table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _table;
}

- (NSMutableArray *)systemArray
{
    if (!_systemArray) {
        _systemArray = [[NSMutableArray alloc]init];
    }
    return _systemArray;
}

- (NSMutableArray *)orderArray
{
    if (!_orderArray) {
        _orderArray = [[NSMutableArray alloc]init];
    }
    return _orderArray;
}
@end
