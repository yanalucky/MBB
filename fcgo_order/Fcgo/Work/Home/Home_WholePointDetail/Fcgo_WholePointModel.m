//
//  Fcgo_WholePointModel.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/26.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_WholePointModel.h"
#import "Fcgo_WholePointGoodsModel.h"

@implementation Fcgo_WholePointModel

+ (Fcgo_WholePointModel *)shareWithNSDictionary:(NSDictionary *)dic
{
    Fcgo_WholePointModel *model = [[Fcgo_WholePointModel alloc]init];
    model.name      = [dic objectForKey:@"name"];
    model.f_integral_id  = [dic objectForKey:@"id"];
    model.start    = [dic objectForKey:@"start"];
    model.end    = [dic objectForKey:@"end"];
    model.type    = [dic objectForKey:@"type"];
    model.tyeName    = [dic objectForKey:@"tyeName"];
    NSMutableArray *goodsMutableArray = [NSMutableArray array];
    NSArray *goodsArray = dic[@"datas"];
    for (int i = 0; i < goodsArray.count; i ++) {
        
        NSDictionary *goodsDic = goodsArray[i];
        Fcgo_WholePointGoodsModel *model1 = [Fcgo_WholePointGoodsModel yy_modelWithDictionary:goodsDic];
        [goodsMutableArray addObject:model1];
    }
    model.datas = goodsMutableArray;
    return model;
}

@end
