//
//  Fcgo_HomeViewModel.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/15.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RequestSuccessBlock)(NSMutableArray *mutableArray);
typedef void(^RequestFailBlock)(void);

@interface Fcgo_HomeViewModel : NSObject

//请求轮播数据
+ (void)postRequestCycleListSuccess:(RequestSuccessBlock )requestSuccessBlock
                             ofFail:(RequestFailBlock )requestFailBlock;


//请求H5数据
+ (void)postRequestH5Success:(void(^)(NSDictionary *dict))requestSuccessBlock
                                ofFail:(RequestFailBlock )requestFailBlock;
//请求分类图标数据
+ (void)postRequestSortIconListSuccess:(RequestSuccessBlock )requestSuccessBlock
                                         ofFail:(RequestFailBlock )requestFailBlock;
//请求整点抢数据
+ (void)postRequestGrabTheWholePointListSuccess:(RequestSuccessBlock )requestSuccessBlock
                                         ofFail:(RequestFailBlock )requestFailBlock;
//请求活动促销数据
+ (void)postRequestPromoteListSuccess:(RequestSuccessBlock )requestSuccessBlock
                                         ofFail:(RequestFailBlock )requestFailBlock;
//请求专题数据
+ (void)postRequestChoseSpecilSuccess:(RequestSuccessBlock )requestSuccessBlock
                                         ofFail:(RequestFailBlock )requestFailBlock;

//热门推荐数据
+ (void)postRequestAdviceListWithPage:(int)page success:(RequestSuccessBlock )requestSuccessBlock    ofFail:(RequestFailBlock )requestFailBlock;

@end
