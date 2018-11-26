//
//  Fcgo_AfterServiceStyleVC.h
//  Fcgo
//
//  Created by fcg on 2017/10/25.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_BasicVC.h"
#import "Fcgo_AfterSalesServiceListModel.h"
#import "Fcgo_AfterSalesApplyVC.h"
@interface Fcgo_AfterServiceStyleVC : Fcgo_BasicVC

@property(nonatomic,strong)  Fcgo_AfterSalesServiceListModel *model;
@property(nonatomic,strong)  UIViewController *backVC;
@end
