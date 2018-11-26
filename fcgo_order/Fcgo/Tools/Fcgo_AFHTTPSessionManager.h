//
//  Fcgo_AFHTTPSessionManager.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/8.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface Fcgo_AFHTTPSessionManager : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
