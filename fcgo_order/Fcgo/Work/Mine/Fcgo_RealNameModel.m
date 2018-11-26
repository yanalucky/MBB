//
//  Fcgo_RealNameModel.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/18.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_RealNameModel.h"

@implementation Fcgo_RealNameModel

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"f_realName_id" :@"id",
             @"f_default":@"fault"
             };
}

@end
