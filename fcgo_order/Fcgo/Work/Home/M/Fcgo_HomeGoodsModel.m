//
//  Fcgo_HomeGoodsModel.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/19.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_HomeGoodsModel.h"

@implementation Fcgo_HomeGoodsModel
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"f_goods_id" :@"id",
             @"goodsVirtualNum" : @[@"goodsVirtualNum", @"goodsVirtualnum"],
             @"goodsSaleNum" : @[@"goodsSaleNum", @"goodsSalenum"],
             @"grossProfitRate" : @[@"grossProfitRate", @"rate"],
             @"texe" : @[@"texe", @"texes"],
             };
}
@end
