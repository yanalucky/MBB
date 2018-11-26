//
//  Fcgo_AddressView.h
//  Fcgo
//
//  Created by fcg on 2017/10/16.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_AddressModel.h"

@interface Fcgo_AddressView : UIView

@property (nonatomic,copy) void(^selectBlock)(Fcgo_AddressModel *model);
@property (nonatomic,copy) void(^cancelBlock)(void);
@property (nonatomic,copy) void(^addNewAddressBlock)(void);
@property (nonatomic, strong) NSMutableArray *dataArray;
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title isCanAddAddress:(BOOL)isAdd successBlock:(void(^)(Fcgo_AddressModel *model))selectBlock cancelBlock:(void(^)(void))cancelBlock;
- (void)show;

@end
