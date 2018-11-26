//
//  Fcgo_OrderList_UIBaisc_VC.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/22.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_OrderList_UIBaisc_VC : Fcgo_BasicVC


@property(nonatomic,assign) NSInteger type; //1 是一般，2，3是保税和跨境

- (void)requestOrderListWithStatus:(NSString *)status;

@end
