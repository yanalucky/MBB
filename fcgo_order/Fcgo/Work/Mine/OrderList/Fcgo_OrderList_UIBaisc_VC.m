//
//  Fcgo_OrderList_UIBaisc_VC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/22.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderList_UIBaisc_VC.h"
#import "Fcgo_AllOrderView.h"
#import "Fcgo_OrderList_KJAndHW_View.h"
#import "Fcgo_OrderList_YB_View.h"
#import "Fcgo_OrderListModel.h"
#import "Fcgo_GoodsDetailVC.h"
#import "Fcgo_OrderDetailVC.h"
#import "Fcgo_ContactServiceVC.h"
#import "Fcgo_OrderPayVC.h"

@interface Fcgo_OrderList_UIBaisc_VC ()

@property (nonatomic,strong) NSMutableArray *listArray;
@property (nonatomic,strong) Fcgo_AllOrderView           *allOrderView;
@property (nonatomic,strong) Fcgo_OrderList_KJAndHW_View *kjAndHW_View;
@property (nonatomic,strong) Fcgo_OrderList_YB_View      *yb_View;

@property (nonatomic,strong) NSString   *status;//订单状态
@property (nonatomic,assign) NSInteger   page;
@end

@implementation Fcgo_OrderList_UIBaisc_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationView.isShowLine = 0;
    self.page = 1;
    [self setupUI];
}
#pragma mark - private method
- (void)reloadRequest {
    if (![Fcgo_Tools isNetworkConnected]) {
        [WSProgressHUD showImage:nil status:@"亲,没联网啊"];
        [self showUIData:NO];
        return;
    }
    self.page = 1;
    [WSProgressHUD showWithStatus:@"加载中..." maskType:WSProgressHUDMaskTypeClear];
    [self requestOrderListWithStatus:self.status page:self.page];
}

- (void)requestOrderListWithStatus:(NSString *)status page:(NSInteger)page {
    WEAKSELF(weakSelf);
    NSMutableDictionary  *muatble = [NSMutableDictionary dictionary];
    [muatble  setObjectWithNullValidate:[NSString stringWithFormat:@"%ld",(long)self.page] forKey:@"page"];
    [muatble setObjectWithNullValidate:@"10" forKey:@"rows"];
    
    if (self.type == 0) {
        [muatble  setObjectWithNullValidate:@"" forKey:@"texe"];
    }else{
        [muatble  setObjectWithNullValidate:[NSString stringWithFormat:@"%ld",(long)self.type] forKey:@"texe"];
    }
    [muatble setObjectWithNullValidate:self.status forKey:@"status"];
    
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, ORDERMETHOD, @"orderList") parametersContentCommon:muatble successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            if (self.page == 1) {
                [weakSelf.listArray removeAllObjects];
            }
            NSMutableArray *listArray = [NSMutableArray array];
            NSArray *list = responseObject[@"data"][@"list"];
            for (int i = 0; i < list.count; i ++) {
                NSDictionary *listDict = list[i];
                Fcgo_OrderListModel *model = [Fcgo_OrderListModel yy_modelWithDictionary:listDict];//[Fcgo_OrderListModel shareWithNSDictionary:listDict];
                [listArray addObject:model];
                [weakSelf.listArray addObject:model];
            }
            if (weakSelf.page == 1) {
                if (weakSelf.type == 0) {
                   [weakSelf.allOrderView setOrderListWithArray:listArray];
                }
                else if (weakSelf.type == 1) {
                    [weakSelf.yb_View setOrderListWithArray:listArray];
                }
                else{
                    [weakSelf.kjAndHW_View setOrderListWithArray:listArray];
                }
            }
            else {
                if (weakSelf.type == 0) {
                    [weakSelf.allOrderView addOrderListWithArray:listArray];
                }
                else if (weakSelf.type == 1) {
                    [weakSelf.yb_View addOrderListWithArray:listArray];
                }
                else {
                    [weakSelf.kjAndHW_View addOrderListWithArray:listArray];
                }
            }
            
            [weakSelf.allOrderView.table.mj_footer resetNoMoreData];
            [weakSelf.yb_View.table.mj_footer resetNoMoreData];
            [weakSelf.kjAndHW_View.table.mj_footer resetNoMoreData];
            
            
            if (list.count<10) {
                [weakSelf.allOrderView.table.mj_footer endRefreshingWithNoMoreData];
                [weakSelf.yb_View.table.mj_footer endRefreshingWithNoMoreData];
                [weakSelf.kjAndHW_View.table.mj_footer endRefreshingWithNoMoreData];
            }
            else {
                weakSelf.page += 1;
                [weakSelf.allOrderView.table.mj_footer endRefreshing];
                [weakSelf.yb_View.table.mj_footer      endRefreshing];
                [weakSelf.kjAndHW_View.table.mj_footer endRefreshing];
            }
           if (weakSelf.listArray.count<=0) {
                [weakSelf showMoreUIData:0];
           }
           else {
               [weakSelf showMoreUIData:1];
           }
            weakSelf.allOrderView.status = weakSelf.status;
            weakSelf.yb_View.status = weakSelf.status;
            weakSelf.kjAndHW_View.status = weakSelf.status;
        }
        else {
            [weakSelf showUIData:0];
        }
        [weakSelf.allOrderView.table.mj_header endRefreshing];
        [weakSelf.yb_View.table.mj_header endRefreshing];
        [weakSelf.kjAndHW_View.table.mj_header endRefreshing];
    } failureBlock:^(NSString *description) {
        [weakSelf showUIData:0];
        [weakSelf.allOrderView.table.mj_header endRefreshing];
        [weakSelf.yb_View.table.mj_header endRefreshing];
        [weakSelf.kjAndHW_View.table.mj_header endRefreshing];
    }];
}

- (void)showUIData:(BOOL)isShow {
    [self showNoControl:!isShow titleString:@"网络错误,点击重新加载" imageString:@"ico_no-wifi"];
    
    [self updateNoControlFrame];
    if (self.type == 0) {
        self.allOrderView.hidden = !isShow;
        self.yb_View.hidden = 1;
        self.kjAndHW_View.hidden = 1;
    }
    else if (self.type == 1) {
        self.allOrderView.hidden = 1;
        self.yb_View.hidden = !isShow;
        self.kjAndHW_View.hidden = 1;
    }
    else{
        self.allOrderView.hidden = 1;
        self.yb_View.hidden = 1;
        self.kjAndHW_View.hidden = !isShow;
    }
}

- (void)showMoreUIData:(BOOL)isShow {
    [self showNoControl:!isShow titleString:@"暂无订单" imageString:@"ico_no-order"];
    [self updateNoControlFrame];
    if (self.type == 0) {
        self.allOrderView.hidden = !isShow;
        self.yb_View.hidden = 1;
        self.kjAndHW_View.hidden = 1;
    }
    else if (self.type == 1) {
        self.allOrderView.hidden = 1;
        self.yb_View.hidden = !isShow;
        self.kjAndHW_View.hidden = 1;
    }
    else{
        self.allOrderView.hidden = 1;
        self.yb_View.hidden = 1;
        self.kjAndHW_View.hidden = !isShow;
    }
}

- (void)contactServiceWithModel:(Fcgo_OrderListModel *)model {
    Fcgo_OrderListGoodsModel *obj = [model.goodsList firstObject];
    NSMutableDictionary *dict = @{}.mutableCopy;
    [dict setValue:model.orderNo forKey:commodityInfoTitle];
    [dict setValue:obj.goodsName forKey:commodityInfoDes];
    [dict setValue:obj.picurl forKey:commodityInfoPic];
    [dict setValue:@"从订单列表进入" forKey:commodityInfoNote];
    [[Fcgo_QYIM_JumpTools sharedInstance] qy_jumpWithTitle:nil
                                                 urlString:nil
                                                customInfo:nil
                                              sessionTitle:nil
                                   commodityInfoDictionary:dict.copy];
}

- (void)setType:(NSInteger)type {
    _type = type;
    if (self.type == 0) {
        self.allOrderView.hidden = 0;
        self.yb_View.hidden = 1;
        self.kjAndHW_View.hidden = 1;
    }
    else if (type == 1) {
        self.allOrderView.hidden = 1;
        self.yb_View.hidden = 0;
        self.kjAndHW_View.hidden = 1;
    }
    else {
        self.allOrderView.hidden = 1;
        self.yb_View.hidden = 1;
        self.kjAndHW_View.hidden = 0;
    }
}
#pragma mark public
//获取订单列表
- (void)requestOrderListWithStatus:(NSString *)status {
    self.status = status;
    [self reloadRequest];
}
#pragma mark - UI
- (void)setupUI {
    WEAKSELF(weakSelf);
    ///////////////////////////////////////////////////////////////
    /*                     全部贸易                    */
    self.allOrderView.refreshTopBlock = ^{
        [weakSelf requestOrderListWithStatus:weakSelf.status];
    };
    self.allOrderView.refreshBottomBlock = ^{
        [weakSelf requestOrderListWithStatus:weakSelf.status page:weakSelf.page];
    };
    self.allOrderView.payBlock = ^(Fcgo_OrderListModel *model){
        Fcgo_OrderPayVC *vc = [[Fcgo_OrderPayVC alloc] init];
        vc.orderNo = model.orderNo;
        vc.hidesBottomBarWhenPushed = 1;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    self.allOrderView.againBlock = ^(Fcgo_OrderListModel *model){
        Fcgo_GoodsDetailVC *vc = [[Fcgo_GoodsDetailVC alloc]init];
        Fcgo_OrderListGoodsModel *goodsModel = [model.goodsList firstObject];
        vc.goodsType = @"normal";
        vc.goodsValue = [NSString stringWithFormat:@"%@",goodsModel.goodsId];
        vc.hidesBottomBarWhenPushed = 1;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    self.allOrderView.serviceBlock = ^(Fcgo_OrderListModel *model) {
        [weakSelf contactServiceWithModel:model];
    };
    self.allOrderView.didSelectedOrderBlock = ^(Fcgo_OrderListModel *model){
        Fcgo_OrderDetailVC *vc = [[Fcgo_OrderDetailVC alloc]init];
        vc.orderId = [NSString stringWithFormat:@"%@",model.ID];
        vc.hidesBottomBarWhenPushed =  1;
        vc.disappearBlock = ^{
            [weakSelf reloadRequest];
        };
        [weakSelf.navigationController pushViewController:vc animated:1];
    };
    [self.view addSubview:self.allOrderView];
    
    ///////////////////////////////////////////////////////////////
    /*                     一般贸易                    */
    self.yb_View.refreshTopBlock = ^{
        [weakSelf requestOrderListWithStatus:weakSelf.status];
    };
    self.yb_View.refreshBottomBlock = ^{
        [weakSelf requestOrderListWithStatus:weakSelf.status page:weakSelf.page];
    };
    self.yb_View.payBlock = ^(Fcgo_OrderListModel *model){
        Fcgo_OrderPayVC *vc = [[Fcgo_OrderPayVC alloc] init];
        vc.orderNo = model.orderNo;
        vc.hidesBottomBarWhenPushed = 1;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    self.yb_View.againBlock = ^(Fcgo_OrderListModel *model){
        Fcgo_GoodsDetailVC *vc = [[Fcgo_GoodsDetailVC alloc]init];
        Fcgo_OrderListGoodsModel *goodsModel = [model.goodsList firstObject];
        vc.goodsType = @"normal";
        vc.goodsValue = [NSString stringWithFormat:@"%@",goodsModel.goodsId];
        vc.hidesBottomBarWhenPushed = 1;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    self.yb_View.serviceBlock = ^(Fcgo_OrderListModel *model) {
        [weakSelf contactServiceWithModel:model];
    };
    self.yb_View.didSelectedOrderBlock = ^(Fcgo_OrderListModel *model){
        Fcgo_OrderDetailVC *vc = [[Fcgo_OrderDetailVC alloc]init];
        vc.orderId = [NSString stringWithFormat:@"%@",model.ID];
        vc.hidesBottomBarWhenPushed =  1;
        vc.disappearBlock = ^{
            [weakSelf reloadRequest];
        };
        [weakSelf.navigationController pushViewController:vc animated:1];
    };
    [self.view addSubview:self.yb_View];
    
    ///////////////////////////////////////////////////////////////
    /*                     海外跨境贸易                     */
    
    self.kjAndHW_View.refreshTopBlock = ^{
        [weakSelf requestOrderListWithStatus:weakSelf.status];
    };
    self.kjAndHW_View.refreshBottomBlock = ^{
        [weakSelf requestOrderListWithStatus:weakSelf.status page:weakSelf.page];
    };
    self.kjAndHW_View.payBlock = ^(Fcgo_OrderListModel *model){
        Fcgo_OrderPayVC *vc = [[Fcgo_OrderPayVC alloc] init];
        vc.orderNo = model.orderNo;
        vc.hidesBottomBarWhenPushed = 1;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    self.kjAndHW_View.againBlock = ^(Fcgo_OrderListModel *model){
        Fcgo_GoodsDetailVC *vc = [[Fcgo_GoodsDetailVC alloc]init];
        Fcgo_OrderListGoodsModel *goodsModel = [model.goodsList firstObject];
        vc.goodsType = @"normal";
        vc.goodsValue = [NSString stringWithFormat:@"%@",goodsModel.goodsId];
        vc.hidesBottomBarWhenPushed = 1;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    self.kjAndHW_View.serviceBlock = ^(Fcgo_OrderListModel *model) {
        [weakSelf contactServiceWithModel:model];
    };
    self.kjAndHW_View.didSelectedOrderBlock = ^(Fcgo_OrderListModel *model){
        Fcgo_OrderDetailVC *vc = [[Fcgo_OrderDetailVC alloc]init];
        vc.orderId = [NSString stringWithFormat:@"%@",model.ID];
        vc.hidesBottomBarWhenPushed =  1;
        vc.disappearBlock = ^{
            
            [weakSelf reloadRequest];
        };
        [weakSelf.navigationController pushViewController:vc animated:1];
    };
    [self.view addSubview:self.kjAndHW_View];
}
#pragma mark - lazy method
- (Fcgo_AllOrderView *)allOrderView {
    if (!_allOrderView) {
        _allOrderView = [[Fcgo_AllOrderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight - kNavigationHeight - 40)];
        _allOrderView.hidden = 1;
    }
    return _allOrderView;
}

- (Fcgo_OrderList_KJAndHW_View *)kjAndHW_View {
    if (!_kjAndHW_View) {
        _kjAndHW_View = [[Fcgo_OrderList_KJAndHW_View alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight - kNavigationHeight - 40)];
        _kjAndHW_View.hidden = 1;
    }
    return _kjAndHW_View;
}

- (Fcgo_OrderList_YB_View *)yb_View {
    if (!_yb_View) {
        _yb_View = [[Fcgo_OrderList_YB_View alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight - kNavigationHeight - 40)];
        _yb_View.hidden = 1;
    }
    return _yb_View;
}

- (NSMutableArray *)listArray {
    if (!_listArray) {
        _listArray = [[NSMutableArray alloc]init];
    }
    return _listArray;
}
@end
