//
//  Fcgo_CollectVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/3.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_CollectVC.h"
#import "Fcgo_GoodsListTableCell.h"
#import "Fcgo_GoodsDetailVC.h"
#import "Fcgo_HomeViewModel.h"
@interface Fcgo_CollectVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView      *table;
@property (nonatomic,strong) NSMutableArray   *goodsListMutableArray;
@property (nonatomic,assign) NSInteger page;
@end

@implementation Fcgo_CollectVC

- (void)reloadRequest
{
    if (![Fcgo_Tools isNetworkConnected]) {
        [WSProgressHUD showImage:nil status:@"亲,没联网啊"];
        [self showUIData:NO];
        return;
    }
    [self loadGoodsListRequest];
}

- (void)loadGoodsListRequest
{
    WEAKSELF(weakSelf)
    [WSProgressHUD showWithStatus:@"加载中..." maskType:WSProgressHUDMaskTypeClear];
    
    NSMutableDictionary   *paremtes = [NSMutableDictionary dictionary];
    [paremtes setObjectWithNullValidate:[NSNumber numberWithInteger:self.page] forKey:@"page"];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, @"mch/favorite/", @"list") parametersContentCommon:paremtes successBlock:^(BOOL success, id responseObject, NSString *msg) {
        [WSProgressHUD dismiss];
        if(self.page == 1)
        {
        [weakSelf.goodsListMutableArray removeAllObjects];
        }
        if (success) {
            [weakSelf showUIData:1];
            NSArray *arr=(NSArray *)responseObject[@"data"];
            for (int i=0; i<arr.count; i++) {
                if ([arr[i] isKindOfClass:[NSDictionary class]]) {
                    Fcgo_HomeGoodsModel *model = [Fcgo_HomeGoodsModel yy_modelWithDictionary:arr[i]];
                    [weakSelf.goodsListMutableArray addObject:model];
                }
            }
            
            if (weakSelf.goodsListMutableArray.count<=0) {
               [weakSelf showMoreUIData:0];
                self.navigationView.navRightTitleBtn.hidden = 1;
            }
            else{
                [weakSelf showMoreUIData:1];
                self.navigationView.navRightTitleBtn.hidden = 0;
            }
            
            [weakSelf.table reloadData];
            [weakSelf.table.mj_footer resetNoMoreData];
            if(arr.count<10)
            {
                [weakSelf.table.mj_footer endRefreshingWithNoMoreData];
            }
            else if (weakSelf.table.mj_footer.isRefreshing) {
                weakSelf.page = self.page + 1;
                [weakSelf.table.mj_footer endRefreshing];
            }            
        }else
        {
            self.navigationView.navRightTitleBtn.hidden = 1;
            [weakSelf showUIData:0];
        }
        [weakSelf.table.mj_header endRefreshing];
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
    [self showNoControl:!isShow titleString:@"暂无收藏" imageString:@"ico_no-collect"];
    self.table.hidden = !isShow;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
    self.page = 1;
    [self reloadRequest];
}

- (void)setupUI;
{
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
//    [self.navigationView setupRightBtnBlock:^{
//        if (weakSelf.goodsListMutableArray.count<=0) {
//            [WSProgressHUD showImage:nil status:@"暂无收藏"];
//            return ;
//        }
//        [Fcgo_AlertAnimationView showWithTitle:@"提示" text:@"这是清空所有收藏列表的操作呦" cancelTitle:@"取消" confirmTitle:@"确定" block:^{
//            [weakSelf deleteCollectGoodsWithGoodsIds:@"" block:^{}];
//            [self.goodsListMutableArray removeAllObjects];
//            [self.table reloadData];
//        }];
//    }];
    
    [self.navigationView setupRightBtnTitle:@"清空" Block:^{
        if (weakSelf.goodsListMutableArray.count<=0) {
            [WSProgressHUD showImage:nil status:@"暂无收藏"];
            return ;
        }
        [Fcgo_AlertAnimationView showWithTitle:@"提示" text:@"清空所有收藏列表?" cancelTitle:@"取消" confirmTitle:@"确定" block:^{
            [weakSelf deleteCollectGoodsWithGoodsIds:@"" block:^{}];
            [self.goodsListMutableArray removeAllObjects];
            [self.table reloadData];
        }];
        
    }];
    
    self.navigationView.navRightTitleBtn.hidden = 1;
    
    [self.navigationView setupTitleLabelWithTitle:@"我的收藏"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_GoodsListTableCell class]) bundle:nil] forCellReuseIdentifier:@"goodsListTableCell"];
    
    self.table.mj_header = [Fcgo_RefreshNormalHeader headerRefreshBlock:^{
        self.page = 1;
        [weakSelf reloadRequest];
    }];
    self.table.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        
        [weakSelf reloadRequest];
    }];
    [self.view insertSubview:self.table belowSubview:self.navigationView];
}

- (void)deleteCollectGoodsWithGoodsIds:(NSString *)goodsIds block:(void(^)(void))block
{
    WEAKSELF(weakSelf)
    NSMutableDictionary   *paremtes = [NSMutableDictionary dictionary];
    [paremtes  setObjectWithNullValidate:goodsIds forKey:@"goodsId"];
   [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, @"mch/favorite/", @"del") parametersContentCommon:paremtes successBlock:^(BOOL success, id responseObject, NSString *msg)  {
        if (success) {
            NSNumber *errCode = responseObject[@"errorCode"];
            if (errCode.intValue == 0) {
                [WSProgressHUD showImage:nil status:@"删除成功"];
                if ([goodsIds isEqualToString:@""]) {
                    
                    [weakSelf showMoreUIData:0];
                    if (self.cancelBlock) {
                        self.cancelBlock(@"",YES);
                    }
                    [weakSelf.table reloadData];
                }
                else{
                    block();
                }
                
                id data = responseObject[@"data"];
                
                if ([data isKindOfClass:[NSArray class]]) {
                    
                    if ([(NSArray *)data count]<=0) {
                        [weakSelf showMoreUIData:0];
                        self.navigationView.navRightTitleBtn.hidden = 1;
                    }
                    else{
                        [weakSelf showMoreUIData:1];
                        self.navigationView.navRightTitleBtn.hidden = 0;
                    }
                }
                else{
                    [weakSelf showMoreUIData:0];
                    self.navigationView.navRightTitleBtn.hidden = 1;
                }
                
            }
        }
        
    } failureBlock:^(NSString *description) {
        [weakSelf showUIData:0];
    }];
}

#pragma mark table delegate datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.goodsListMutableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Fcgo_GoodsListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"goodsListTableCell"];
    cell.model = self.goodsListMutableArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80+10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.goodsListMutableArray.count>0) {
        Fcgo_HomeGoodsModel *model = self.goodsListMutableArray[indexPath.row];
        Fcgo_GoodsDetailVC *vc = [[Fcgo_GoodsDetailVC alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
        vc.goodsType = @"normal";
        vc.goodsValue = [NSString stringWithFormat:@"%@",model.f_goods_id];
        [self.navigationController pushViewController:vc animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //发送删除的请求
        Fcgo_HomeGoodsModel *model = self.goodsListMutableArray[indexPath.row];
        [self deleteCollectGoodsWithGoodsIds:[NSString stringWithFormat:@"%@",model.f_goods_id] block:^{
            
            if (self.cancelBlock) {
                self.cancelBlock([NSString stringWithFormat:@"%@",model.f_goods_id],NO);
            }
            [self.goodsListMutableArray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
    }];
    NSArray *array = @[action];
    return array;
}

#pragma mark - Lazy method
- (UITableView *)table
{
    if (!_table) {
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight - kNavigationHeight) style:UITableViewStylePlain];
        table.contentInset = UIEdgeInsetsMake(0, 0, 40, 0);
        table.delegate = self;
        table.dataSource = self;
        table.separatorStyle = 0;
        table.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _table = table;
        if (@available(iOS 11.0, *)) {
            table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _table;
}

- (NSMutableArray *)goodsListMutableArray
{
    if (!_goodsListMutableArray) {
        _goodsListMutableArray = [[NSMutableArray alloc]init];
    }
    return _goodsListMutableArray;
}

@end
