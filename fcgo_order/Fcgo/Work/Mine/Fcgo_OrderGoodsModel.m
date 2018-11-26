//
//  Fcgo_OrderGoodsModel.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/23.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderGoodsModel.h"

@implementation Fcgo_OrderGoodsParamModel
@end

@implementation Fcgo_OrderGoodsModel
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{@"price":@"unitPrice",
             @"picurl":@"picurlLogo",
             @"materYuan":@[@"materYuan", @"materYUAN"]
             };
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"goodsTypeBo":[Fcgo_OrderGoodsParamModel class]};
}
@end
