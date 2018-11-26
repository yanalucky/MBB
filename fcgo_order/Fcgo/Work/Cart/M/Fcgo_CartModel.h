//
//  Fcgo_CartModel.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/22.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fcgo_CartModel : NSObject

@property (nonatomic ,assign) BOOL select;
@property (nonatomic ,assign) NSInteger number;
@property (nonatomic ,copy)   NSString *goodsType,*note,*logo,*goodsName,*property,*spu;
@property (nonatomic ,strong) NSNumber *cat_id,*f_sale,*j_price,*skuId,*f_status,*gskuId,*num,*price,*texe,*goodsId,*totalPrice,*remain,*f_number,*priceYUAN,*totalPriceYUAN,*goodsValue;

@end
