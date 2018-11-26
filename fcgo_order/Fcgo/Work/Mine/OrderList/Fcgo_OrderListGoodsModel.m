//
//  Fcgo_OrderListGoodsModel.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/27.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderListGoodsModel.h"

@implementation Fcgo_OrderListGoodsModel
//+ (NSDictionary *)modelCustomPropertyMapper {
//    return @{
//             };
//}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"orderExpress" : [Fcgo_OrderExpressModel class],
             };
}
@end
