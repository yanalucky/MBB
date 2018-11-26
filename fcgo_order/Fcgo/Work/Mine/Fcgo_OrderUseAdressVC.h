//
//  Fcgo_OrderUseAdressVC.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/24.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_OrderBuyModel.h"
#import "Fcgo_AddressModel.h"

@interface Fcgo_OrderUseAdressVC : Fcgo_BasicVC

@property (nonatomic,strong) Fcgo_OrderBuyModel *model;
@property (nonatomic, strong) Fcgo_AddressModel *addressModel;
@property (nonatomic,copy) void(^selectedBlock)(Fcgo_AddressModel *model);

@end
