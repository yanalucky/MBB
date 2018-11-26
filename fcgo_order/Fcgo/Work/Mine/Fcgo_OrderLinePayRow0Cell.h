//
//  Fcgo_OrderLinePayRow0Cell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_OrderPayModel.h"
#import "Fcgo_OrderListModel.h"
#import "Fcgo_OrderDetailModel.h"

@interface Fcgo_OrderLinePayRow0Cell : UITableViewCell
@property (nonatomic,strong) Fcgo_OrderPayModel *model;
@property (nonatomic,strong) Fcgo_OrderListModel *listModel;
@property (nonatomic,strong) Fcgo_OrderDetailModel *orderDetailModel;
@end
