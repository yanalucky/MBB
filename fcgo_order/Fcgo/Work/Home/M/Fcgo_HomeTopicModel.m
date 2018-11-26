//
//  Fcgo_HomeTopicModel.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/19.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_HomeTopicModel.h"
#import "Fcgo_HomeGoodsModel.h"

@implementation Fcgo_HomeTopicModel

+ (Fcgo_HomeTopicModel *)shareWithNSDictionary:(NSDictionary *)dic
{
    Fcgo_HomeTopicModel *model = [[Fcgo_HomeTopicModel alloc]init];
    model.f_href      = [dic objectForKey:@"f_href"];
    model.href  = [dic objectForKey:@"href"];
    model.f_topic_id    = [dic objectForKey:@"id"];
    
    NSMutableArray *goodsMutableArray = [NSMutableArray array];
    NSArray *goodsArray = dic[@"datas"];
    for (int i = 0; i < goodsArray.count; i ++) {
        NSDictionary *goodsDic = goodsArray[i];
        Fcgo_HomeGoodsModel *model = [Fcgo_HomeGoodsModel yy_modelWithDictionary:goodsDic];
        [goodsMutableArray addObject:model];
    }
    model.datas = goodsMutableArray;
    
    return model;
}

@end
