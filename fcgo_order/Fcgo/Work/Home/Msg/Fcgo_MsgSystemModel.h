//
//  Fcgo_MsgSystemModel.h
//  Fcgo
//
//  Created by huafanxiao on 2017/7/6.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fcgo_MsgSystemModel : NSObject
@property (nonatomic,strong) NSString *created,*content,*endTime,*startTime,
*texturl,*title;
@property (nonatomic,strong) NSNumber *f_new,*fcgo_id,*state,*f_msg_id,*f_stick;
@end
