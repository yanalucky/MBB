//
//  Fcgo_OrderBuyModel.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/23.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fcgo_OrderGoodsModel.h"
@interface Fcgo_OrderBuyModel : NSObject

@property (nonatomic,strong) NSArray <Fcgo_OrderGoodsModel *>*listArray;
@property (nonatomic,strong) NSNumber *totalNum,*totalPrice;
@property (nonatomic,strong) NSNumber  *texe;
@property (nonatomic,copy) NSString    *goods;
//@property (nonatomic,strong) NSDictionary *actDict;
+ (Fcgo_OrderBuyModel *)shareWithNSDictionary:(NSDictionary *)dic;
@end
