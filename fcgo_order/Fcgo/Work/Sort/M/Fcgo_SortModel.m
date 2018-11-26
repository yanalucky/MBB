//
//  Fcgo_SortModel.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/23.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_SortModel.h"

@implementation Fcgo_SortModel

+ (Fcgo_SortModel *)shareWithNSDictionary:(NSDictionary *)dic
{
    Fcgo_SortModel *sortModel = [[Fcgo_SortModel alloc]init];
    sortModel.sort_id      = [dic objectForKey:@"id"];
    sortModel.sort_picurl  = [dic objectForKey:@"picurl"];
    sortModel.sort_name    = [dic objectForKey:@"name"];
    sortModel.href    = [dic objectForKey:@"href"];
    
    NSMutableArray *cateMutableArray = [NSMutableArray array];
    NSArray *cateArray = dic[@"cated"];
    for (int i = 0; i < cateArray.count; i ++) {
        NSDictionary *cateDic = cateArray[i];
        Fcgo_CateModel *model = [Fcgo_CateModel shareWithNSDictionary:cateDic];
        [cateMutableArray addObject:model];
    }
    sortModel.cateArray = cateMutableArray;
    
    
    NSMutableArray *brandMutableArray = [NSMutableArray array];
    NSArray *brandArray = dic[@"brand"];
    for (int i = 0; i < brandArray.count; i ++) {
        NSDictionary *brandDic = brandArray[i];
        Fcgo_BrandModel *model = [Fcgo_BrandModel shareWithNSDictionary:brandDic];
        [brandMutableArray addObject:model];
    }
    sortModel.brandArray = brandMutableArray;
    return sortModel;
}

@end
