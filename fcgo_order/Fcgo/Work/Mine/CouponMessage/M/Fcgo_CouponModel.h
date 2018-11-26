//
//  Fcgo_CouponModel.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/16.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fcgo_CouponModel : NSObject
/*
@property (nonatomic, strong) NSNumber *couponId;
@property (nonatomic, copy) NSString *couponName;///< 名字
@property (nonatomic, strong) NSNumber *couponType; ///< 优惠券类型
@property (nonatomic,strong) NSNumber *couponLoan; ///< 抵扣
@property (nonatomic, strong) NSNumber  *useType; ///< 使用类型
@property (nonatomic, copy) NSString    *f_end;
@property (nonatomic, copy) NSString    *useIntroduce;///< 使用条件
@property (nonatomic, copy) NSString    *canNotUseDesc;///< 不可使用原因 */

@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, copy)   NSString *useEnd;///< 名字
@property (nonatomic, strong) NSNumber *couponId; ///< 优惠券类型
@property (nonatomic, copy)   NSString *couponName;
@property (nonatomic,strong)  NSNumber *couponType; ///< 抵扣
@property (nonatomic, strong) NSNumber *useType; ///< 使用类型
@property (nonatomic, copy)   NSString *useIntroduce;
@property (nonatomic, copy)   NSNumber  *couponLoan;
@property (nonatomic, copy)   NSNumber  *couponLoanYuan;
@end
