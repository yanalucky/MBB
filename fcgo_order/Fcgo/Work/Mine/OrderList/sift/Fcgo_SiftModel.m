//
//  Fcgo_SiftModel.m
//  Fcgo
//
//  Created by by_r on 2017/11/28.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_SiftModel.h"

@implementation Fcgo_SiftModel
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
             @"list" : [Fcgo_SiftSelectModel class]
             };
}

@end

@implementation Fcgo_SiftSelectModel
- (BOOL)isSelected {
    return _selected;
}
@end
