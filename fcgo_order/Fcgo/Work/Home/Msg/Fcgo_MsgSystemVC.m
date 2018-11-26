//
//  Fcgo_MsgSystemVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/22.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_MsgSystemVC.h"
#import "Fcgo_MsgSystemCell.h"
#import "Fcgo_MsgCommonCell.h"
#import "Fcgo_MsgDetailHtmlVC.h"
#import "Fcgo_MsgViewModel.h"
#import "Fcgo_MsgSystemModel.h"


@interface Fcgo_MsgSystemVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView    *table;
@property (nonatomic,strong) NSMutableArray *systemArray;

@end

@implementation Fcgo_MsgSystemVC


- (void)viewDidLoad
{
    [super viewDidLoad];
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
        [weakSelf showUIData:1];
        [weakSelf.table.mj_header endRefreshing];
        //判断请求回来是否有数据
        if (mutableArray &&mutableArray.count>0) {
            [strongSelf.systemArray removeAllObjects];
            [mutableArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [strongSelf.systemArray addObject:obj];
            }];
            [strongSelf.table reloadData];
        }else{
            [strongSelf showMoreUIData:NO];
        }
        
    } ofFail:^{
        [weakSelf showUIData:0];
        [weakSelf.table.mj_header endRefreshing];
    }];
}

- (void)showUIData:(BOOL)isShow
{
    [self showNoControl:!isShow titleString:@"网络错误,点击重新加载" imageString:@"ico_no-wifi"];
    self.table.hidden = !isShow;
}

- (void)showMoreUIData:(BOOL)isShow
{
    [self showNoControl:!isShow titleString:@"暂无消息呦" imageString:@"ico_no-notice"];
    self.table.hidden = !isShow;
}

- (void)setupUI;
{
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"系统消息"];
    
    //[self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_MsgSystemCell class]) bundle:nil] forCellReuseIdentifier:@"msgSystemCell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_MsgCommonCell class]) bundle:nil] forCellReuseIdentifier:@"msgCommonCell"];
    
    self.table.mj_header = [Fcgo_RefreshNormalHeader headerRefreshBlock:^{
        //[weakSelf reloadRequest];
         [weakSelf.table.mj_header endRefreshing];
    }];
    [self.view insertSubview:self.table belowSubview:self.navigationView];
}
#pragma mark table delegate datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.systemArray.count>0) {
        return self.systemArray.count;
    }
   return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    Fcgo_MsgSystemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"msgSystemCell"];
//    if (self.msgMutableArray.count>0) {
//        Fcgo_MsgModel *msgModel = self.msgMutableArray[indexPath.row];
//        cell.msgModel = msgModel;
//    }
    Fcgo_MsgCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"msgCommonCell"];
    if(self.systemArray.count>0)
    {
        Fcgo_MsgSystemModel *model = self.systemArray[indexPath.row];
        cell.titleLabel.text = model.title;
        cell.dateLabel.text = model.created;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return 170;
    return 65;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //没有数据，返回
    
    // 跳转web页
    if(self.systemArray.count>0)
    {
        Fcgo_MsgSystemModel *model = self.systemArray[indexPath.row];
        Fcgo_MsgDetailHtmlVC *detailHtmlVC = [[Fcgo_MsgDetailHtmlVC alloc]init];
        detailHtmlVC.htmlString  = model.content;
        detailHtmlVC.titleString = model.title;
        detailHtmlVC.isShowNavBar = YES;
        [self.navigationController pushViewController:detailHtmlVC animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
        table.backgroundColor = UIBackGroundColor;
        table.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
        table.delegate = self;
        table.dataSource = self;
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
@end

