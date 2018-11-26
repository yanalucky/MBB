//
//  Fcgo_AllOrderView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/7/28.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_AllOrderView.h"
#import "Fcgo_OrderList_YB_ViewTableViewCell.h"
#import "Fcgo_OrderList_KJAndHW_ViewTableViewCell.h"

@interface Fcgo_AllOrderView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation Fcgo_AllOrderView

- (void)setOrderListWithArray:(NSMutableArray *)listArray
{
//    if (listArray.count <=0 ) {
//        return;
//    }
    [self.orderListArray removeAllObjects];
    [listArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.orderListArray addObject:obj];
    }];
    [self.table reloadData];
}

- (void)addOrderListWithArray:(NSMutableArray *)listArray
{
    NSInteger count = self.orderListArray.count;
    [listArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.orderListArray addObject:obj];
    }];
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = (int)count; i < self.orderListArray.count; i ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [array addObject:indexPath];
    }
    
    [self.table insertRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationFade];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    WEAKSELF(weakSelf);
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_OrderList_YB_ViewTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"orderList_YB_ViewTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_OrderList_KJAndHW_ViewTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"orderList_KJAndHW_ViewTableViewCell"];
    
    self.table.mj_header = [Fcgo_RefreshNormalHeader headerRefreshBlock:^{
        if (weakSelf.refreshTopBlock) {
            weakSelf.refreshTopBlock();
        }
    }];
    self.table.mj_footer =  [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        if (weakSelf.refreshBottomBlock) {
            weakSelf.refreshBottomBlock();
        }
    }];
    [self addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_offset(0);
    }];
}

#pragma mark order method

- (void)payWithModel:(Fcgo_OrderListModel *)model
{
    
    if (self.payBlock) {
        self.payBlock(model);
    }
}
- (void)cancelWithModel:(Fcgo_OrderListModel *)model
{
    WEAKSELF(weakSelf);
    NSMutableDictionary  *muatble = [NSMutableDictionary dictionary];
    [muatble  setObjectWithNullValidate:[NSString stringWithFormat:@"%@",model.ID] forKey:@"orderId"];
    [WSProgressHUD showWithStatus:@"加载中..." maskType:(WSProgressHUDMaskTypeDefault)];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, ORDERMETHOD, @"cancelOrder") parametersContentCommon:muatble successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            [WSProgressHUD showImage:nil status:@"取消成功"];
            for (int i = 0;  i < weakSelf.orderListArray.count; i ++) {
                Fcgo_OrderListModel *model1 = weakSelf.orderListArray[i];
                if ([model1.ID isEqualToNumber:model.ID]) {
                    //全部订单的view
                    if ([self.status isEqualToString:@""]) {
                        model1.orderStatus = @50;
                        [weakSelf.orderListArray replaceObjectAtIndex:i withObject:model1];
                        [weakSelf.table reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
                    }
                    //待付款的订单
                    else if ([self.status isEqualToString:@"1"]) {
                        [weakSelf.orderListArray removeObject:model1];
                        [weakSelf.table deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
                    }
                }
            }
        }
    } failureBlock:^(NSString *description) {
        
    }];
}

- (void)serviceWithModel:(Fcgo_OrderListModel *)model
{
    if (self.serviceBlock) {
        self.serviceBlock(model);
    }
}

- (void)remindWithModel:(Fcgo_OrderListModel *)model
{
    
    [WSProgressHUD showWithStatus:@"加载中..." maskType:WSProgressHUDMaskTypeClear];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [WSProgressHUD showImage:nil status:@"提醒成功"];
    });
//    NSMutableDictionary  *muatble = [NSMutableDictionary dictionary];
//    Fcgo_OrderListGoodsModel *obj = [model.goodsList firstObject];
//    [muatble  setObjectWithNullValidate:[NSString stringWithFormat:@"%@",obj.orderChildId] forKey:@"orderChildId"];
//    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, ORDERMETHOD, @"notifySendGoods") parametersContentCommon:muatble successBlock:^(BOOL success, id responseObject, NSString *msg) {
//        if (success) {
//            [WSProgressHUD showImage:nil status:@"提醒成功"];
//        }
//    } failureBlock:^(NSString *description) {} loading:YES];
}

- (void)againWithModel:(Fcgo_OrderListModel *)model
{
    if (self.againBlock) {
        self.againBlock(model);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.orderListArray.count > 0) {
        return [self.orderListArray count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF(weakSelf)
    Fcgo_OrderList_YB_ViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderList_YB_ViewTableViewCell"];
    if (self.orderListArray.count>0) {
        Fcgo_OrderListModel *model = self.orderListArray[indexPath.row];
        
        if (model.texe.intValue == 1) {
           cell.model = model;
        }
        else{
            Fcgo_OrderList_KJAndHW_ViewTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"orderList_KJAndHW_ViewTableViewCell"];
            cell1.model = model;
            
            cell1.payBlock = ^(Fcgo_OrderListModel *model)
            {
                [weakSelf payWithModel:model];
            };
            cell1.cancelBlock = ^(Fcgo_OrderListModel *model){
                [weakSelf cancelWithModel:model];
            };
            cell1.serviceBlock = ^(Fcgo_OrderListModel *model){
                [weakSelf serviceWithModel:model];
            };
            cell1.remindBlock = ^(Fcgo_OrderListModel *model){
                [weakSelf remindWithModel:model];
            };
            cell1.againBlock = ^(Fcgo_OrderListModel *model){
                [weakSelf againWithModel:model];
            };
            return cell1;
        }
    }
    cell.payBlock = ^(Fcgo_OrderListModel *model)
    {
        [weakSelf payWithModel:model];
    };
    cell.cancelBlock = ^(Fcgo_OrderListModel *model)
    {
        [Fcgo_AlertAnimationView showWithTitle:@"提示" text:@"确定要取消订单吗?" cancelTitle:@"取消" confirmTitle:@"确定" block:^{
            [weakSelf cancelWithModel:model];
        }];
    };
    cell.serviceBlock = ^(Fcgo_OrderListModel *model){
        [weakSelf serviceWithModel:model];
    };
    cell.remindBlock = ^(Fcgo_OrderListModel *model){
        [weakSelf remindWithModel:model];
    };
    cell.againBlock = ^(Fcgo_OrderListModel *model){
        [weakSelf againWithModel:model];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // WEAKSELF(weakSelf);
    
    if (self.orderListArray.count>0) {
        Fcgo_OrderListModel *model = self.orderListArray[indexPath.row];
        if (self.didSelectedOrderBlock) {
            self.didSelectedOrderBlock(model);
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.orderListArray.count>0) {
        Fcgo_OrderListModel *model = self.orderListArray[indexPath.row];
        if (model.texe.intValue == 1) {
            return 152 + 70;
        }
        return 222;
    }
    return 0;
}

#pragma mark Lazy method

- (UITableView *)table
{
    if (!_table) {
        UITableView *table    = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        table.backgroundColor = UIBackGroundColor;
        table.separatorStyle  = 0;
        table.delegate        = self;
        table.dataSource      = self;
        table.alpha           = 1;
        
        
        UIView *footerView   = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kAutoWidth6(10))];
        footerView.backgroundColor = UIBackGroundColor;
        table.tableFooterView = footerView;
        _table                = table;
        if (@available(iOS 11.0, *)) {
            table.estimatedRowHeight = 0;
            table.estimatedSectionFooterHeight = 0;
            table.estimatedSectionHeaderHeight = 0;
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

