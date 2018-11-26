//
//  Fcgo_OrderListGoodsModel.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/27.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "Fcgo_OrderDetailModel.h"
#import "Fcgo_OrderExpressModel.h"

@interface Fcgo_OrderListGoodsModel : NSObject

//@property (nonatomic,copy)   NSString *goodsType,*goodsProperty;
//@property (nonatomic,strong) NSNumber *goodsValue,*goodsNumber,*sigalPrice;



@property (nonatomic, copy) NSString    *goodsName; ///< string
@property (nonatomic, copy) NSString    *picurl; ///< string
@property (nonatomic, copy) NSString    *property; ///< string 包装数:包
@property (nonatomic, copy) NSString    *spu; ///< string
@property (nonatomic, strong) NSNumber  *num; ///< int 购买数量
@property (nonatomic, strong) NSNumber  *orderChildId; ///< int 原orderGoodsId现订单子表id
@property (nonatomic, strong) NSNumber  *orderGoodsStatus; ///< int 子单状态
@property (nonatomic, strong) NSNumber  *freight; ///< int 运费
@property (nonatomic, strong) NSNumber  *price; ///< 金额
@property (nonatomic, strong) NSNumber  *fullcut; ///< 满减
@property (nonatomic, strong) NSNumber  *coupon; ///< 优惠金额
@property (nonatomic, strong) NSNumber  *goodsId;
@property (nonatomic, strong) NSNumber  *goodsValue; ///<

@property (nonatomic, strong) NSNumber  *couponYUAN;
@property (nonatomic, strong) NSNumber  *freightYUAN;
@property (nonatomic, strong) NSNumber  *fullcutYUAN;
@property (nonatomic, strong) NSNumber  *priceYUAN;
@property (nonatomic, retain) NSArray<Fcgo_OrderExpressModel *> *orderExpress; ///< 订单物流信息

@property (nonatomic, strong) NSNumber  *afterSaleId;
@property (nonatomic, strong) NSNumber  *afterSaleStatus;
@property (nonatomic, strong) NSNumber  *texe;
@end
