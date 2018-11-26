//
//  Home_WholePointDetailCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/13.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_WholePointGoodsModel.h"
#import "Fcgo_WholePointModel.h"
@interface Home_WholePointDetailCell : UITableViewCell

@property (nonatomic,assign) WholePointType type;
@property (nonatomic,strong) Fcgo_WholePointModel *pointModel;
@property (nonatomic,strong) Fcgo_WholePointGoodsModel *model;
@property (nonatomic,copy) void(^selectedBlock)(Fcgo_WholePointGoodsModel *goodsModel);
@end
