//
//  Fcgo_OrderListModel.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/25.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fcgo_OrderListGoodsModel.h"

@interface Fcgo_OrderListModel : NSObject

@property (nonatomic, copy) NSString    *orderNo; ///< string 订单号
@property (nonatomic, copy) NSString    *payTime; ///< string 支付时间
@property (nonatomic, copy) NSString    *created; ///< string 订单创建时间
@property (nonatomic, copy) NSString    *statusName; ///< string 状态名称
@property (nonatomic, strong) NSNumber  *ID;
@property (nonatomic, strong) NSNumber  *goodsID; ///< int goodsInfoId
@property (nonatomic, strong) NSNumber  *lastPayTime; ///< long 截止支付时间
@property (nonatomic, strong) NSNumber  *orderStatus; ///< int 订单状态
@property (nonatomic, strong) NSNumber  *totalPrice; ///< int 总价
@property (nonatomic, strong) NSNumber  *totalFreight; ///< 总运费
@property (nonatomic, strong) NSNumber  *reduce; ///< 全部优惠
@property (nonatomic, strong) NSNumber  *texe; ///< 贸易类型

@property (nonatomic, strong) NSNumber  *totalFreightYUAN;
@property (nonatomic, strong) NSNumber  *totalPriceYUAN;
@property (nonatomic, strong) NSNumber  *reduceYUAN;

@property (nonatomic, retain) NSArray<Fcgo_OrderListGoodsModel *> *goodsList; ///< 商品详情列表


//@property (nonatomic,strong) NSNumber *orderNum,*orderId,*texe;
//@property (nonatomic,strong) NSArray<Fcgo_OrderListGoodsModel *> *orderGoods;//一般类型中一个订单的商品数量

//+ (Fcgo_OrderListModel *)shareWithNSDictionary:(NSDictionary *)dic;


@end
