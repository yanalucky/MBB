//
//  Fcgo_OrderDetailGoodsTableViewCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/25.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_OrderListGoodsModel.h"
@interface Fcgo_OrderDetailGoodsTableViewCell : UITableViewCell

@property (nonatomic,strong) Fcgo_OrderListGoodsModel *goodsModel;

@property (nonatomic,copy) void(^applyBlock)(Fcgo_OrderListGoodsModel *goodsModel,Fcgo_IndexButton *btn);
@property (nonatomic,copy) void(^signBlock)(Fcgo_OrderListGoodsModel *goodsModel);

@end
