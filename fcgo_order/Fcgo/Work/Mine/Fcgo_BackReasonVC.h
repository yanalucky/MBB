//
//  Fcgo_BackReasonVC.h
//  Fcgo
//
//  Created by fcg on 2017/10/25.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_BasicVC.h"
#import "Fcgo_AfterSalesServiceListModel.h"
@interface Fcgo_BackReasonVC : Fcgo_BasicVC

@property (nonatomic,assign) int index;

@property(nonatomic,strong)  Fcgo_AfterSalesServiceListModel *model;
@property(nonatomic,strong)  UIViewController *backVC;


@end
