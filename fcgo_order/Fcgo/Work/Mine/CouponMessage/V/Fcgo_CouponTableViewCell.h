//
//  Fcgo_CouponTableViewCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/26.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_CouponModel.h"
#import "Fcgo_CouponRunModel.h"

typedef enum : NSUInteger {
    CouponStatusUsedType       = 1, //待使用
    CouponStatusUnusedType     = 2, //已使用
    CouponStatusPassedUsedType = 3, //已过期
}CouponStatusType;

@interface Fcgo_CouponTableViewCell : UITableViewCell

@property (nonatomic,assign) CouponStatusType  statusType;
@property (nonatomic,strong) Fcgo_CouponModel *model;
@property (nonatomic,strong) Fcgo_CouponRunModel *runModel;

- (void)showGetBtn;
@end
