//
//  Fcgo_GoodsInfoRequestViewModel.m
//  Fcgo
//
//  Created by huafanxiao on 2017/12/25.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_GoodsInfoRequestViewModel.h"

@implementation Fcgo_GoodsInfoRequestViewModel

+ (void)requestCollectWithGoodsID:(NSNumber *)goodsId success:(void(^)(BOOL isCollect))successBlock fail:(void(^)(NSString *error))failBlock
{
    NSMutableDictionary   *paremtes = [NSMutableDictionary dictionary];
    [paremtes  setObjectWithNullValidate:goodsId forKey:@"goodsId"];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, @"mch/favorite/", @"exist") parametersContentCommon:paremtes successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            BOOL isCollect = [[responseObject objectForKey:@"data"] boolValue];
            successBlock(isCollect);
        } else {
            failBlock(@"获取收藏接口错误");
        }
    } failureBlock:^(NSString *description) {
        failBlock(@"获取收藏接口错误");
    }];
}

+ (void)requestGoodsCarNumSuccess:(void(^)(NSNumber *cartNum))successBlock fail:(void(^)(NSString *error))failBlock{
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, SHOPCARMETHOD, @"shopcarNum")
             parametersContentCommon:nil
                        successBlock:^(BOOL success, id responseObject, NSString *msg)
     {
         if (success) {
             NSNumber *cartNum = responseObject[@"data"];
             successBlock(cartNum);
         }else {
             failBlock(@"获取购物车接口错误");
         }
     } failureBlock:^(NSString *description) {
         failBlock(@"获取购物车接口错误");
     }];
}

+ (void)requestGoodsBasicMsgWithGoodsValue:(NSNumber *)goodsValue goodsType:(NSString *)goodsType success:(void(^)(Fcgo_GoodsInfoMsgModel *infoModel))successBlock fail:(void(^)(NSString *error))failBlock
{
    NSMutableDictionary   *paremtes = [NSMutableDictionary dictionary];
    [paremtes  setObjectWithNullValidate:goodsValue forKey:@"goodsValue"];
    [paremtes  setObjectWithNullValidate:goodsType forKey:@"goodsType"];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,GOODMETHOD, @"goodsDetail") parametersContentCommon:paremtes successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            //活动商品时间解析model
            Fcgo_GoodsInfoActivityModel *activityModel = [[Fcgo_GoodsInfoActivityModel alloc]init];
            //如果有end字段，即是整点抢的商品详情页
            id isActivity = responseObject[@"data"][@"status"];
            if (isActivity) {
                activityModel.end = responseObject[@"data"][@"end"];
                activityModel.start = responseObject[@"data"][@"start"];
                activityModel.now = responseObject[@"data"][@"now"];
                activityModel.status = responseObject[@"data"][@"status"];
                NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
                long long dTime = [[NSNumber numberWithDouble:time] longLongValue];
                long long nowTime = activityModel.now.longLongValue / 1000.0;
                activityModel.time_interval = nowTime - dTime;
            }
            //获取商品详情的描述图片
           NSString *f_html_content = (NSString *)responseObject[@"data"][@"goodsDetail"][@"htmlContent"];
            NSString * head = @"<head><style>p{text-align:center;}img{width:100%;}</style></head>";
            f_html_content = [NSString stringWithFormat:@"<html>%@<body>%@</body></html>",head,f_html_content];
            //获取商品的滑动大图
            NSArray *picurlsArray = (NSArray *)responseObject[@"data"][@"urls"];
            
            id goodsInfo = responseObject[@"data"][@"goodsInfo"];
            Fcgo_GoodsInfoMsgModel *infoModel = [Fcgo_GoodsInfoMsgModel yy_modelWithDictionary:goodsInfo];
            infoModel.minpriceYUAN = responseObject[@"data"][@"minpriceYUAN"];
            infoModel.freight_s = @"--";
            infoModel.stock_s   = @"--";
            infoModel.picUrl = picurlsArray;
            infoModel.f_html_content = f_html_content;
            
            Fcgo_BrandModel *brandModel = [Fcgo_BrandModel shareWithNSDictionary:(NSDictionary *)responseObject[@"data"][@"goodsBrand"]];
            brandModel.brandSaleNum = responseObject[@"data"][@"brandSaleNum"];
            infoModel.brandModel = brandModel;
            infoModel.addCount = @1;
            
            NSMutableArray *activityArray = [NSMutableArray array];
            NSArray *activity_Array = responseObject[@"data"][@"activity"];
            if (activity_Array.count>0) {
                for (int i = 0; i < activity_Array.count; i ++) {
                    NSDictionary *activityDict = activity_Array[i];
                    Fcgo_ActivityModel *model = [Fcgo_ActivityModel yy_modelWithDictionary:activityDict];
                    [activityArray addObject:model];
                }
            }
            infoModel.activityArray = activityArray;
            infoModel.activityModel = activityModel;
            successBlock(infoModel);
            
        }else{
            failBlock(@"获取商品信息接口错误");
        }
    } failureBlock:^(NSString *description) {
        failBlock(@"获取商品信息接口错误");
    }];
}

+ (void)requestGoodsSKUMsgWithGoodsValue:(NSNumber *)goodsValue
                                goodsType:(NSString *)goodsType
                           saveAttrsArray:(NSMutableArray *)selectedPropertyArray
                                infoModel:(Fcgo_GoodsInfoMsgModel *)infoModel
                             addressModel:(Fcgo_AddressModel *)addressModel
                                  success:(void(^)(Fcgo_GoodsSkuModel  *skuModel,NSMutableArray *selectedPropertyArray))successBlock
                                     fail:(void(^)(NSString *error))failBlock
{
    NSMutableDictionary   *paremtes = [NSMutableDictionary dictionary];
    NSMutableString *attrs = [NSMutableString string];
    if (selectedPropertyArray.count<=0) {
        [attrs setString:@""];
    }
    else{
        for (int i = 0; i < selectedPropertyArray.count; i ++) {
            NSDictionary *dict = selectedPropertyArray[i];
            NSString *attr_name = dict[@"attr_name"];
            if (i == 0) {
                [attrs setString:attr_name];
            }
            else{
                [attrs appendString:[NSString stringWithFormat:@",%@",attr_name]];
            }
        }
    }
    [paremtes setObjectWithNullValidate:attrs forKey:@"chooseProperty"];
    NSMutableDictionary   *tempDic = [NSMutableDictionary dictionary];
    
    
    NSNumber *addCount = @1;
    NSNumber *lowest = @0;
    if (infoModel) {
        if (infoModel.texes.intValue == 2||infoModel.texes.intValue == 3) {
            addCount = @1;
        }else{
            addCount = infoModel.addCount;
        }
        lowest  = infoModel.isLowerPrice;
    }
    [tempDic  setObjectWithNullValidate:addCount forKey:@"goodsNumber"];
    [tempDic  setObjectWithNullValidate:goodsType forKey:@"goodsType"];
    [tempDic  setObjectWithNullValidate:goodsValue forKey:@"goodsValue"];
    [paremtes setObject:[Fcgo_publicNetworkTools dictionaryToJson:tempDic] forKey:@"goods"];
    [paremtes  setObjectWithNullValidate:addressModel.addressArea forKey:@"area"];
    [paremtes setObjectWithNullValidate:lowest forKey:@"lowest"];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,GOODMETHOD, @"skus") parametersContentCommon:paremtes successBlock:^(BOOL success, id responseObject, NSString *msg) {
        [WSProgressHUD dismiss];
        if (success) {
            Fcgo_GoodsSkuModel *skuModel;
            //从网络返回的属性分类
            NSMutableArray *attrArray = [NSMutableArray array];
            NSDictionary *dataDict = responseObject[@"data"];
            NSArray *skusArray = dataDict[@"sku"];
            skuModel = [Fcgo_GoodsSkuModel yy_modelWithDictionary:@{}];
            if (dataDict.count<=0 || skusArray.count<=0) {
                skuModel.canBuy = false;
            }
            else {
                if ([[dataDict objectForKey:@"ret"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *bestSkuDict = [dataDict objectForKey:@"ret"][@"data"][@"bestSku"];
                    skuModel = [Fcgo_GoodsSkuModel yy_modelWithDictionary:bestSkuDict];
                }
                for (int i = 0; i < skusArray.count; i ++) {
                    NSDictionary *skuDict = skusArray[i];
                    Fcgo_GoodsAttrsModel *model = [Fcgo_GoodsAttrsModel yy_modelWithDictionary:skuDict];
                    for (int i = 0;  i < model.dataArray.count; i ++) {
                        Fcgo_GoodsPropertyModel *propertyModel = model.dataArray[i];
                        if (model.dataArray.count == 1) {
                            propertyModel.clas = @"item selected";
                        }
                        if ([propertyModel.clas isEqualToString:@"item selected"]) {
                            BOOL isSame = NO;
                            for (int j = 0; j < selectedPropertyArray.count; j ++) {
                                NSDictionary *addDict = selectedPropertyArray[j];
                                NSString *properties_name = addDict[@"properties_name"];
                                NSString *attr = addDict[@"attr_name"];
                                if ([model.f_properties_name isEqualToString:properties_name] && [propertyModel.f_value_name isEqualToString:attr]) {
                                    isSame = YES;
                                }
                            }
                            if (!isSame) {
                                NSDictionary *addDict1 = @{@"properties_name":model.f_properties_name,@"attr_name":propertyModel.f_value_name};
                                [selectedPropertyArray addObject:addDict1];
                            }
                        }
                    }
                    [attrArray addObject:model];
                    skuModel.canBuy = true;
                }
                skuModel.attrsArray = attrArray;
                
            }
            successBlock(skuModel,selectedPropertyArray);
    }else{
        failBlock(@"获取商品属性接口错误");
    }
        
    } failureBlock:^(NSString *description) {
         failBlock(@"获取商品属性接口错误");
    }];
}

+ (void)requestStoreAddressListSuccess:(void(^)(NSMutableArray *addressListArray))successBlock fail:(void(^)(NSString *error))failBlock
{
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,ADDRESSMETHOD, @"storeAddressList") parametersContentCommon:nil successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            NSMutableArray *addressListArray = [NSMutableArray array];
            NSArray  *listArray = responseObject[@"data"];
            if (!listArray || listArray.count<=0) {
                [WSProgressHUD showImage:nil status:@"获取地址错误"];
                return ;
            }
            for (int i = 0; i < listArray.count; i++) {
                NSMutableDictionary *dic = listArray[i];
                Fcgo_AddressModel *model = [Fcgo_AddressModel yy_modelWithDictionary:dic];
                [addressListArray addObject:model];
            }
            successBlock(addressListArray);
        }else{
            failBlock(@"获取收货地址接口错误");
        }
        
    } failureBlock:^(NSString *description) {
        failBlock(@"获取收货地址接口错误");
    }];
}

+ (void)requestAddCollectInfoModel:(Fcgo_GoodsInfoMsgModel *)infoModel
                           success:(void(^)(void))successBlock
                              fail:(void(^)(NSString *error))failBlock
{
    NSMutableDictionary *paremtes = [NSMutableDictionary dictionary];
    [paremtes  setObjectWithNullValidate:infoModel.goods_id forKey:@"goodsId"];
    [paremtes  setObjectWithNullValidate:@"ios" forKey:@"source"];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, @"mch/favorite/", @"add") parametersContentCommon:paremtes successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            successBlock();
        }else{
            failBlock(@"加入收藏接口错误");
        }
        
    } failureBlock:^(NSString *description) {
        failBlock(@"加入收藏接口错误");
    }];
}

+ (void)requestCancelCollectinfoModel:(Fcgo_GoodsInfoMsgModel *)infoModel success:(void(^)(void))successBlock fail:(void(^)(NSString *error))failBlock
{
    NSMutableDictionary   *paremtes = [NSMutableDictionary dictionary];
    [paremtes  setObjectWithNullValidate:infoModel.goods_id forKey:@"goodsId"];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, @"mch/favorite/", @"del") parametersContentCommon:paremtes successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
             successBlock();
        }else
        {
            failBlock(@"取消收藏接口错误");
        }
    } failureBlock:^(NSString *description) {
        failBlock(@"取消收藏接口错误");
    }];
}
@end
