//
//  Fcgo_MsgActivityVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/22.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_MsgActivityVC.h"
#import "Fcgo_MsgActivityCell.h"
#import "Fcgo_MsgDetailHtmlVC.h"

@interface Fcgo_MsgActivityVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView    *table;


@end

@implementation Fcgo_MsgActivityVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupUI];
    
    [self.table reloadData];
    //[self reloadRequest];
}

- (void)reloadRequest
{
//    WEAKSELF(weakSelf)
//    [Fcgo_MsgViewModel postRequestMsgListSuccess:^(NSMutableArray *mutableArray) {
//        STRONGSELF(strongSelf);
//        [strongSelf showTableAlpha:1];
//        //判断请求回来是否有数据
//        if (mutableArray &&mutableArray.count>0) {
//            [strongSelf.msgMutableArray removeAllObjects];
//            [mutableArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                [strongSelf.msgMutableArray addObject:obj];
//            }];
//            [strongSelf.table reloadData];
//        }
//        [weakSelf.table.mj_header endRefreshing];
//    } ofFail:^{
//        [weakSelf showTableAlpha:0];
//        [weakSelf.table.mj_header endRefreshing];
//    }];
}

//数据回来展示table
- (void)showTableAlpha:(float)alpha
{
    self.table.alpha = alpha;
    //self.notConnectControl.alpha = !self.table.alpha;
}

- (void)setupUI;
{
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"活动消息"];
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_MsgActivityCell class]) bundle:nil] forCellReuseIdentifier:@"msgActivityCell"];
    self.table.mj_header = [Fcgo_RefreshNormalHeader headerRefreshBlock:^{
        //[weakSelf reloadRequest];
        [weakSelf.table.mj_header endRefreshing];
    }];
    [self.view insertSubview:self.table belowSubview:self.navigationView];
}
#pragma mark table delegate datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return self.msgMutableArray.count;
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//   Fcgo_MsgActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"msgActivityCell"];
//    if (self.msgMutableArray.count>0) {
//        Fcgo_MsgModel *msgModel = self.msgMutableArray[indexPath.row];
//        cell.msgModel = msgModel;
//    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    if(self.msgMutableArray.count>0)
    {
//        Fcgo_MsgModel *model = self.msgMutableArray[indexPath.row];
//        cell.textLabel.text = model.f_title;
//        cell.detailTextLabel.text = model.f_created;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 135+(kScreenWidth-20-24)*276/614;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}

#pragma mark Lazy method

- (UITableView *)table
{
    if (!_table) {
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight - kNavigationHeight) style:UITableViewStylePlain];
        table.backgroundColor = UIBackGroundColor;
        table.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
        table.delegate = self;
        table.dataSource = self;
        table.separatorStyle = 0;
        table.alpha = 1;
        _table = table;
        if (@available(iOS 11.0, *)) {
            table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _table;
}

- (NSMutableArray *)msgMutableArray
{
    if (!_msgMutableArray) {
        _msgMutableArray = [[NSMutableArray alloc]init];
    }
    return _msgMutableArray;
}

@end
