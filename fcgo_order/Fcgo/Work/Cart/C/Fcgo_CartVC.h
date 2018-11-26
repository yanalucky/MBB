//
//  Fcgo_CartVC.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/10.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_AddressModel.h"
@interface Fcgo_CartVC : XHSegmentViewController


@property(nonatomic,copy) Fcgo_AddressModel *selectedAddressModel;
@property(nonatomic , assign) BOOL isNotTabbar;
@property(nonatomic,copy) void (^refreshBlock)(void);
- (void)postRequestCartList;
@end
