//
//  Fcgo_GoodsInfoRequestViewModel.h
//  Fcgo
//
//  Created by huafanxiao on 2017/12/25.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fcgo_GoodsInfoActivityModel.h"
#import "Fcgo_GoodsInfoMsgModel.h"
#import "Fcgo_BrandModel.h"
#import "Fcgo_ActivityModel.h"
#import "Fcgo_AddressModel.h"
#import "Fcgo_GoodsSkuModel.h"
#import "Fcgo_GoodsAttrsModel.h"
#import "Fcgo_GoodsPropertyModel.h"
@interface Fcgo_GoodsInfoRequestViewModel : NSObject

+ (void)requestCollectWithGoodsID:(NSNumber *)goodsId success:(void(^)(BOOL isCollect))successBlock fail:(void(^)(NSString *error))failBlock;
+ (void)requestGoodsCarNumSuccess:(void(^)(NSNumber *cartNum))successBlock fail:(void(^)(NSString *error))failBlock;
+ (void)requestGoodsBasicMsgWithGoodsValue:(NSNumber *)goodsValue goodsType:(NSString *)goodsType success:(void(^)(Fcgo_GoodsInfoMsgModel *infoModel))successBlock fail:(void(^)(NSString *error))failBlock;
+ (void)requestGoodsSKUMsgWithGoodsValue:(NSNumber *)goodsValue
                                goodsType:(NSString *)goodsType
                           saveAttrsArray:(NSMutableArray *)selectedPropertyArray
                                infoModel:(Fcgo_GoodsInfoMsgModel *)infoModel
                             addressModel:(Fcgo_AddressModel *)addressModel
                                  success:(void(^)(Fcgo_GoodsSkuModel  *skuModel,NSMutableArray *selectedPropertyArray))successBlock
                                     fail:(void(^)(NSString *error))failBlock;

+ (void)requestStoreAddressListSuccess:(void(^)(NSMutableArray *addressListArray))successBlock fail:(void(^)(NSString *error))failBlock;
+ (void)requestAddCollectInfoModel:(Fcgo_GoodsInfoMsgModel *)infoModel success:(void(^)(void))successBlock fail:(void(^)(NSString *error))failBlock;
+ (void)requestCancelCollectinfoModel:(Fcgo_GoodsInfoMsgModel *)infoModel success:(void(^)(void))successBlock fail:(void(^)(NSString *error))failBlock;
@end

