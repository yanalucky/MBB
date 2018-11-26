//
//  Fcgo_GoodsAttrModel.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/20.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fcgo_AttrModel.h"

@interface Fcgo_GoodsAttrModel : NSObject

@property (nonatomic,copy) NSString *f_properties_name;
@property (nonatomic,strong) NSNumber *f_properties_id;
@property (nonatomic,strong) NSArray<Fcgo_AttrModel *> *dataArray;

+ (Fcgo_GoodsAttrModel *)shareWithNSDictionary:(NSDictionary *)dic;

@end
