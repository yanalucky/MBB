//
//  Fcgo_MsgViewModel.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RequestSuccessBlock)(NSMutableArray *msgMutableArray);
typedef void(^RequestFailBlock)(void);

@interface Fcgo_MsgViewModel : NSObject

+ (void)postRequestSystemMsgListSuccess:(RequestSuccessBlock )requestSuccessBlock
                           ofFail:(RequestFailBlock )requestFailBlock;
+ (void)postRequestOrderMsgListSuccess:(RequestSuccessBlock )requestSuccessBlock
                                ofFail:(RequestFailBlock )requestFailBlock;

@end
