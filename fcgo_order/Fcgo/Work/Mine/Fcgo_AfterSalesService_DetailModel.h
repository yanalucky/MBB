//
//  Fcgo_AfterSalesService_DetailModel.h
//  Fcgo
//
//  Created by huafanxiao on 2017/7/3.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fcgo_AfterSalesService_DetailModel : NSObject

@property (nonatomic,copy)  NSString *f_refund,*f_created,*f_refund_no,*f_refund_reason;
@property (nonatomic,strong) NSNumber *f_apply_id,*f_merchant_id,*f_order_goods_id,*f_order_id,*f_refund_money,*f_status,*f_real_refunmoney,*f_refund_num;
@property (nonatomic,strong) NSArray *f_refund_picurlArray;
@end
