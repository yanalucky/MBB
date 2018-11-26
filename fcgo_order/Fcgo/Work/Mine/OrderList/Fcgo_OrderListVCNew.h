//
//  Fcgo_OrderListVCNew.h
//  Fcgo
//
//  Created by by_r on 2017/10/24.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_BasicVC.h"

@interface Fcgo_OrderListVCNew : Fcgo_BasicVC
/**
 kHeadTouchType_myOrder = 1, ///< 我的订单
 kHeadTouchType_waitPay = 2, ///< 待付款
 kHeadTouchType_deal = 3, ///< 处理中
 kHeadTouchType_recive = 4, ///< 待收货
 */
@property (nonatomic,assign) NSInteger index;//传入选中的第几个，从1开始
@end
