//
//  Fcgo_BackDetailVC.h
//  Fcgo
//
//  Created by fcg on 2017/10/26.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_BasicVC.h"
#import "Fcgo_AfterSalesServiceListModel.h"

@interface Fcgo_BackDetailVC : Fcgo_BasicVC

@property(nonatomic,assign) int type;
@property(nonatomic,strong)  NSString *reason;

@property(nonatomic,strong)  Fcgo_AfterSalesServiceListModel *model;
@property(nonatomic,strong)  UIViewController *backVC;



@end
