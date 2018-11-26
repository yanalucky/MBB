//
//  Fcgo_AfterSalesApplyVC.m
//  Fcgo
//
//  Created by fcg on 2017/10/24.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//
#import "Fcgo_AfterSalesApplyVC.h"
#import "Fcgo_AfterSalesServiceCell.h"
#import "Fcgo_AfterSalesServiceListModel.h"
#import "Fcgo_AfterSaleApplyCell.h"

#import "Fcgo_AfterSalesService_DetailVC.h"
#import "Fcgo_AfterSalesService_ReviewVC.h"
#import "Fcgo_AfterServiceStyleVC.h"

@interface Fcgo_AfterSalesApplyVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView    *table;
@property (nonatomic,strong) NSMutableArray *orderListArray;
@property (nonatomic,assign) NSInteger    page;

@end

@implementation Fcgo_AfterSalesApplyVC

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
- (void)requestAfterSales:(NSNotification *)notification{
    WEAKSELF(weakSelf);
    NSMutableDictionary  *paremetwers = [NSMutableDictionary dictionary];
    [paremetwers setObjectWithNullValidate:[NSNumber numberWithInteger:self.page] forKey:@"page"];
    [paremetwers setObjectWithNullValidate:@12 forKey:@"limit"];
    [paremetwers setObjectWithNullValidate:@0 forKey:@"texe"];

    if (notification) {
        weakSelf.page = 1;
        [paremetwers setObjectWithNullValidate:[NSNumber numberWithInteger:self.page] forKey:@"page"];
        if ([notification.userInfo[@"type"] intValue] == 0) {
            [paremetwers setObjectWithNullValidate:(notification.userInfo[@"texe"])?(notification.userInfo[@"texe"]):@0 forKey:@"texe"];
            
            [paremetwers setObjectWithNullValidate:notification.userInfo[@"payTimeStart"] forKey:@"startDate"];
            [paremetwers setObjectWithNullValidate:[NSString stringWithFormat:@"%@",[[NSDate date] dateByAddingTimeInterval:60*60*8]] forKey:@"endDate"];
            [paremetwers setObjectWithNullValidate:@"" forKey:@"resource"];
        }
        
        if ([notification.userInfo objectForKey:@"searchInfo"]&&weakSelf.isSearch == YES) {
            [paremetwers setObjectWithNullValidate:[notification.userInfo objectForKey:@"searchInfo"] forKey:@"searchInfo"];
        }
    }
    
    
    [WSProgressHUD showWithStatus:@"加载中..." maskType:WSProgressHUDMaskTypeClear];

    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, ORDERMETHOD, @"canApplyOrder") parametersContentCommon:paremetwers successBlock:^(BOOL success, id responseObject, NSString *msg) {
        
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
                    
//                    Fcgo_AfterSalesServiceListModel *model = [Fcgo_AfterSalesServiceListModel yy_modelWithDictionary:(NSDictionary *)obj];
                    
                    [weakSelf.orderListArray addObject:(NSDictionary *)obj];
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
        //假数据
//        for (int i=0; i<5; i++) {
//            Fcgo_AfterSalesServiceListModel *model = [[Fcgo_AfterSalesServiceListModel alloc] init];
//            model.created = @"2017-09-18";
//            model.orderNo = @"21fdfjwfoewe2325fewfrw2323";
//            model.picurl = @"http://file01.16sucai.com/d/file/2013/0808/20130808101224471.jpg";
//            model.goodsName = @"花王纸尿布 h5 哈哈哈 蜂窝网为我而放任发文 哈哈哈 蜂窝网为我而放任 哈哈哈 蜂窝网为我而放任";
//            model.money = @100;
//            model.num = @6;
//            model.refundMoney = @150;
//            model.status = @100;
//            [self.orderListArray addObject:model];
//        }
//        [self.table reloadData];
        //假数据结束
        
        
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
    [self showNoControl:!isShow titleString:@"暂无可售后订单" imageString:@"ico_no-order"];
    self.table.hidden = !isShow;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationView.hidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadRequest) name:@"applyFinish" object:nil];
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
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_AfterSaleApplyCell class]) bundle:nil] forCellReuseIdentifier:@"Fcgo_AfterSaleApplyCell"];
    
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


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return kAutoHeight6(43);
}
-(void)copyAfterNum:(UITapGestureRecognizer *)tap{
    UILabel *lab = (UILabel *)tap.view;
    UIPasteboard * pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:[[lab.text componentsSeparatedByString:@"："] lastObject]];
    [WSProgressHUD showImage:nil status:@"订单号已复制"];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kAutoHeight6(43))];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kAutoHeight6(4))];
    lineView.backgroundColor = UIBackGroundColor;
    [view addSubview:lineView];
    view.backgroundColor = UIFontWhiteColor;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kAutoWidth6(12), kAutoHeight6(4), kScreenWidth - kAutoWidth6(24), kAutoHeight6(39))];
    label.textColor = UIFontSortGrayColor;
    label.font = UIFontSize(12);
    label.text = [NSString stringWithFormat:@"订单号：%@",[self.orderListArray[section] objectForKey:@"orderNo"]];
    label.userInteractionEnabled = YES;
    [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(copyAfterNum:)]];
    [view addSubview:label];
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, kAutoHeight6(43), kScreenWidth, 0.5)];
    line.backgroundColor = UINavSepratorLineColor;
    [view addSubview:line];
    return view;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.orderListArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.orderListArray.count>0) {
      NSArray *array = [self.orderListArray[section] objectForKey:@"afterSaleList"];
        return array.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Fcgo_AfterSaleApplyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Fcgo_AfterSaleApplyCell"];
    
    if (self.orderListArray.count>0) {
        NSArray *array = [self.orderListArray[indexPath.section] objectForKey:@"afterSaleList"];
        Fcgo_AfterSalesServiceListModel *model = [Fcgo_AfterSalesServiceListModel yy_modelWithDictionary:array[indexPath.row]];
        cell.model = model;
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kAutoHeight6(141);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    WEAKSELF(weakSelf)
    if (self.orderListArray.count>0) {
//        Fcgo_AfterSalesService_DetailVC *vc = [[Fcgo_AfterSalesService_DetailVC alloc]init];
//        vc.hidesBottomBarWhenPushed = 1;
//        Fcgo_AfterSalesServiceListModel *model = self.orderListArray[indexPath.row];
//        vc.f_apply_id = [NSString stringWithFormat:@"%@",model.f_apply_id];
//        vc.cancelApplyBlock = ^{
//            weakSelf.page = 1;
//            [weakSelf requestAfterSales];
//        };
        
        NSArray *array = [self.orderListArray[indexPath.section] objectForKey:@"afterSaleList"];
        Fcgo_AfterSalesServiceListModel *model = [Fcgo_AfterSalesServiceListModel yy_modelWithDictionary:array[indexPath.row]];
        Fcgo_AfterServiceStyleVC *vc = [[Fcgo_AfterServiceStyleVC alloc] init];
        vc.model = model;
        vc.backVC = self.backVC;
        [self.navigationController pushViewController:vc animated:1];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Lazy method

- (UITableView *)table
{
    if (!_table) {
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.bounds.size.height - kNavigationHeight - ((_isSearch == YES)?0:44)) style:UITableViewStyleGrouped];
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

