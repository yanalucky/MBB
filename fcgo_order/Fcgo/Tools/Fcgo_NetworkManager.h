//
//  Fcgo_NetworkManager.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/8.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(BOOL success,id responseObject,NSString* msg);
typedef void(^FailureBlock)(NSString* description);

@interface Fcgo_NetworkManager : NSObject

+ (void)postRequest:(NSString *)url
parametersContentCommon:(NSMutableDictionary *)parameters
       successBlock:(SuccessBlock)successBlock
       failureBlock:(FailureBlock)failureBlock;

+ (void)getRequest:(NSString *)url
parametersContentCommon:(NSMutableDictionary *)parameters
      successBlock:(SuccessBlock)successBlock
      failureBlock:(FailureBlock)failureBlock ;





@end
