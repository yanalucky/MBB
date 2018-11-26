//
//  Fcgo_CartModel.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/22.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_CartModel.h"

@implementation Fcgo_CartModel

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"cat_id" :@"id",@"num":@"goodsNumber",@"f_number":@"gskuNum"};
}
@end

