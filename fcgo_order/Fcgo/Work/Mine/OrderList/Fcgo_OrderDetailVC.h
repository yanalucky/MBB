//
//  Fcgo_OrderDetailVC.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/25.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_OrderListModel.h"

@interface Fcgo_OrderDetailVC : Fcgo_BasicVC

@property (nonatomic,copy) NSString *orderId;
@property (nonatomic,copy) void(^disappearBlock)(void);
@end
