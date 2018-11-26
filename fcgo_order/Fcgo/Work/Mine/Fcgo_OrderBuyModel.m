//
//  Fcgo_OrderBuyModel.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/23.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderBuyModel.h"

@implementation Fcgo_OrderBuyModel
+ (instancetype)yy_modelWithDictionary:(NSDictionary *)dictionary {
    Fcgo_OrderBuyModel *obj = [super yy_modelWithDictionary:dictionary];
    
    NSArray *tmpArray = [NSJSONSerialization JSONObjectWithData:[obj.goods dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
    NSString *tmpType = nil;
    NSInteger num = 0;
    for (NSDictionary *dict in tmpArray) {
        Fcgo_OrderGoodsParamModel *model = [Fcgo_OrderGoodsParamModel yy_modelWithDictionary:dict];
        tmpType = model.goodsType;
        num += model.goodsNumber.integerValue;
    }
    obj.totalNum = @(num);
//    obj.
    return obj;
}
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{@"listArray":@"returnVos",
             @"totalNum":@"totalNumber"
             };
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"listArray":[Fcgo_OrderGoodsModel class]};
}

- (NSNumber *)texe {
    Fcgo_OrderGoodsModel *obj = [self.listArray firstObject];
    return obj ? obj.texes : nil;
}

+ (Fcgo_OrderBuyModel *)shareWithNSDictionary:(NSDictionary *)dic
{
    Fcgo_OrderBuyModel *model = [[Fcgo_OrderBuyModel alloc]init];
    model.totalNum      = [dic objectForKey:@"totalNum"];
    model.texe  = [dic objectForKey:@"texe"];
    model.totalPrice    = [dic objectForKey:@"totalPrice"];
//    model.actDict    = [dic objectForKey:@"activity"];
    NSMutableArray *listArray = [NSMutableArray array];
    NSArray *list = dic[@"list"];
    for (int i = 0; i < list.count; i ++) {
        NSDictionary *listDic = list[i];
        Fcgo_OrderGoodsModel *model = [Fcgo_OrderGoodsModel yy_modelWithDictionary:listDic];
        [listArray addObject:model];
    }
    model.listArray = listArray;
    return model;
}
@end
