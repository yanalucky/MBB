//
//  Fcgo_OrderConfirmGoodsTableCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Fcgo_OrderGoodsModel.h"
@interface Fcgo_OrderConfirmGoodsTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (strong, nonatomic) Fcgo_OrderGoodsModel *model;
@end
