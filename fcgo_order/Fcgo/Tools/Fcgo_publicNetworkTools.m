//
//  Fcgo_publicNetworkTools.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/16.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_publicNetworkTools.h"

@implementation Fcgo_publicNetworkTools


+ (NSString*)dictionaryToJson:(NSDictionary *)dic{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

+ (NSString *)arrayToJson:(NSArray *)array {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (void)postRequestAreaLocalListSuccessBlock:(RequestSuccessBlock)successBlock
                                failureBlock:(RequestFailBlock)failBlock
{
    //@"http://www.ddhshop.com/v1/app/area_list.html"
    NSMutableDictionary *mutaDict=[[NSMutableDictionary alloc]init];
    [mutaDict  setObjectWithNullValidate:@"ios" forKey:@"key"];
    [Fcgo_NetworkManager  postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,COMMONMETHOD, @"provinceCityAreaList")
                           parametersContentCommon:mutaDict successBlock:^(BOOL success, id responseObject, NSString *msg)
    {
        if (success) {
            if ([responseObject objectForKey:@"data"] && [[responseObject objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
                NSArray  *dataArr =(NSArray  *)[responseObject objectForKey:@"data"];
                [Fcgo_UserTools shared].cityArray= [NSMutableArray  arrayWithArray:dataArr];
                [self reloadUserAddressDict];
                if (successBlock)
                    successBlock([NSMutableArray array]);
            }
        }
    } failureBlock:^(NSString *description) {
        if (failBlock)
            failBlock();
    }];
}

//处理后存储
+ (void)reloadUserAddressDict
{
    if(![Fcgo_UserTools shared].userDict) return;
    NSMutableDictionary *mutableDict = [NSMutableDictionary  dictionary];
    for (NSDictionary *proDic in [Fcgo_UserTools shared].cityArray) {
        for (NSDictionary *cityDic in [proDic objectForKey:@"city"]) {
            for (NSDictionary *areaDic in [cityDic objectForKey:@"area"]) {
                if ([[areaDic objectForKey:@"areaId"] intValue] == [[Fcgo_UserTools shared].userDict[@"storeArea"] intValue]){
                    NSDictionary *dic = @{@"areaName":[proDic objectForKey:@"areaName"],@"areaId":[proDic objectForKey:@"areaId"]};
                    
                    [mutableDict  setObjectWithNullValidate:dic forKey:@"province"];
                    NSDictionary *dic1 = @{@"areaName":[cityDic objectForKey:@"areaName"],@"areaId":[cityDic objectForKey:@"areaId"]};

                    [mutableDict  setObjectWithNullValidate:dic1 forKey:@"city"];
                    NSDictionary *dic2 = @{@"areaName":[areaDic objectForKey:@"areaName"],@"areaId":[areaDic objectForKey:@"areaId"]};
                    
                    [mutableDict  setObjectWithNullValidate:dic2 forKey:@"area"];
                    break;
                }
            }
        }
    }
    [Fcgo_UserTools shared].userAddressDict = mutableDict;
}

+ (void)postRequestViesion
{
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, COMMONMETHOD, @"version_ios") parametersContentCommon:nil successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            NSDictionary *data = responseObject[@"data"];
           if (data.count <= 0)
           {
               return ;
           }
//                errCode = 0,
//                data = 	{
//                    isForce = 0,
//                    updateContent = "测试",
//                    isIgnorable = 0,
//                    isSilent = 0,
//                    versionName = "v1.1.3",
//                    versionCode = "113",
//                },
//                errMsg = "ok",
           //是否强制下载 0代表强制
           NSNumber *isForce = responseObject[@"data"][@"isForce"];
           //是否可以忽略此版本，0代表不可忽略
           NSNumber *isIgnorable = responseObject[@"data"][@"isIgnorable"];
           //版本名称
           NSString *versionName = responseObject[@"data"][@"versionName"];
           //版本号
           NSString *versionCode = responseObject[@"data"][@"versionCode"];
           //版本介绍
           NSString *updateContent = responseObject[@"data"][@"updateContent"];
           
           NSString *currentAppVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
           
           versionName = [[versionName componentsSeparatedByString:@"v"] lastObject];
//            isIgnorable = @0;
          //updateContent = @"1.是大美女辅导费电脑发你的带你飞地方|2.电脑卡愤怒的地方的开发那地方你看|3.大幅度看你发的电脑卡发你的";
            //versionName = @"2.0.1";
            
          if (![self compareVersionsFormAppStoreVersion:versionName currentAppVersion:currentAppVersion]) {
               return ;
           }
           //isForce = @1;
           if (isForce.intValue == 0) {
               [Fcgo_UpdateAnimationView showWithTextString:updateContent versions:versionName isMustUpdate:1];
           }
           else
           {
               NSString *version = [OBJC_Defaults objectForKey:@"version"];
               if ([version isEqualToString:versionName]) {
                   return;
               }
               if (isIgnorable.intValue == 0) {
                   [Fcgo_UpdateAnimationView showWithTextString:updateContent versions:versionName isMustUpdate:0];
               }
           }
           
       }
        else
        {
            
        }
    } failureBlock:^(NSString *description) {}];
}



+ (void)postCheckToken
{
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, COMMONMETHOD, @"checkToken") parametersContentCommon:nil successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {}else{}
    } failureBlock:^(NSString *description) {}];
}

+ (BOOL)compareVersionsFormAppStoreVersion:(NSString*)AppStoreVersion currentAppVersion:(NSString*)currentAppVersion {
    
    BOOL littleSunResult = false;
    if ([Fcgo_Tools isNullString:AppStoreVersion]) {
        return littleSunResult;
    }
    
    NSMutableArray* a = (NSMutableArray*) [AppStoreVersion componentsSeparatedByString: @"."];
    NSMutableArray* b = (NSMutableArray*) [currentAppVersion componentsSeparatedByString: @"."];
    while (a.count < b.count) { [a addObject: @"0"]; }
    while (b.count < a.count) { [b addObject: @"0"]; }
    
    for (int j = 0; j<a.count; j++) {
        if ([[a objectAtIndex:j] integerValue] > [[b objectAtIndex:j] integerValue]) {
            littleSunResult = true;
            break;
        }else if([[a objectAtIndex:j] integerValue] < [[b objectAtIndex:j] integerValue]){
            littleSunResult = false;
            break;
        }else{
            littleSunResult = false;
        }
    }
    return littleSunResult;//true就是有新版本，false就是没有新版本
}

@end
