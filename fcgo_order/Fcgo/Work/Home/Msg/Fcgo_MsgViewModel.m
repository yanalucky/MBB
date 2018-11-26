//
//  Fcgo_MsgViewModel.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_MsgViewModel.h"
#import "Fcgo_MsgSystemModel.h"
#import "Fcgo_MsgOrderModel.h"

@implementation Fcgo_MsgViewModel

+ (void)postRequestSystemMsgListSuccess:(RequestSuccessBlock )requestSuccessBlock
                           ofFail:(RequestFailBlock )requestFailBlock
{
    NSMutableDictionary *paremeters =[NSMutableDictionary  dictionary];
    [paremeters setObjectWithNullValidate:@1 forKey:@"pageNo"];
    [Fcgo_NetworkManager  postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,NOTICEMETHOD, @"system") parametersContentCommon:paremeters successBlock:^(BOOL success, id responseObject, NSString *msg)
    {
       NSDictionary *objectDict = (NSDictionary *)responseObject;
        if ([objectDict.allKeys containsObject:@"data"]) {
            NSArray *dataArray = objectDict[@"data"][@"data"];
            NSMutableArray *msgMutableArray = [NSMutableArray array];
            for (int i = 0; i < dataArray.count; i ++) {
                NSDictionary *msgDetailDict = dataArray[i];
                Fcgo_MsgSystemModel *systemModel = [Fcgo_MsgSystemModel yy_modelWithDictionary:msgDetailDict];
                [msgMutableArray addObject:systemModel];
            }
            requestSuccessBlock(msgMutableArray);
        }
       
        
    } failureBlock:^(NSString *description) {
        requestFailBlock();
    }];
}

+ (void)postRequestOrderMsgListSuccess:(RequestSuccessBlock )requestSuccessBlock
                                ofFail:(RequestFailBlock )requestFailBlock
{
    NSMutableDictionary *muatble =[NSMutableDictionary  dictionary];
    
    [muatble  setObjectWithNullValidate:@1 forKey:@"pageNo"];
    [muatble setObjectWithNullValidate:@"10" forKey:@"rows"];
    
    [Fcgo_NetworkManager  postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,NOTICEMETHOD, @"order") parametersContentCommon:muatble successBlock:^(BOOL success, id responseObject, NSString *msg)
     {
         NSDictionary *objectDict = (NSDictionary *)responseObject;
         NSArray *dataArray = objectDict[@"data"][@"data"];
         NSMutableArray *msgMutableArray = [NSMutableArray array];
         for (int i = 0; i < dataArray.count; i ++) {
             NSDictionary *msgDetailDict = dataArray[i];
             Fcgo_MsgOrderModel *msgModel = [Fcgo_MsgOrderModel yy_modelWithDictionary:msgDetailDict];
             [msgMutableArray addObject:msgModel];
         }
         requestSuccessBlock(msgMutableArray);

    } failureBlock:^(NSString *description) {
         requestFailBlock();
     }];
}

@end
