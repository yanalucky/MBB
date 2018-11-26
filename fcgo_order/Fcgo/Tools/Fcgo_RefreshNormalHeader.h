//
//  Fcgo_RefreshNormalHeader.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/31.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//
#import "MJRefresh.h"

@interface Fcgo_RefreshNormalHeader : MJRefreshNormalHeader

+ (Fcgo_RefreshNormalHeader *)headerRefreshBlock:(void(^)(void))block;

@end
