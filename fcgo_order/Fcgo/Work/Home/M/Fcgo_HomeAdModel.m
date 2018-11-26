//
//  Fcgo_HomeAdModel.m
//  Fcgo
//
//  Created by by_r on 2017/9/25.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_HomeAdModel.h"

@implementation Fcgo_HomeAdModel
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}
@end
