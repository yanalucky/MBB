//
//  Fcgo_OrderGoodsModel.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/23.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Fcgo_OrderGoodsParamModel : NSObject
@property (nonatomic, copy) NSString *goodsType;
@property (nonatomic, strong) NSNumber  *goodsNumber;
@property (nonatomic, strong) NSNumber  *goodsValue;
@end

@interface Fcgo_OrderGoodsModel : NSObject

@property (nonatomic, copy) NSString *picurl;
@property (nonatomic, copy) NSString *goodsName;
@property (nonatomic, copy) NSString *property;
@property (nonatomic,strong) NSNumber *goodsId;
@property (nonatomic, strong) NSNumber  *texes;
@property (nonatomic, strong) Fcgo_OrderGoodsParamModel *goodsTypeBo;
@property (nonatomic, strong) NSNumber  *unitPrice;
@property (nonatomic, strong) NSNumber *fright;///< 运费
@property (nonatomic, strong) NSNumber  *goodsCate;
@property (nonatomic, strong) NSNumber  *goodsBrand;
@property (nonatomic, strong) NSNumber  *mater;
@property (nonatomic, strong) NSNumber  *materYuan;
@property (nonatomic, strong) NSNumber  *frightYUAN;
@property (nonatomic, strong) NSNumber  *unitPriceYUAN;
@end
