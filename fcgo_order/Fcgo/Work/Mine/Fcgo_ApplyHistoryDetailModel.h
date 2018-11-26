//
//  Fcgo_ApplyHistoryDetailModel.h
//  Fcgo
//
//  Created by fcg on 2017/11/30.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fcgo_ApplyHistoryDetailModel : NSObject
@property (nonatomic,copy)   NSString *address,*createTime,*destroyReason,*goodsName,*goodsType,*orderChildNo,*picurl,*picurls,*properties,*reason,*updateTime;
@property (nonatomic,strong) NSNumber *f_apply_id,*goodsId,*gskuId,*goodsValue,*mchStoreId,*orderChildId,*orderId,*refundNumber,*refundPrice,*refundPriceYUAN,*status;
@property (nonatomic,strong)NSArray *afterSaleStreamList;



@end
