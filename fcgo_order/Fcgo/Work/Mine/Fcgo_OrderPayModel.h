//
//  Fcgo_OrderPayModel.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/24.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fcgo_OrderPayModel : NSObject

@property (nonatomic, copy) NSString    *orderNo;
@property (nonatomic, strong) NSNumber   *totalp;
//@property (nonatomic, assign) NSTimeInterval time_interval;//记录服务器当前时间与手机本地时间的时间差
@property (nonatomic, strong) NSNumber  *orderId;
@property (nonatomic, copy) NSString    *materials;
@property (nonatomic, copy) NSString    *postage;
@property (nonatomic, copy) NSString    *coupons;
@property (nonatomic, copy) NSString    *payPrice;
//@property (nonatomic, copy) NSString    *totalPrice;
@property (nonatomic, strong) NSNumber  *lastPayTime;
@property (nonatomic, copy) NSString    *end;
@property (nonatomic, copy) NSString    *now;
@property (nonatomic, strong) NSNumber  *oldTotalP;
@property (nonatomic, strong) NSNumber  *activity;
@property (nonatomic, strong) NSNumber  *subsidy;

@end
