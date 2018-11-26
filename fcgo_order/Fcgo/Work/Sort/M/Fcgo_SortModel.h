//
//  Fcgo_SortModel.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/23.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fcgo_CateModel.h"
#import "Fcgo_BrandModel.h"

@interface Fcgo_SortModel : NSObject

@property (nonatomic,strong) NSArray <Fcgo_CateModel *>  *cateArray;
@property (nonatomic,strong) NSArray <Fcgo_BrandModel *>  *brandArray;
@property (nonatomic,strong) NSNumber *sort_id;
@property (nonatomic,copy)   NSString *sort_name,*sort_picurl,*href;

+ (Fcgo_SortModel *)shareWithNSDictionary:(NSDictionary *)dic;


@end
