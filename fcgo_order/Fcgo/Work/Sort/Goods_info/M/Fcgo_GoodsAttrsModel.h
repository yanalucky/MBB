//
//  Fcgo_GoodsAttrsModel.h
//  Fcgo
//
//  Created by huafanxiao on 2017/12/25.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fcgo_GoodsPropertyModel.h"
@interface Fcgo_GoodsAttrsModel : NSObject
@property (nonatomic,copy) NSString *f_properties_name;
@property (nonatomic,strong) NSNumber *f_properties_id;
@property (nonatomic,strong) NSArray<Fcgo_GoodsPropertyModel *> *dataArray;

@end
