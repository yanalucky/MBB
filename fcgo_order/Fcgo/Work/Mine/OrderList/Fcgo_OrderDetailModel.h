//
//  Fcgo_OrderDetailModel.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/27.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fcgo_OrderDetailAcceptModel.h"
#import "Fcgo_OrderListGoodsModel.h"

@interface Fcgo_OrderDetailModel : NSObject

//@property (nonatomic,copy)   NSString *orderCreated,*orderPayTime,*message;
//@property (nonatomic,strong) NSNumber *orderId,*totalFullcut,*end;
//@property (nonatomic,strong) NSArray *goods;//一般类型中一个订单的商品数量
//@property (nonatomic,assign) NSTimeInterval time_interval;//记录服务器当前时间与手机本地时间的时间差
//@property (nonatomic,strong) Fcgo_OrderDetailAcceptModel *accept;

@property (nonatomic, copy) NSString    *orderNo; ///< 订单号
@property (nonatomic, copy) NSString    *alertmess; ///< 备注
@property (nonatomic, copy) NSString    *orderStatusName; ///< 订单状态名称
@property (nonatomic, copy) NSString    *payType; ///< 支付方式
@property (nonatomic, copy) NSString    *createTime; ///< 创建时间
@property (nonatomic, copy) NSString    *payTime; ///< 支付时间
@property (nonatomic, copy) NSString    *acceptConsigee; ///< 收货人
@property (nonatomic, copy) NSString    *acceptConsigeephone; ///< 收货号码
@property (nonatomic, copy) NSString    *acceptAddress; ///< 收货地址
@property (nonatomic, copy) NSString    *declationName; ///< 报关人名称
@property (nonatomic, copy) NSString    *idcard; ///< 报关人身份证
@property (nonatomic, copy) NSString    *goodsType;///< 商品类型
@property (nonatomic, copy) NSString    *remark;
@property (nonatomic, strong) NSNumber  *ID; ///< int 订单表
@property (nonatomic, strong) NSNumber  *now; ///< long 当前时间
@property (nonatomic, strong) NSNumber  *lastTime; ///< long 最总付款倒计时
@property (nonatomic, strong) NSNumber  *orderStatus; ///< int 订单状态
@property (nonatomic, strong) NSNumber  *totalCoupon; ///< int 优惠券折扣总金额
@property (nonatomic, strong) NSNumber  *totalActivity; ///< int 活动折扣总金额
@property (nonatomic, strong) NSNumber  *totalPrice; ///< 总金额
@property (nonatomic, strong) NSNumber  *totalFreight; ///< 总运费
@property (nonatomic, strong) NSNumber  *goodsValue; ///< 对应value
@property (nonatomic,assign) NSTimeInterval time_interval;//记录服务器当前时间与手机本地时间的时间差

@property (nonatomic, strong) NSNumber  *totalCouponYUAN;
@property (nonatomic, strong) NSNumber  *totalFreightYUAN;
@property (nonatomic, strong) NSNumber  *totalActivityYUAN;
@property (nonatomic, strong) NSNumber  *totalPriceYUAN;
@property (nonatomic, retain) NSArray<Fcgo_OrderListGoodsModel *>   *goodsList; ///< 子单信息


//+ (Fcgo_OrderDetailModel *)shareWithNSDictionary:(NSDictionary *)dic;


@end
