//
//  Fcgo_GoodsInfoModel.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/20.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fcgo_GoodsInfoModel : NSObject

@property (nonatomic,copy)   NSString *goodsName,*price,*freight_s,*stock_s;
@property (nonatomic,strong) NSNumber *goodsSalenum,*freight,*freightYUAN,*stock,*minprice,*maxprice,*goods_id,*goodsVirtualNum,*texes,*priceYUAN,*minpriceYUAN,*maxpriceYUAN;
@property (nonatomic,strong) NSArray *picUrl;

@end
