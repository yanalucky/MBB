//
//  Fcgo_AfterSalesServiceVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/14.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_AfterSalesServiceVC.h"
#import "Fcgo_AfterSalesServiceCell.h"
#import "Fcgo_AfterSalesServiceListModel.h"

#import "Fcgo_AfterSalesService_DetailVC.h"
#import "Fcgo_AfterSalesService_ReviewVC.h"
#import "Fcgo_ApplyHistoryVC.h"

@interface Fcgo_AfterSalesServiceVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView    *table;
@property (nonatomic,strong) NSMutableArray *orderListArray;
@property (nonatomic,assign) NSInteger    page;

@end

@implementation Fcgo_AfterSalesServiceVC

- (void)reloadRequest
{
    if (![Fcgo_Tools isNetworkConnected]) {
        [WSProgressHUD showImage:nil status:@"亲,没联网啊"];
        [self showUIData:NO];
        return;
    }
    
    self.page = 1;
    [WSProgressHUD showWithStatus:@"加载中..." maskType:WSProgressHUDMaskTypeClear];
    [self requestAfterSales:nil];

}

- (void)requestAfterSales:(NSNotification *)notification
{
    WEAKSELF(weakSelf);
    NSMutableDictionary  *paremetwers = [NSMutableDictionary dictionary];
    [paremetwers setObjectWithNullValidate:[NSNumber numberWithInteger:self.page] forKey:@"page"];
    [paremetwers setObjectWithNullValidate:@12 forKey:@"limit"];
    if (notification) {
        weakSelf.page = 1;
        [paremetwers setObjectWithNullValidate:[NSNumber numberWithInteger:self.page] forKey:@"page"];
        //筛选
        if ([notification.userInfo[@"type"] intValue] == 1) {
            NSArray *afterSiftTypeArr = @[@"",@"申请补偿",@"仅退款",@"退货退款"];
            NSString *afterSiftTypeStr = afterSiftTypeArr[[notification.userInfo[@"texe"] intValue]];
            [paremetwers setObjectWithNullValidate:afterSiftTypeStr forKey:@"afterSaleType"];
            [paremetwers setObjectWithNullValidate:notification.userInfo[@"payTimeStart"] forKey:@"startDate"];
            [paremetwers setObjectWithNullValidate:[NSString stringWithFormat:@"%@",[[NSDate date] dateByAddingTimeInterval:60*60*8]] forKey:@"endDate"];
//            [paremetwers setObjectWithNullValidate:@"" forKey:@"resource"];
        }
        //刷新
        if ([notification.userInfo objectForKey:@"searchInfo"]&&weakSelf.isSearch == YES) {
            [paremetwers setObjectWithNullValidate:[notification.userInfo objectForKey:@"searchInfo"] forKey:@"searchInfo"];
        }
    }
    [WSProgressHUD showWithStatus:@"加载中..." maskType:WSProgressHUDMaskTypeClear];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, ORDERMETHOD, @"alreadyApplyOrder") parametersContentCommon:paremetwers successBlock:^(BOOL success, id responseObject, NSString *msg) {
        [weakSelf.table.mj_header endRefreshing];
        if (success) {
            [weakSelf showUIData:1];
            if (weakSelf.page == 1) {
                [weakSelf.orderListArray removeAllObjects];
            }
            NSArray *listArray = responseObject[@"data"][@"data"];
            if (listArray &&listArray.count>0) {
                NSInteger count = weakSelf.orderListArray.count;
                [listArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    Fcgo_AfterSalesServiceListModel *model = [Fcgo_AfterSalesServiceListModel yy_modelWithDictionary:(NSDictionary *)obj];
                    
                    [weakSelf.orderListArray addObject:model];
                }];
                [weakSelf.table reloadData];

            }
            [weakSelf.table.mj_footer resetNoMoreData];
            if (listArray.count<10) {
                [weakSelf.table.mj_footer endRefreshingWithNoMoreData];
            }
            else
            {
                weakSelf.page += 1;
                [weakSelf.table.mj_footer endRefreshing];
            }
            if (weakSelf.orderListArray.count<=0) {
                [self showMoreUIData:NO];
            }else{
                [self showMoreUIData:YES];
            }
            [WSProgressHUD dismiss];
        }
        else
        {
            [weakSelf showUIData:0];
        }
        

    } failureBlock:^(NSString *description) {
        [weakSelf showUIData:0];
        [weakSelf.table.mj_header endRefreshing];
        [weakSelf.table.mj_footer endRefreshing];
    }];
}


- (void)showUIData:(BOOL)isShow
{
    [self showNoControl:!isShow titleString:@"网络错误,点击重新加载" imageString:@"ico_no-wifi"];
    self.table.hidden = !isShow;
}

- (void)showMoreUIData:(BOOL)isShow
{
    [self showNoControl:!isShow titleString:@"暂无售后订单" imageString:@"ico_no-order"];
    self.table.hidden = !isShow;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationView.hidden = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadRequest) name:@"applyFinish" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestAfterSales:) name:@"siftWithDic" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestAfterSales:) name:@"Search" object:nil];

    [self setupUI];
    self.page = 1;
    [self reloadRequest];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)setupUI;
{
    WEAKSELF(weakSelf)
//    [self.navigationView setupBackBtnBlock:^{
//        [weakSelf.navigationController popViewControllerAnimated:YES];
//    }];
//    [self.navigationView setupTitleLabelWithTitle:@"售后服务"];
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_AfterSalesServiceCell class]) bundle:nil] forCellReuseIdentifier:@"afterSalesServiceCell"];
    
    self.table.mj_header = [Fcgo_RefreshNormalHeader headerRefreshBlock:^{
        [weakSelf reloadRequest];
    }];
    
    self.table.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        [weakSelf requestAfterSales:nil];
    }];
    [self.view addSubview:self.table];
//    [self.view insertSubview:self.table belowSubview:self.navigationView];
}

#pragma mark table delegate datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.orderListArray.count>0) {
        return self.orderListArray.count;
        
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Fcgo_AfterSalesServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"afterSalesServiceCell"];
    
    if (self.orderListArray.count>0) {
        Fcgo_AfterSalesServiceListModel *model = self.orderListArray[indexPath.row];
        cell.model = model;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kAutoHeight6(80+128);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF(weakSelf)
    if (self.orderListArray.count>0) {
//        Fcgo_AfterSalesService_DetailVC *vc = [[Fcgo_AfterSalesService_DetailVC alloc]init];
//        vc.hidesBottomBarWhenPushed = 1;
        Fcgo_AfterSalesServiceListModel *model = self.orderListArray[indexPath.row];
//        vc.f_apply_id = [NSString stringWithFormat:@"%@",model.f_apply_id];
//        vc.cancelApplyBlock = ^{
//            weakSelf.page = 1;
//            [weakSelf requestAfterSales];
//        };
        
        Fcgo_ApplyHistoryVC *vc = [[Fcgo_ApplyHistoryVC alloc] init];
        vc.applyId = model.f_apply_id;
//        vc.status = model.status;
        [self.navigationController pushViewController:vc animated:1];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Lazy method

- (UITableView *)table
{
    if (!_table) {
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.bounds.size.height - kNavigationHeight - ((_isSearch == YES)?0:44)) style:UITableViewStylePlain];
        table.delegate = self;
        table.dataSource = self;
        table.separatorStyle = 0;
        table.backgroundColor = UIBackGroundColor;
        _table = table;
        if (@available(iOS 11.0, *)) {
            table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _table;
}

- (NSMutableArray *)orderListArray
{
    if (!_orderListArray) {
        _orderListArray = [[NSMutableArray alloc]init];
    }
    return _orderListArray;
}

@end

