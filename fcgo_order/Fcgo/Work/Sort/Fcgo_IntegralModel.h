//
//  Fcgo_IntegralModel.h
//  Fcgo
//
//  Created by huafanxiao on 2017/7/5.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fcgo_IntegralModel : NSObject

@property (nonatomic,strong) NSNumber *end,*now,*start,*status;
@property (nonatomic,assign) NSTimeInterval time_interval;
@end
