//
//  Fcgo_publicNetworkTools.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/16.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RequestSuccessBlock)(NSMutableArray *mutableArray);
typedef void(^RequestFailBlock)(void);

@interface Fcgo_publicNetworkTools : NSObject

//请求地址数据
+ (void)postRequestAreaLocalListSuccessBlock:(RequestSuccessBlock)successBlock
                                failureBlock:(RequestFailBlock)failBlock;

//请求版本更新
+ (void)postRequestViesion;

+ (void)postCheckToken;

+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
/// array->jsonString
+ (NSString *)arrayToJson:(NSArray *)array;

@end
