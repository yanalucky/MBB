//
//  Fcgo_AfterSalesServiceListModel.h
//  Fcgo
//
//  Created by huafanxiao on 2017/7/3.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fcgo_AfterSalesServiceListModel : NSObject

@property (nonatomic,copy)   NSString *picurl,*goodsName,*orderNo,*created,*spu,*orderChildNo;
@property (nonatomic,strong) NSNumber *status,*refundMoney,*realRefundMoney,*num,*money,*f_apply_id,*goodsId,*goodsGsku,*goodsSku,*orderId,*goodsBuynum,*texe,*orderGoodsStatus,*goodsCate,*goodsCatem,*goodsBrand,*goodsValue,*allPrice,*allPriceYUAN,*refundNumber,*refundPrice,*salePrice,*refundPriceYUAN,*freightYUAN;
//申请售后
@property (nonatomic,copy)   NSString *cancelTime,*createTime,*orderAftersaleNo,*goodsSpu,*deliverTime,*goodsSkuName,*goodsSkuPicurl,*goodsType,*noClearTime,*noSiezTime,*properties,*remark,*siezTime,*signTime,*thrNo,*updateTime;

//售后列表
@property (nonatomic,copy)   NSString *aftersaleType,*reason,*destroyReason;



//private Integer           orderChildId;      ???                      // 子单编号

@end
