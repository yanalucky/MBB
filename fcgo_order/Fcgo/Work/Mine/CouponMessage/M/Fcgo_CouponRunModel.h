//
//  Fcgo_CouponRunModel.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/17.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fcgo_CouponRunModel : NSObject

/*@property (nonatomic,strong) NSString *end,*couponName,*couponNote,*f_used;//优惠券类型
@property (nonatomic,strong) NSNumber *couponLoan,*coupon_id;//优惠券状态*/

@property (nonatomic, strong) NSNumber *coupon_id; ///< 优惠券类型
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, copy)   NSNumber  *couponLoan;
@property (nonatomic, copy)   NSNumber  *couponLoanYuan;
@property (nonatomic, copy)   NSString *useEnd;///< 名字
@property (nonatomic, copy)   NSString *useIntroduce;
@property (nonatomic,strong)  NSNumber *couponType; ///< 抵扣
@property (nonatomic, strong) NSNumber *useType; ///< 使用类型
@property (nonatomic, copy)   NSString *couponName;
@property (nonatomic, copy)   NSNumber  *drawTotal;

@end
