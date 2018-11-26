//
//  Fcgo_GoodsInfoActivityModel.h
//  Fcgo
//
//  Created by huafanxiao on 2017/12/25.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fcgo_GoodsInfoActivityModel : NSObject
@property (nonatomic,strong) NSNumber *end,*now,*start,*status;
@property (nonatomic,assign) NSTimeInterval time_interval;
@end
