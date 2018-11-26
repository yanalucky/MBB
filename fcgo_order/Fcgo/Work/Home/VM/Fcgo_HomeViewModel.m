//
//  Fcgo_HomeViewModel.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/15.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_HomeViewModel.h"
#import "Fcgo_HomeCycleModel.h"
#import "Fcgo_HomeSortIconModel.h"
#import "Fcgo_HomeWholePointModel.h"
#import "Fcgo_HomeTopicModel.h"
#import "Fcgo_HomeGoodsModel.h"

@implementation Fcgo_HomeViewModel
/*
+ (void)postRequestCycleListSuccess:(RequestSuccessBlock )requestSuccessBlock
                             ofFail:(RequestFailBlock )requestFailBlock
{
    NSMutableDictionary *paremeters =[NSMutableDictionary  dictionary];
    [Fcgo_NetworkManager  postRequest:NSFormatHeardUrl(@"bis/show/carouse/list") parameters:paremeters successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            NSDictionary *objectDict = (NSDictionary *)responseObject;
            NSArray *dataArray = objectDict[@"data"];
            NSMutableArray *cycleMutableArray = [NSMutableArray array];
            for (int i = 0; i < dataArray.count; i ++) {
                NSDictionary *cycleDetailDict = dataArray[i];
                Fcgo_HomeCycleModel *cycleModel = [Fcgo_HomeCycleModel yy_modelWithDictionary:cycleDetailDict];
                [cycleMutableArray addObject:cycleModel];
            }
            requestSuccessBlock(cycleMutableArray);
        }
        else{
           requestFailBlock();
        }
    } failureBlock:^(NSString *description) {
        requestFailBlock();
    }];
}

//请求H5数据
+ (void)postRequestH5Success:(void(^)(NSDictionary *dict))requestSuccessBlock
                      ofFail:(RequestFailBlock )requestFailBlock
{
    NSMutableDictionary *paremeters =[NSMutableDictionary  dictionary];
    [Fcgo_NetworkManager  postRequest:NSFormatHeardUrl(@"bis/show/index/html5.html") parameters:paremeters successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            NSDictionary *objectDict = (NSDictionary *)responseObject;
            NSDictionary *dataDict = objectDict[@"data"];
            if(dataDict.count>0)
            {
               requestSuccessBlock(dataDict); 
            }
        }
        else{
            requestFailBlock();
        }
    } failureBlock:^(NSString *description) {
        requestFailBlock();
    }];
}


+ (void)postRequestSortIconListSuccess:(RequestSuccessBlock )requestSuccessBlock
                                ofFail:(RequestFailBlock )requestFailBlock
{
    NSMutableDictionary *paremeters =[NSMutableDictionary  dictionary];
    [Fcgo_NetworkManager  postRequest:NSFormatHeardUrl(@"bis/show/index/indexIcon") parameters:paremeters successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            NSDictionary *objectDict = (NSDictionary *)responseObject;
            NSArray *dataArray = objectDict[@"data"];
            NSMutableArray *sortIconMutableArray = [NSMutableArray array];
            for (int i = 0; i < dataArray.count; i ++) {
                NSDictionary *sortIconDetailDict = dataArray[i];
                Fcgo_HomeSortIconModel *sortIconModel = [Fcgo_HomeSortIconModel yy_modelWithDictionary:sortIconDetailDict];
                [sortIconMutableArray addObject:sortIconModel];
            }
            requestSuccessBlock(sortIconMutableArray);
        }
        else{
            requestFailBlock();
        }
    } failureBlock:^(NSString *description) {
        requestFailBlock();
    }];
}

+ (void)postRequestGrabTheWholePointListSuccess:(RequestSuccessBlock )requestSuccessBlock
                                         ofFail:(RequestFailBlock )requestFailBlock
{
    [Fcgo_NetworkManager  postRequest:NSFormatHeardUrl(@"bis/promote/integral_now") parameters:nil successBlock:^(BOOL success, id responseObject, NSString *msg) {
       if(success)
       {
           NSDictionary *dataDict = (NSDictionary *)responseObject[@"data"];
           if (!dataDict) {
               requestSuccessBlock([NSMutableArray array]);
               return ;
           }
           NSMutableArray *wholePointMutableArray = [NSMutableArray array];
           Fcgo_HomeWholePointModel *wholePointModel = [Fcgo_HomeWholePointModel shareWithNSDictionary:dataDict];
           NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
           long long dTime = [[NSNumber numberWithDouble:time] longLongValue];
           long long nowTime = wholePointModel.now.longLongValue / 1000.0;
           wholePointModel.time_interval = nowTime - dTime;
           [wholePointMutableArray addObject:wholePointModel];
           requestSuccessBlock(wholePointMutableArray);
       }
       else{
           requestFailBlock();
       }
    } failureBlock:^(NSString *description) {
        requestFailBlock();
    }];
}

//请求专题和热门推荐数据
+ (void)postRequestChoseSpecilSuccess:(RequestSuccessBlock )requestSuccessBlock
                                            ofFail:(RequestFailBlock )requestFailBlock
{
    [Fcgo_NetworkManager postRequest:NSFormatHeardUrl(@"bis/show/index/topic") parameters:nil successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            NSMutableArray *topicMutableArray = [NSMutableArray array];
            NSArray *topicArray = responseObject[@"data"];
            for (int i = 0; i < topicArray.count; i ++) {
                 NSDictionary *topicDict = topicArray[i];
                 Fcgo_HomeTopicModel *model = [Fcgo_HomeTopicModel shareWithNSDictionary:topicDict];
                [topicMutableArray addObject:model];
            }
            requestSuccessBlock(topicMutableArray);
        }
        else{
            requestFailBlock();
        }
        
    } failureBlock:^(NSString *description) {
        requestFailBlock();
    }];
}

//请求活动促销数据
+ (void)postRequestPromoteListSuccess:(RequestSuccessBlock )requestSuccessBlock
                               ofFail:(RequestFailBlock )requestFailBlock
{
    [Fcgo_NetworkManager postRequest:NSFormatHeardUrl(@"bis/promote/bis_List") parameters:nil successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            //picUrl = "http://pic.90sjimg.com/back_pic/qk/back_origin_pic/00/04/22/a3d5d5b25d8109fea9e7265d6c9e945f.jpg",
           //href = "v2/app/bis/promote/comsale.html",
            NSArray *promoteArray = responseObject[@"data"];
            if (promoteArray.count<=0) {
                return ;
            }
            requestSuccessBlock([NSMutableArray arrayWithArray:promoteArray]);
        }
        else{
            requestFailBlock();
        }
    } failureBlock:^(NSString *description) {
        requestFailBlock();
    }];
}

+ (void)postRequestAdviceListWithPage:(int)page success:(RequestSuccessBlock )requestSuccessBlock
                              ofFail:(RequestFailBlock )requestFailBlock
{
    NSMutableDictionary *mutaDict=[[NSMutableDictionary alloc]init];
    [mutaDict  setObjectWithNullValidate:@(page) forKey:@"page"];
    [mutaDict  setObjectWithNullValidate:@(12) forKey:@"row"];
    [Fcgo_NetworkManager postRequest:NSFormatHeardUrl(@"goods/goodshotlist") parameters:mutaDict successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            NSArray *arr=(NSArray *)responseObject[@"data"];
            NSMutableArray *array = [NSMutableArray array];
            for (int i=0; i<arr.count; i++) {
                if ([arr[i] isKindOfClass:[NSDictionary class]]) {
                    Fcgo_HomeGoodsModel *model = [Fcgo_HomeGoodsModel yy_modelWithDictionary:arr[i]];
                    [array addObject:model];
                }
            }
            requestSuccessBlock(array);
        }
        else{
            requestFailBlock();
        }
    } failureBlock:^(NSString *description) {
        requestFailBlock();
    }];
}
*/
@end
