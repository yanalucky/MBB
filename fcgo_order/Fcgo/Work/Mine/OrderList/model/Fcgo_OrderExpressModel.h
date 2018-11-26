//
//  Fcgo_OrderExpressModel.h
//  Fcgo
//
//  Created by by_r on 2017/11/24.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fcgo_OrderExpressModel : NSObject
@property (nonatomic, copy) NSString    *expressNo; ///< 物流编号
@property (nonatomic, copy) NSString    *expressId; ///< 物流公司或缩写
@property (nonatomic, copy) NSString    *expressName;
@property (nonatomic, copy) NSString    *createTime;
@property (nonatomic, copy) NSString    *updateTime;
@property (nonatomic, strong) NSNumber  *ID; ///< int 物流信息
@property (nonatomic, strong) NSNumber  *orderId; ///< int
@property (nonatomic, strong) NSNumber  *orderChildId; ///< int
@end

@class Fcgo_orderExpressData;
@interface Fcgo_OrderExpressUnit : NSObject
@property (nonatomic, copy) NSString    *expressWapUrl;
@property (nonatomic, copy) NSString    *nu;
@property (nonatomic, copy) NSString    *state;
@property (nonatomic, copy) NSString    *data;
@property (nonatomic, copy) NSString    *com;
@property (nonatomic, copy) NSString    *name;
@property (nonatomic, copy) NSString    *expressPcUrl;
@property (nonatomic, strong) NSNumber  *ID;
@property (nonatomic, strong) NSArray<Fcgo_orderExpressData *> *dataArray;

@property (nonatomic, assign) BOOL  open;
@property (nonatomic, copy) NSString    *createTime;
@end

@interface Fcgo_orderExpressData : NSObject
@property (nonatomic, copy) NSString    *context;
@property (nonatomic, copy) NSString    *ftime;
@property (nonatomic, copy) NSString    *time;
@end
