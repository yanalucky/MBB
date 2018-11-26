//
//  Fcgo_MsgOrderVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/22.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_MsgOrderVC.h"
#import "Fcgo_MsgOrderCell.h"
#import "Fcgo_MsgCommonCell.h"
#import "Fcgo_MsgViewModel.h"
#import "Fcgo_MsgDetailHtmlVC.h"
#import "Fcgo_MsgOrderModel.h"
@interface Fcgo_MsgOrderVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView    *table;

@property (nonatomic,strong) NSMutableArray *msgMutableArray;

@end

@implementation Fcgo_MsgOrderVC


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
    [Fcgo_MsgViewModel postRequestOrderMsgListSuccess:^(NSMutableArray *mutableArray) {
        STRONGSELF(strongSelf);
        [strongSelf showUIData:1];
        [strongSelf.table.mj_header endRefreshing];
        if (mutableArray &&mutableArray.count>0) {
            [strongSelf.msgMutableArray removeAllObjects];
            [mutableArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [strongSelf.msgMutableArray addObject:obj];
            }];
            [strongSelf.table reloadData];
        }
        else{
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
    [self.navigationView setupTitleLabelWithTitle:@"订单消息"];
    
    //[self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_MsgOrderCell class]) bundle:nil] forCellReuseIdentifier:@"msgOrderCell"];
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_MsgCommonCell class]) bundle:nil] forCellReuseIdentifier:@"msgCommonCell"];
    self.table.mj_header = [Fcgo_RefreshNormalHeader headerRefreshBlock:^{
       [weakSelf reloadRequest];
    }];
    [self.view insertSubview:self.table belowSubview:self.navigationView];
}
#pragma mark table delegate datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.msgMutableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Fcgo_MsgOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"msgOrderCell"];
    Fcgo_MsgCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"msgCommonCell"];
    if(self.msgMutableArray.count>0)
    {
        Fcgo_MsgOrderModel *model = self.msgMutableArray[indexPath.row];
        cell.titleLabel.text = model.message;
        cell.dateLabel.text   = model.sendTime;
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return 160;
    return 65;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.msgMutableArray.count>0)
    {
        Fcgo_MsgOrderModel *model = self.msgMutableArray[indexPath.row];
        NSString *string = model.gotoUrl;
        if (!string) {
            return;
        }
        if ( [string isEqualToString:@""]) {
            
            [Fcgo_TextAnimationView showWithTitle:@"订单消息" textString:model.message];
        }
        
        else{
            if ([string containsString:@"app_across"]) {
                [Fcgo_App_acrossTools app_acrossWithJsonString:string webView:nil parentVC:self];
            }
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:1];
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

- (NSMutableArray *)msgMutableArray
{
    if (!_msgMutableArray) {
        _msgMutableArray = [[NSMutableArray alloc]init];
    }
    return _msgMutableArray;
}

@end
