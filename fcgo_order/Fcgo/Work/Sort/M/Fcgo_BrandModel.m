//
//  Fcgo_BrandModel.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/18.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_BrandModel.h"

@implementation Fcgo_BrandModel

+ (Fcgo_BrandModel *)shareWithNSDictionary:(NSDictionary *)dic{
    
    Fcgo_BrandModel *brandModel = [[Fcgo_BrandModel alloc]init];
    brandModel.brand_id         = [dic objectForKey:@"id"];
    brandModel.brand_logo       = [dic objectForKey:@"logo"];
    brandModel.brand_name       = [dic objectForKey:@"name"];
    brandModel.selected         = [dic objectForKey:@"selected"];
    brandModel.saleNum         = [dic objectForKey:@"saleNum"];

    
    return brandModel;
}

@end
