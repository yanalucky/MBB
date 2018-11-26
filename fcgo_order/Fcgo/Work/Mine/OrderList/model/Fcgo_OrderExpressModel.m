//
//  Fcgo_OrderExpressModel.m
//  Fcgo
//
//  Created by by_r on 2017/11/24.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_OrderExpressModel.h"

@implementation Fcgo_OrderExpressModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"ID" : @"id",
             };
}
@end

@implementation Fcgo_OrderExpressUnit
+ (instancetype)yy_modelWithDictionary:(NSDictionary *)dictionary {
    Fcgo_OrderExpressUnit *unit = [super yy_modelWithDictionary:dictionary];
    if (unit.data.length) {
        NSData *tmpData = [unit.data dataUsingEncoding:NSUTF8StringEncoding];
        if (tmpData.length) {
            NSArray *tmpArray = [NSJSONSerialization JSONObjectWithData:tmpData options:NSJSONReadingMutableLeaves error:nil];
            if (tmpArray.count) {
                NSMutableArray *mutArray = @[].mutableCopy;
                for (NSDictionary *dict in tmpArray) {
                    Fcgo_orderExpressData *obj = [Fcgo_orderExpressData yy_modelWithDictionary:dict];
                    [mutArray addObject:obj];
                }
                unit.dataArray = mutArray.copy;
            }
        }
    }
    return unit;
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"ID" : @"id",
             };
}
@end

@implementation Fcgo_orderExpressData
@end
