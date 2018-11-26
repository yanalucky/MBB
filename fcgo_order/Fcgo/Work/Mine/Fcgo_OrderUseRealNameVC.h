//
//  Fcgo_OrderUseRealNameVC.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/24.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_OrderBuyModel.h"
#import "Fcgo_RealNameModel.h"

@interface Fcgo_OrderUseRealNameVC : Fcgo_BasicVC

@property (nonatomic,strong) Fcgo_OrderBuyModel *model;

@property (nonatomic,copy) void(^selectedBlock)(Fcgo_RealNameModel *model);
@end
