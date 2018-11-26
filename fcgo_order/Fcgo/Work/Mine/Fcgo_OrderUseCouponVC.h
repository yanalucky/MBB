//
//  Fcgo_OrderUseCouponVC.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/24.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_CouponModel.h"

@interface Fcgo_OrderUseCouponVC : Fcgo_BasicVC

@property (nonatomic,strong) NSMutableArray *listArray;
@property (nonatomic,copy) void(^selectedBlock)(Fcgo_CouponModel *model);

@end
