//
//  Fcgo_GoodsInfoVC.h
//  Fcgo
//
//  Created by huafanxiao on 2017/12/25.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_BasicVC.h"

@interface Fcgo_GoodsInfoVC : Fcgo_BasicVC

//适用于normal goodsId 整点抢 integralId
@property (nonatomic,copy)   NSString *goodsValue;
//商品类型，normal 和 inregral等活动
@property (nonatomic,copy)   NSString *goodsType;

@end
