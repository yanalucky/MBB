//
//  Fcgo_GoodsAttrModel.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/20.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_GoodsAttrModel.h"

@implementation Fcgo_GoodsAttrModel

+ (Fcgo_GoodsAttrModel *)shareWithNSDictionary:(NSDictionary *)dic
{
    
    Fcgo_GoodsAttrModel *model = [[Fcgo_GoodsAttrModel alloc]init];
    model.f_properties_name         = [dic objectForKey:@"f_properties_name"];
    model.f_properties_id       = [dic objectForKey:@"f_properties_id"];
    
    NSMutableArray *dataMutableArray = [NSMutableArray array];
    NSArray *dataArray = dic[@"data"];
    for (int i = 0; i < dataArray.count; i ++) {
        NSDictionary *attrDict = dataArray[i];
        Fcgo_AttrModel *attrModel = [Fcgo_AttrModel yy_modelWithDictionary:attrDict];
        [dataMutableArray addObject:attrModel];
    }
    
    model.dataArray = dataMutableArray;
    
    return model;
}
@end
