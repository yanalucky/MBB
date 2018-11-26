//
//  Fcgo_AfterSalesService_DetailVC.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/14.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_AfterSalesServiceListModel.h"

@interface Fcgo_AfterSalesService_DetailVC : Fcgo_BasicVC

@property (nonatomic,copy) NSString *f_apply_id;
@property (nonatomic,copy) void(^cancelApplyBlock)();

@end
