//
//  Fcgo_OrderConfirmVC.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_OrderBuyModel.h"
#import "Fcgo_AddressModel.h"
@interface Fcgo_OrderConfirmVC : Fcgo_BasicVC

@property (nonatomic,strong) Fcgo_OrderBuyModel   *model;
@property (nonatomic,strong) Fcgo_AddressModel    *selectedAdressModel;
@property (nonatomic, retain) NSMutableDictionary *paremtes;

@end

