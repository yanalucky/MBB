//
//  Fcgo_OrderList_KJAndHW_View.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/22.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_OrderListModel.h"
#import "Fcgo_OrderListGoodsModel.h"

@interface Fcgo_OrderList_KJAndHW_View : UIView

@property (nonatomic,strong) NSMutableArray *orderListArray;
@property (nonatomic,strong) NSString   *status;//订单状态
@property (nonatomic,strong) UITableView  *table;

@property (nonatomic,copy) void(^didSelectedOrderBlock)(Fcgo_OrderListModel *model);

@property(nonatomic,copy) void (^payBlock)(Fcgo_OrderListModel *model);

@property(nonatomic,copy) void (^againBlock)(Fcgo_OrderListModel *model);

@property(nonatomic,copy) void (^refreshTopBlock)(void);
@property(nonatomic,copy) void (^refreshBottomBlock)(void);

@property (nonatomic, copy) void (^serviceBlock)(Fcgo_OrderListModel *model);

- (void)setOrderListWithArray:(NSMutableArray *)listArray;
- (void)addOrderListWithArray:(NSMutableArray *)listArray;

@end