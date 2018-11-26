//
//  Fcgo_GoodsDetailVC.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/1.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_WholePointModel.h"


@interface Fcgo_GoodsDetailVC : Fcgo_BasicVC

@property (nonatomic,copy)   NSString *goodsValue;//适用于正常的和整点抢的商品ID
@property (nonatomic,copy)   NSString *goodsType;

@end
