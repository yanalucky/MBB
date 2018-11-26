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


@property (nonatomic,copy) void(^selectBlock)(NSMutableDictionary *selDic);
@property (nonatomic,copy) void(^cancelBlock)(void);
@property (nonatomic,copy) void(^addNewAddressBlock)(void);
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title isCanAddAddress:(BOOL)isAdd successBlock:(void(^)(NSMutableDictionary *selDic))selectBlock cancelBlock:(void(^)(void))cancelBlock;
-(void)showWithDataArray:(NSMutableArray *)dataArray;
@end
