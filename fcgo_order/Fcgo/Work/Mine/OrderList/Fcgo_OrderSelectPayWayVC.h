//
//  Fcgo_OrderSelectPayWayVC.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/25.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_OrderListModel.h"
#import "Fcgo_OrderDetailModel.h"

@interface Fcgo_OrderSelectPayWayVC : Fcgo_BasicVC

@property (nonatomic,strong) Fcgo_OrderListModel *model;
@property (nonatomic,strong) Fcgo_OrderDetailModel *orderDetailModel;
@property (nonatomic,strong) void(^paySuccessBlock)();

@end
