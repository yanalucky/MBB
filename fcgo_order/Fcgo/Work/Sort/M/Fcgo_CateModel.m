//
//  Fcgo_CateModel.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/18.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_CateModel.h"

@implementation Fcgo_CateModel

+ (Fcgo_CateModel *)shareWithNSDictionary:(NSDictionary *)dic{
    
    Fcgo_CateModel *cateModel = [[Fcgo_CateModel alloc]init];
    cateModel.cate_id         = [dic objectForKey:@"id"];
    cateModel.cate_logo       = [dic objectForKey:@"logo"];
    cateModel.cate_name       = [dic objectForKey:@"name"];
    return cateModel;
}


@end
