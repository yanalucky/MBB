//
//  Fcgo_AFHTTPSessionManager.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/8.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_AFHTTPSessionManager.h"

@implementation Fcgo_AFHTTPSessionManager

+ (instancetype)sharedClient
{
    static Fcgo_AFHTTPSessionManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[Fcgo_AFHTTPSessionManager alloc] initWithBaseURL:nil];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain",@"text/json",@"text/javascript",@"text/html",nil];
        [_sharedClient.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"User-Agent"];
        _sharedClient.securityPolicy.allowInvalidCertificates = YES;
        _sharedClient.securityPolicy.validatesDomainName = NO;
        _sharedClient.requestSerializer.timeoutInterval=15.0f;
    });
    return _sharedClient;
}

@end
