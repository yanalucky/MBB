//
//  Fcgo_GoodsSkuModel.h
//  Fcgo
//
//  Created by huafanxiao on 2017/12/25.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fcgo_GoodsSkuModel : NSObject
@property (nonatomic,copy) NSString *remain,*time,*postage,*price,*unitprice,*total,*skuid;
@property (nonatomic,copy) NSString *postageYUAN,*priceYUAN,*unitpriceYUAN,*totalYUAN;
@property (nonatomic,assign) BOOL canBuy;
@property (nonatomic,copy) NSString *goodsType;
@property (nonatomic,strong) NSMutableArray *attrsArray;//属性分类数组
@end
