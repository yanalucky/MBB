//
//  Fcgo_OrderSearchBaseVC.m
//  Fcgo
//
//  Created by by_r on 2017/11/28.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_OrderSearchBaseVC.h"
#import "Fcgo_OrderPayVC.h"
#import "Fcgo_GoodsDetailVC.h"
#import "Fcgo_OrderDetailVC.h"

@interface Fcgo_OrderSearchBaseVC ()

@end

@implementation Fcgo_OrderSearchBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.page = 1;
    [self setupUI];
}
#pragma mark - private method
- (void)contactServiceWithModel:(Fcgo_OrderListModel *)model {
    Fcgo_OrderListGoodsModel *obj = [model.goodsList firstObject];
    NSMutableDictionary *dict = @{}.mutableCopy;
    [dict setValue:model.orderNo forKey:commodityInfoTitle];
    [dict setValue:obj.goodsName forKey:commodityInfoDes];
    [dict setValue:obj.picurl forKey:commodityInfoPic];
    [dict setValue:@"从搜索或筛选订单列表进入" forKey:commodityInfoNote];
    [[Fcgo_QYIM_JumpTools sharedInstance] qy_jumpWithTitle:nil
                                                 urlString:nil
                                                customInfo:nil
                                              sessionTitle:nil
                                   commodityInfoDictionary:dict.copy];
}
#pragma mark public method
- (void)refresh:(BOOL)isTop {}

#pragma mark - UI
- (void)setupUI {
    WEAKSELF(weakSelf);
    Fcgo_AllOrderView *allOrderView = [[Fcgo_AllOrderView alloc] initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight - kNavigationHeight)];
    allOrderView.hidden = YES;
    /// 下拉刷新
    allOrderView.refreshTopBlock = ^{
        weakSelf.page = 1;
        [weakSelf refresh:YES];
    };
    /// 加载更多
    allOrderView.refreshBottomBlock = ^{
        weakSelf.page ++;
        [weakSelf refresh:NO];
    };
    /// 支付
    allOrderView.payBlock = ^(Fcgo_OrderListModel *model) {
        Fcgo_OrderPayVC *vc = [[Fcgo_OrderPayVC alloc] init];
        vc.orderNo = model.orderNo;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    /// 再次购买
    allOrderView.againBlock = ^(Fcgo_OrderListModel *model) {
        Fcgo_GoodsDetailVC *vc = [[Fcgo_GoodsDetailVC alloc] init];
        Fcgo_OrderListGoodsModel *goodsModel = [model.goodsList firstObject];
        vc.goodsType = @"normal";
        vc.goodsValue = goodsModel.goodsId.stringValue;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    /// 客服
    allOrderView.serviceBlock = ^(Fcgo_OrderListModel *model) {
        [weakSelf contactServiceWithModel:model];
    };
    /// 点击订单
    allOrderView.didSelectedOrderBlock = ^(Fcgo_OrderListModel *model) {
        Fcgo_OrderDetailVC *vc = [[Fcgo_OrderDetailVC alloc] init];
        vc.orderId = model.ID.stringValue;
        vc.disappearBlock = ^{
            [weakSelf refresh:YES];
        };
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    [self.view insertSubview:allOrderView belowSubview:self.navigationView];
    _allOrderView = allOrderView;
}

- (void)showUIData:(BOOL)isShow {
    [self showNoControl:!isShow titleString:@"网络错误，点击重新加载" imageString:@"ico_no-wifi"];
    [self updateNoControlFrame];
    self.allOrderView.hidden = !isShow;
}

- (void)showMoreUIData:(BOOL)isShow {
    [self showNoControl:!isShow titleString:@"搜索无结果" imageString:@"ico_no-order"];
    [self updateNoControlFrame];
    self.allOrderView.hidden = !isShow;
}

@end
