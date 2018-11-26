//
//  Fcgo_MsgOrderModel.h
//  Fcgo
//
//  Created by huafanxiao on 2017/7/6.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fcgo_MsgOrderModel : NSObject

@property (nonatomic,copy) NSString *message,*created,*gotoUrl,*receiveTel,
*sendTime;
@property (nonatomic,strong) NSNumber *status,*smsType,*f_msg_id;

@end
