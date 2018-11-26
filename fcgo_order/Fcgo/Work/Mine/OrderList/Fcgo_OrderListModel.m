//
//  Fcgo_OrderListModel.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/25.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderListModel.h"

@implementation Fcgo_OrderListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"ID" : @"id"
             };
}
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
             @"goodsList" : [Fcgo_OrderListGoodsModel class]
             };
}

//+ (Fcgo_OrderListModel *)shareWithNSDictionary:(NSDictionary *)dic
//{
//    Fcgo_OrderListModel *model = [[Fcgo_OrderListModel alloc]init];
//    model.orderNo      = [dic objectForKey:@"orderNo"];
//    model.totalPrice  = [dic objectForKey:@"totalPrice"];
//    model.orderNum    = [dic objectForKey:@"orderNum"];
//    model.lastPayTime    = [dic objectForKey:@"lastPayTime"];
//    model.orderStatus    = [dic objectForKey:@"orderStatus"];
//    model.totalFreight    = [dic objectForKey:@"totalFreight"];
//    model.orderId    = [dic objectForKey:@"orderId"];
//    model.texe       = [dic objectForKey:@"texe"];
//    
//    NSMutableArray *orderGoodsArray = [NSMutableArray array];
//    NSArray *orderGoods = dic[@"orderGoods"];
//    for (int i = 0; i < orderGoods.count; i ++) {
//        NSDictionary *goodsDic = orderGoods[i];
//        Fcgo_OrderListGoodsModel *model1 = [Fcgo_OrderListGoodsModel yy_modelWithDictionary:goodsDic];
//        [orderGoodsArray addObject:model1];
//    }
//    model.orderGoods = orderGoodsArray;
//    return model;
//}
@end
