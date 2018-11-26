//
//  Fcgo_HomeWholePointModel.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/15.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_HomeWholePointModel.h"
#import "Fcgo_WholePointGoodsModel.h"

@implementation Fcgo_HomeWholePointModel

+ (Fcgo_HomeWholePointModel *)shareWithNSDictionary:(NSDictionary *)dic
{
    Fcgo_HomeWholePointModel *model = [[Fcgo_HomeWholePointModel alloc]init];
    model.name      = [dic objectForKey:@"name"];
    model.f_integral_id  = [dic objectForKey:@"id"];
    model.end    = [dic objectForKey:@"end"];
    model.now    = [dic objectForKey:@"now"];
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
