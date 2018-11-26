//
//  Fcgo_OrderList_KJAndHW_ViewTableViewCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/24.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_OrderListModel.h"

@interface Fcgo_OrderList_KJAndHW_ViewTableViewCell : UITableViewCell

@property (nonatomic,assign) OrderStatusType      statusType;
@property (nonatomic,strong) Fcgo_OrderListModel *model;
@property(nonatomic,copy) void (^payBlock)(Fcgo_OrderListModel *model);
@property(nonatomic,copy) void (^cancelBlock)(Fcgo_OrderListModel *model);
@property(nonatomic,copy) void (^serviceBlock)(Fcgo_OrderListModel *model);
@property(nonatomic,copy) void (^remindBlock)(Fcgo_OrderListModel *model);


@property(nonatomic,copy) void (^againBlock)(Fcgo_OrderListModel *model);


@end
