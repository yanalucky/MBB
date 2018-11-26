//
//  Fcgo_BrandModel.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/18.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fcgo_BrandModel : NSObject

@property (nonatomic,strong) NSNumber *brand_id,*selected,*saleNum,*brandSaleNum;
@property (nonatomic,copy)   NSString *brand_logo,*brand_name;

+ (Fcgo_BrandModel *)shareWithNSDictionary:(NSDictionary *)dic;

@end
