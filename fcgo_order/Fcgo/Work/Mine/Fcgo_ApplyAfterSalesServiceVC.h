//
//  Fcgo_ApplyAfterSalesServiceVC.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/14.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_OrderListGoodsModel.h"

@interface Fcgo_ApplyAfterSalesServiceVC : Fcgo_BasicVC
@property (nonatomic,strong) Fcgo_OrderListGoodsModel *model;
@property (nonatomic,strong) NSString *orderId;
@property (nonatomic,copy) void(^applyBlock)();
@end
