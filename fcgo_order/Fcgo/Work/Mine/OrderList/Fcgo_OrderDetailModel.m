//
//  Fcgo_OrderDetailModel.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/27.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderDetailModel.h"

@implementation Fcgo_OrderDetailModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"ID" : @"id",
             };
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"goodsList" : [Fcgo_OrderListGoodsModel class],
             };
}

//+ (Fcgo_OrderDetailModel *)shareWithNSDictionary:(NSDictionary *)dic
//{
//    Fcgo_OrderDetailModel *model = [[Fcgo_OrderDetailModel alloc]init];
//    model.orderNo       = [dic objectForKey:@"orderNo"];
//    model.orderCreated  = [dic objectForKey:@"orderCreated"];
//    model.orderPayTime  = [dic objectForKey:@"orderPayTime"];
//    model.totalCoupon   = [dic objectForKey:@"totalCoupon"];
//    model.orderId       = [dic objectForKey:@"orderId"];
//    model.totalPrice    = [dic objectForKey:@"totalPrice"];
//    model.orderStatus   = [dic objectForKey:@"orderStatus"];
//    model.totalFullcut  = [dic objectForKey:@"totalFullcut"];
//    model.totalFreight  = [dic objectForKey:@"totalFreight"];
//    model.message  = [dic objectForKey:@"message"];
//    
//    
//    
//    model.payType       = [dic objectForKey:@"payType"];
//    model.now = [dic objectForKey:@"now"];
//    model.end       = [dic objectForKey:@"end"];
//    NSDictionary *acceptDict = dic[@"accept"];
//    model.accept = [Fcgo_OrderDetailAcceptModel yy_modelWithDictionary:acceptDict];
//    
//    NSMutableArray *orderGoodsArray = [NSMutableArray array];
//    NSArray *goods = dic[@"goods"];
//    for (int i = 0; i < goods.count; i ++) {
//        NSDictionary *goodsDic = goods[i];
//        
////        Fcgo_OrderDetailGoodsModel *model1 = [Fcgo_OrderDetailGoodsModel yy_modelWithDictionary:goodsDic];
////        model1.express = goodsDic[@"express"];
////        model1.orderId = [dic objectForKey:@"orderId"];
////        [orderGoodsArray addObject:model1];
//    }
//    model.goods = orderGoodsArray;
//    return model;
//}
@end
