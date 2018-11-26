//
//  Fcgo_OrderPayVC.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_OrderPayModel.h"

@interface Fcgo_OrderPayVC : Fcgo_BasicVC
@property (nonatomic,strong) Fcgo_OrderPayModel *model;
@property (nonatomic, copy) NSString    *orderNo;
@property (nonatomic,strong) void(^paySuccessBlock)(void);
@end
