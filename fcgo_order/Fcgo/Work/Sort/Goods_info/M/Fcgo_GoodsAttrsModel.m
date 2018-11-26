//
//  Fcgo_GoodsAttrsModel.m
//  Fcgo
//
//  Created by huafanxiao on 2017/12/25.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_GoodsAttrsModel.h"

@implementation Fcgo_GoodsAttrsModel
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"dataArray" :@"data"};
}
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"dataArray":[Fcgo_GoodsPropertyModel class]};
}

@end
