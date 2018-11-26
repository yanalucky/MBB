//
//  Fcgo_NetworkManager.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/8.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_NetworkManager.h"
#import "Fcgo_AFHTTPSessionManager.h"
#import "Fcgo_Tools.h"
#import "Fcgo_ClassTools.h"

@implementation Fcgo_NetworkManager

+ (void)postRequest:(NSString *)url
parametersContentCommon:(NSMutableDictionary *)parameters
       successBlock:(SuccessBlock)successBlock
       failureBlock:(FailureBlock)failureBlock {
    if (![Fcgo_Tools isNetworkConnected]) {
        [WSProgressHUD showImage:nil status:@"亲,没联网啊"];
        failureBlock(@"亲,没联网啊");
        return;
    }
    if (parameters == nil) {
        parameters=[[NSMutableDictionary  alloc] init];
    }
    [parameters  setObjectWithNullValidate:Dev_App_Version forKey:@"f_app_version"];
    [parameters  setObjectWithNullValidate:Token forKey:@"token"];
    [parameters  setObjectWithNullValidate:Dev_Channel forKey:@"f_channel"];
    [parameters setObjectWithNullValidate:MerId forKey:@"storeId"];
    [parameters setObjectWithNullValidate:MchId forKey:@"mchId"];
    [parameters setObjectWithNullValidate:OperatorId forKey:@"operatorId"];
    [parameters setObjectWithNullValidate:Dev_no forKey:@"f_dev_no"];
    [parameters setObjectWithNullValidate:Dev_system_no forKey:@"dev_system_no"];
    [parameters setObjectWithNullValidate:Dev_brand forKey:@"dev_brand"];
    [parameters setObjectWithNullValidate:Dev_IPAdd forKey:@"ip"];
    Fcgo_AFHTTPSessionManager   *manager =[Fcgo_AFHTTPSessionManager  sharedClient];
    NSMutableString *temp = [url mutableCopy];
    temp = [temp stringByAppendingString:@"?"].mutableCopy;
    for (id obj in parameters.allKeys) {
        temp = [temp stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",obj,parameters[obj]]].mutableCopy;
    }
    NSLog(@">>>>>>>>get method = %@",[[temp stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         [WSProgressHUD dismiss];
        //NSLog(@"%@\n>>responseObject>>>%@",url,responseObject);
        if ([responseObject isKindOfClass:[NSDictionary  class]]) {
            NSDictionary *responseDic = (NSDictionary *)responseObject;
            if ([responseDic objectForKey:@"errorCode"]&&[[responseDic objectForKey:@"errorCode"] integerValue] == 0) {
                //请求成功
                successBlock(YES,responseObject,responseObject[@"errorMsg"]);
            }
            else {
                //请求不正常也返回接收数据
                successBlock(NO,responseObject,responseObject[@"errorMsg"]);
                if ([responseDic objectForKey:@"errorCode"]&&[[responseDic objectForKey:@"errorCode"] integerValue] == 60012) {
                    //token无效 账户已在其他地方登录
                    [WSProgressHUD showErrorWithStatus:@"账户已在其它地方登录\n请重新登录"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [Fcgo_Delegate setLoginVCToRootVC];
                    });
                }
                else if ([responseDic objectForKey:@"errorCode"]&&[[responseDic objectForKey:@"errorCode"] integerValue] == 220000) {
                    [WSProgressHUD showImage:nil status:@"账号过期,请重新登录"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [Fcgo_Delegate setLoginVCToRootVC];
                    });
                }
                else {
                    //数据错误
                    if ([responseDic objectForKey:@"errorMsg"]&&[[responseDic objectForKey:@"errorMsg"] isKindOfClass:[NSString class]])
                    {
                        [WSProgressHUD showImage:nil status:[responseDic objectForKey:@"errorMsg"]];
                    }
                }
            }
        }
        else {
            successBlock(NO,responseObject,responseObject[@"errorMsg"]);
            [WSProgressHUD showErrorWithStatus:@"网络请求失败"];
        }
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //NSLog(@">>error>>>%@",error.description);
        [WSProgressHUD dismiss];
        if (failureBlock) {
            [WSProgressHUD showErrorWithStatus:@"网络请求失败"];
            failureBlock(error.description);
        }
    }];
}

+ (void)getRequest:(NSString *)url
    parametersContentCommon:(NSMutableDictionary *)parameters
      successBlock:(SuccessBlock)successBlock
      failureBlock:(FailureBlock)failureBlock {

    if (![Fcgo_Tools isNetworkConnected]) {
        [WSProgressHUD showImage:nil status:@"亲,没联网啊"];
        failureBlock(@"");
        return;
    }
    if (parameters == nil) {
        parameters=[[NSMutableDictionary  alloc] init];
    }
    [parameters  setObjectWithNullValidate:Dev_App_Version forKey:@"f_app_version"];
    [parameters  setObjectWithNullValidate:Token forKey:@"token"];
    [parameters  setObjectWithNullValidate:Dev_Channel forKey:@"f_channel"];
    [parameters setObjectWithNullValidate:MerId forKey:@"storeId"];
    [parameters setObjectWithNullValidate:MchId forKey:@"mchId"];
    [parameters setObjectWithNullValidate:OperatorId forKey:@"operatorId"];
    [parameters setObjectWithNullValidate:Dev_no forKey:@"f_dev_no"];
    [parameters setObjectWithNullValidate:Dev_system_no forKey:@"dev_system_no"];
    [parameters setObjectWithNullValidate:Dev_brand forKey:@"dev_brand"];
    [parameters setObjectWithNullValidate:Dev_IPAdd forKey:@"ip"];
    Fcgo_AFHTTPSessionManager   *manager =[Fcgo_AFHTTPSessionManager  sharedClient];
    NSMutableString *temp = [url mutableCopy];
    temp = [temp stringByAppendingString:@"?"].mutableCopy;
    for (id obj in parameters.allKeys) {
        temp = [temp stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",obj,parameters[obj]]].mutableCopy;
    }
    url  = [temp stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       NSLog(@"%@\n>>responseObject>>>%@",url,responseObject);
       if ([responseObject isKindOfClass:[NSDictionary  class]]) {
           NSDictionary *responseDic = (NSDictionary *)responseObject;
           if ([responseDic objectForKey:@"errorCode"]&&[[responseDic objectForKey:@"errorCode"] integerValue] == 0) {
               //请求成功
               successBlock(YES,responseObject,responseObject[@"errorMsg"]);
           }
           else {
               //请求不正常也返回接收数据
               successBlock(NO,responseObject,responseObject[@"errorMsg"]);
               if ([responseDic objectForKey:@"errorCode"]&&[[responseDic objectForKey:@"errorCode"] integerValue] == 60012) {
                   //token无效 账户已在其他地方登录
                   [WSProgressHUD showErrorWithStatus:@"账户已在其它地方登录\n请重新登录"];
                   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                       [Fcgo_Delegate setLoginVCToRootVC];
                   });
               }
               else if ([responseDic objectForKey:@"errorCode"]&&[[responseDic objectForKey:@"errorCode"] integerValue] == 220000) {
                   [WSProgressHUD showImage:nil status:@"账号过期,请重新登录"];
                   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                       [Fcgo_Delegate setLoginVCToRootVC];
                   });
               }
               else {
                   //数据错误
                   if ([responseDic objectForKey:@"errorMsg"]&&[[responseDic objectForKey:@"errorMsg"] isKindOfClass:[NSString class]])
                   {
                       [WSProgressHUD showImage:nil status:[responseDic objectForKey:@"errorMsg"]];
                   }
               }
           }
       }
       else {
           successBlock(NO,responseObject,responseObject[@"errorMsg"]);
           [WSProgressHUD showErrorWithStatus:@"网络请求失败"];
       }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@">>error>>>%@",error.description);
        [WSProgressHUD dismiss];
        if (failureBlock) {
            [WSProgressHUD showErrorWithStatus:@"网络请求失败"];
            failureBlock(error.description);
        }
    }];
}

@end
