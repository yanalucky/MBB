//
//  Fcgo_Cart_YB_VC.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/22.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_AddressModel.h"
@interface Fcgo_Cart_YB_VC : Fcgo_BasicVC
@property(nonatomic, assign)BOOL haveNavBar;

@property(nonatomic,strong) NSDictionary *normalDict;
@property(nonatomic,copy) void (^refreshBlock)(void);
@property(nonatomic , assign) BOOL isNotTabbar;
@property(nonatomic,strong) Fcgo_AddressModel *selectedAddressModel;
- (void)noNetwork:(BOOL)isShow;
@end
